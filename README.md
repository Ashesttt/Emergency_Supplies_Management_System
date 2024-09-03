# 应急救援装备管理系统教程

本教程将指导您如何设置和运行应急救援装备管理系统。

## 介绍

一个基于SpringBoot，Vue，Element的应急救援装备管理系统

## 快速开始

>目前仅支持mysql

1.首先，创建一个新的数据库 `emergency_material_manage` 并使用它。

```sql
create database emergency_material_manage；
use emergency_material_manage；
```

2.将`sql_0504.sql`文件导入到数据库中。请确保您已将该文件放置在正确的路径中。

```bash
source /Emergency_Supplies_Management_System/sql_0504.sql;
```

3.进入项目，复制后端示例配置文件，并编辑配置文件，填写数据库密码。

>修改以下内容：
>spring.datasource.password（数据库的密码）

```bash
cd Emergency_Supplies_Management_System/src/main/resources
cp application.yaml.example application.yaml
vim application.yaml
```

4.编辑环境文件，换成您服务器的外网ip和后端的端口

>VUE_APP_API_BASE_URL

```bash
vim Emergency_Supplies_Management_System/vue/.env
```

5.使用 Maven 构建后端 Spring Boot 项目。

```bash
mvn -X clean install
mvn package
```

6.使用以下命令启动后端项目。

```bash
cd target
java -jar SpringBoot-0.0.1-SNAPSHOT.jar
```

7.进入前端项目的目录，并安装所需的依赖项。

```bash
cd /Emergency_Supplies_Management_System/vue
npm install
```

8.启动前端项目

```bash
npm run serve
```

##支持的功能

- [x] 1


## 贡献者
***Thanks to the following people who have contributed to this project:***

[![Contributors](https://contrib.rocks/image?repo=Ashesttt/Emergency_Supplies_Management_System)](https://github.com/Ashesttt/Emergency_Supplies_Management_System/graphs/contributors)
