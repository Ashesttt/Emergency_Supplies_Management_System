# 本地部署

>目前仅支持mysql

1. 首先，创建一个新的数据库 `emergency_material_manage` 并使用它。

```sql
create database emergency_material_manage；
use emergency_material_manage；
```

2. 将`emergency_material_manage.sql`文件导入到数据库中。请确保您已将该文件放置在正确的路径中。

```bash
source /Emergency_Supplies_Management_System/emergency_material_manage.sql;
```

3. 进入项目，复制后端示例配置文件，并编辑配置文件，填写数据库密码。

>修改以下内容：
>spring.datasource.password（数据库的密码）
>
>api.base-url(您的后端地址，即服务器公网ip+后端端口，默认是9091)

```bash
cd Emergency_Supplies_Management_System/src/main/resources
cp application.yaml.example application.yaml
vim application.yaml
```

4. 编辑环境文件，换成您的服务器公网ip+后端端口，默认是9091

>VUE_APP_API_BASE_URL
>
>其中上边的api.base-url和这个一样

```bash
vim Emergency_Supplies_Management_System/vue/.env
```

5. 使用 Maven 构建后端 Spring Boot 项目。

```bash
mvn -X clean install
mvn package
```

6. 使用以下命令启动后端项目。

```bash
cd target
java -jar SpringBoot-0.0.1-SNAPSHOT.jar
```

7. 进入前端项目的目录，并安装所需的依赖项。

```bash
cd /Emergency_Supplies_Management_System/vue
npm install
```

8. 启动前端项目

```bash
npm run serve
```

