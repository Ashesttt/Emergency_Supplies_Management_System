package com.jerryestt.springboot.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jerryestt.springboot.common.Result;
import com.jerryestt.springboot.entity.Material;
import com.jerryestt.springboot.entity.MaterialType;
import com.jerryestt.springboot.entity.Status;
import com.jerryestt.springboot.service.IMaterialService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

@RestController
@RequestMapping("/material")
public class MaterialController {

    @Resource
    private IMaterialService meterialSerivce;

    // 新增或更新
    @PostMapping
    public Result save(@RequestBody Material menu) {
        return Result.success(meterialSerivce.saveOrUpdate(menu));
    }


    // 删除
    @DeleteMapping("/{id}")
    public Result delete(@PathVariable Integer id) {
        return Result.success(meterialSerivce.removeById(id));
    }

    // 批量删除
    @PostMapping("/del/batch")
    public Result deleteBatch(@RequestBody List<Integer> ids) {
        return Result.success("成功删除" + meterialSerivce.removeByIds(ids) + "条数据");
    }

    // 查询所有数据
    @GetMapping
    public Result findAll() {
        return Result.success(meterialSerivce.list());
    }

    // id查询
    @GetMapping("/{id}")
    public Result findById(@PathVariable Integer id) {
        return Result.success(meterialSerivce.getById(id));
    }

    // 分页查询
    @GetMapping("/page")
    public Result findPage(@RequestParam Integer pageNum,
                           @RequestParam Integer pageSize,
                           @RequestParam(defaultValue = "") String materialName,
                           @RequestParam(defaultValue = "") String materialType,
                           @RequestParam(defaultValue = "") String status) {

        IPage<Material> page = new Page<>(pageNum, pageSize);
        QueryWrapper<Material> queryWrapper = new QueryWrapper<>();

        /**
         * 模糊查询
         * */
        if (!"".equals(materialName)) {// materialName
            queryWrapper.like("material_name", materialName);
        }
        if (!"".equals(materialType)) {// materialType
            queryWrapper.like("material_type", materialType);
        }
        if (!"".equals(status)) {// status
            queryWrapper.like("status", status);
        }


        return Result.success(meterialSerivce.page(page, queryWrapper));
    }

    // 获取所有的物资类型
    @GetMapping("/materialType")
    public Result findAllmaterialType() {
        MaterialType[] materialTypes = MaterialType.values();
        return Result.success(materialTypes);
    }

    // 获取所有的物资状态
    @GetMapping("/status")
    public Result findAllstatus() {
        Status[] status = Status.values();
        return Result.success(status);
    }


}
    
