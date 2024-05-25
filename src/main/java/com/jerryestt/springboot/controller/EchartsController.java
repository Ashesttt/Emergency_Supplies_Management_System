package com.jerryestt.springboot.controller;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.date.Quarter;
import com.jerryestt.springboot.common.Result;
import com.jerryestt.springboot.entity.Material;
import com.jerryestt.springboot.entity.User;
import com.jerryestt.springboot.mapper.MaterialMapper;
import com.jerryestt.springboot.mapper.UserMapper;
import com.jerryestt.springboot.service.IMaterialService;
import com.jerryestt.springboot.service.IUserService;
import lombok.Data;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.*;

@RestController
@RequestMapping("/echarts")
public class EchartsController {

    @Resource
    private IUserService userService;

    @Resource
    private UserMapper userMapper;

    @Resource
    private MaterialMapper materialMapper;

    @Resource
    private IMaterialService materialService;

    @GetMapping("/example")
    public Result get() {
        Map<String, Object> map = new HashMap<>();
        map.put("x", CollUtil.newArrayList("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"));
        map.put("y", CollUtil.newArrayList(150, 230, 224, 218, 135, 147, 260));
        return Result.success(map);
    }

    @GetMapping("/members")
    public Result members() {
        List<User> list = userService.list();
        int q1 = 0; // 第一季度
        int q2 = 0; // 第二季度
        int q3 = 0; // 第三季度
        int q4 = 0; // 第四季度 
        for (User user : list) {
            Date createTime = user.getCreateTime();// 创建时间
            Quarter quarter = DateUtil.quarterEnum(createTime);// 季度
            switch (quarter) {
                case Q1:
                    q1 += 1;
                    break;
                case Q2:
                    q2 += 1;
                    break;
                case Q3:
                    q3 += 1;
                    break;
                case Q4:
                    q4 += 1;
                    break;
                default:
                    break;
            }
        }
        return Result.success(CollUtil.newArrayList(q1, q2, q3, q4));
    }

    // 获取总人数
    @GetMapping("/totleUser")
    public Result getTotleUser() {
        return Result.success(userMapper.getTotleUser());
    }

    // 获取装备总数
    @GetMapping("/totleMaterial")
    public Result getTotleMaterial() {
        return Result.success(materialMapper.getTotleMaterial());
    }

    // 获取装备不同类型的数量
    // 定义 MaterialDTO 类
    @Data
    public class MaterialDTO {
        private String materialType;
        private int quantity;

        public MaterialDTO(String materialType, int quantity) {
            this.materialType = materialType;
            this.quantity = quantity;
        }
        
    }

    @GetMapping("/typeMaterial")
    public Result getTypeMaterial() {
        // 从服务中获取材料列表
        List<Material> materials = materialService.list();

        // 创建一个 HashMap 来存储材料类型计数
        Map<String, Integer> materialTypeCounts = new HashMap<>();

        // 遍历材料列表
        for (Material material : materials) {
            String materialType = String.valueOf(material.getMaterialType());

            // 检查材料类型是否存在于映射中
            if (materialTypeCounts.containsKey(materialType)) {
                // 增加现有材料类型的计数
                materialTypeCounts.put(materialType, materialTypeCounts.get(materialType) + material.getQuantity());
            } else {
                // 将新的材料类型及其计数添加到映射中
                materialTypeCounts.put(materialType, material.getQuantity());
            }
        }

        // 将材料类型计数转换为 MaterialDTO 对象列表
        List<MaterialDTO> materialDTOs = new ArrayList<>();
        for (Map.Entry<String, Integer> entry : materialTypeCounts.entrySet()) {
            materialDTOs.add(new MaterialDTO(entry.getKey(), entry.getValue()));
        }

        // 返回 MaterialDTO 对象列表作为成功结果
        return Result.success(materialDTOs);
    }

}
