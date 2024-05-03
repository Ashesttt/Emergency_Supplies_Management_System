package com.jerryestt.springboot.controller;


import cn.hutool.core.io.FileUtil;
import cn.hutool.core.util.IdUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.crypto.SecureUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jerryestt.springboot.common.Result;
import com.jerryestt.springboot.entity.Files;
import com.jerryestt.springboot.mapper.FileMapper;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;


/**
 * 文件上传相关接口
 */
@RestController
@RequestMapping("/file")
public class FileController {

    @Value("${files.upload.path}")
    private String fileUploadPath;

    @Resource
    private FileMapper fileMapper;

    /**
     * 文件上传接口
     *
     * @param file 前端传递过来的文件
     * @return
     * @throws IOException 引入MD5工具类，计算文件的MD5值，用于判断文件是否重复
     */
    @PostMapping("/upload")
    public String upload(@RequestParam MultipartFile file) throws IOException {
        String originalFilename = file.getOriginalFilename();// 获取文件名
        String type = FileUtil.extName(originalFilename);// 获取文件后缀
        long size = file.getSize();// 获取文件大小

        // 定义一个文件唯一的标识码
        String uuid = IdUtil.fastSimpleUUID();
        String fileUUID = uuid + StrUtil.DOT + type;

        File uploadFile = new File(fileUploadPath + fileUUID);// 上传文件的路径
        // 判断配置的文件目录是否存在，若不存在则创建一个新的文件目录
        File parentFile = uploadFile.getParentFile();// 获取父目录
        if (!parentFile.exists()) {
            parentFile.mkdirs();
        }


        String url;// 文件的访问路径
        // 获取文件的md5
        // 要用文件的输入流来计算文件的MD5值，md5才是对于一个文件来说是唯一的值
        String md5 = SecureUtil.md5(file.getInputStream());//getInputStream()获取文件的输入流
        // 从数据库查询是否存在相同的记录
        Files dbFiles = getFileByMd5(md5);
        if (dbFiles != null) { // 文件已存在
            url = dbFiles.getUrl();
        } else {
            // 上传文件到磁盘
            file.transferTo(uploadFile);
            // 数据库若不存在重复文件，则不删除刚才上传的文件
            url = "http://localhost:9090/file/" + fileUUID;
        }

        // 存储数据库
        Files saveFile = new Files();
        saveFile.setFilename(originalFilename);
        saveFile.setType(type);
        saveFile.setSize(size / 1024);
        saveFile.setUrl(url);
        saveFile.setMd5(md5);
        fileMapper.insert(saveFile);// 将文件信息存储到数据库
//
        return url;
    }


    /**
     * 通过文件的md5查询文件
     *
     * @param md5
     * @return
     */
    private Files getFileByMd5(String md5) {
        // 查询文件的md5是否存在
        QueryWrapper<Files> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("md5", md5);
        List<Files> filesList = fileMapper.selectList(queryWrapper);
        return filesList.isEmpty() ? null : filesList.get(0);// 返回第一个文件
    }


    /**
     * 文件下载接口   http://localhost:9090/file/{fileUUID}
     *
     * @param fileUUID
     * @param response
     * @throws IOException
     */
    @GetMapping("/{fileUUID}")
    public void download(@PathVariable String fileUUID, HttpServletResponse response) throws IOException {
        // 根据文件的唯一标识码获取文件
        File uploadFile = new File(fileUploadPath + fileUUID);
        // 设置输出流的格式
        ServletOutputStream os = response.getOutputStream();
        response.addHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(fileUUID, "UTF-8"));// 设置下载的文件名
        response.setContentType("application/octet-stream");// 二进制流

        // 读取文件的字节流
        os.write(FileUtil.readBytes(uploadFile));
        os.flush();
        os.close();
    }


    /**
     * 更新
     */
    @PostMapping("/update")
    public Result save(@RequestBody Files files) {
        return Result.success(fileMapper.updateById(files));
    }


    /**
     * 删除
     */
    @DeleteMapping("/{id}")
    public Result delete(@PathVariable Integer id) {
        Files files = fileMapper.selectById(id);
//        boolean isDelete_status = files.getIs_delete();
//        System.out.println(isDelete_status);
        files.setIs_delete(true);// 设置为删除状态
        fileMapper.updateById(files);// 更新数据库
        return Result.success("成功假删除");
    }


    /**
     * 批量删除
     */
    @PostMapping("/del/batch")
    public Result deleteBatch(@RequestBody List<Integer> ids) {
        QueryWrapper<Files> queryWrapper = new QueryWrapper<>();
        queryWrapper.in("file_id", ids);
        List<Files> filesList = fileMapper.selectList(queryWrapper);
        int count = 0;
        for (Files files : filesList) {
            files.setIs_delete(true);// 设置为删除状态
            fileMapper.updateById(files);
            count++;
        }
        return Result.success("成功假删除" + count + "条数据");
    }


    /**
     * 分页查询--mybatis-plus
     */
    @GetMapping("/page")
    public Result findPage(@RequestParam Integer pageNum,
                           @RequestParam Integer pageSize,
                           @RequestParam(defaultValue = "") String filename,
                           @RequestParam(defaultValue = "") String type,
                           @RequestParam(defaultValue = "") String is_delete,
                           @RequestParam(defaultValue = "") String enable) {

        IPage<Files> page = new Page<>(pageNum, pageSize);
        QueryWrapper<Files> queryWrapper = new QueryWrapper<>();

        /**
         * 模糊查询
         * */
        if (!"".equals(filename)) {// 如果username不为空
            queryWrapper.like("filename", filename);
        }
        if (!"".equals(type)) {
            queryWrapper.like("type", type);
        }
        if (!"".equals(is_delete)) {
            queryWrapper.like("is_delete", is_delete);
        }
        if (!"".equals(enable)) {
            queryWrapper.like("enable", enable);
        }

        return Result.success(fileMapper.selectPage(page, queryWrapper));
    }
}
