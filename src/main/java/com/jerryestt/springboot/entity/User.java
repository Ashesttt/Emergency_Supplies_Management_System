package com.jerryestt.springboot.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import java.util.Date;
import java.io.Serializable;


@Data
@TableName(value = "user_info")
public class User implements Serializable {

    /**
     * 为什么user_id会返回null:
     * 在MyBatis Plus中，如果数据库表的主键字段名和实体类的属性名不一致
     * ，需要使用@TableField注解来显式指定映射关系。  在你的情况下，数据
     * 库表的主键字段可能是user_id，但在Java中，按照命名规范，属性名应该是
     * userId，而不是user_id。因此，你需要将User实体类中的user_id字段名
     * 改为userId，并使用@TableField注解来指定其映射到数据库表的user_id字段。
     */
    @TableId(type = IdType.AUTO)//指定自增策略
    @TableField(value = "user_id")
    private Integer userId;
    private String username;

    //管理员可以查看用户的密码，所以不需要加上@JsonIgnore
    //    @JsonIgnore
    private String password;

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public User_Role getUserRole() {
        return userRole;
    }

    public void setUserRole(User_Role userRole) {
        this.userRole = userRole;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }


    @TableField(value = "role")
    private User_Role userRole;
    private String email;
    private String phone;
    private String address;

    @TableField(value = "create_time")
//    private String createTime;
    private Date createTime;  
    private String avatarurl;
}
