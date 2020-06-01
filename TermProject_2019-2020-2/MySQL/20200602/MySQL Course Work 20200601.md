# MySQL Course Work 20200601

## MySQL安装 Linux

1. yum仓库下载MySQL：

   ```shell
   sudo yum localinstall https://repo.mysql.com//mysql80-community-release-el7-1.noarch.rpm
   ```

   

2. yum安装MySQL：

   ```shell
   sudo yum install mysql-community-server
   ```

   

3. 启动MySQL服务

   ```shell
   sudo service mysqld start
   ```

   

4. 检查MySQL服务状态

   ```shell
   sudo service mysqld status
   ```

5. 查看初始密码（如无内容直接跳过）

   ```shell
   sudo grep 'temporary password' /var/log/mysqld.log
   ```

   

6. 本地MySQL客户端登录

   ```shell
   mysql -uroot -p
   ```

   

7. 修改root登录密码

   ```mysql
   ALTER USER 'root'@'localhost' IDENTIFIED BY '密码';
   ```




## 修改MySQL默认字符集

1. 查看MySQL数据库的默认编码

   ```mysql
   status;
   ```

   

2. 使用show variables命令

   ```mysql
   show variables like 'char%';
   ```

   

3. 改变MySQL数据库的默认编码

   ```shell
   cd /etc
   vi my.cnf
   
   # 添加如下代码
   # 在[client]下追加：
   default-character-set=utf8
   # 在[mysqld]下追加：
   character-set-server=utf8
   # 在[mysql]下追加：
   default-character-set=utf8
   
   # 保存
   :wq!
   
   # 重启MySQL
   service mysql restart
   ```

4. 手工创建的数据库如未显式指定编码的数据库

   ```mysql
   alter database db_name CHARACTER SET utf8;
   ```

   

> 写出安装mysql的步骤，然后利用可视化工具，DDL 语句进行创库，创表，并且
>
> 建立表的相关的约束，
>
> tb_user
>
> userId int 主键 自增
> userName 字符串不允许为空
> userCard 身份证不允许为空，唯一
> userSex 性别
> userHeight 身高小数，（小数点保留后面两位）



```mysql
/*
 Navicat Premium Data Transfer

 Source Server         : Aliyun ECS MySQL
 Source Server Type    : MySQL
 Source Server Version : 80020
 Source Host           : bj.kevinkda.cn:3306
 Source Schema         : university

 Target Server Type    : MySQL
 Target Server Version : 80020
 File Encoding         : 65001

 Date: 01/06/2020 14:48:53
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tb_user
-- ----------------------------
DROP TABLE IF EXISTS `tb_user`;
CREATE TABLE `tb_user` (
  `userId` int NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `userName` varchar(255) NOT NULL COMMENT '用户名',
  `userCard` varchar(18) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '身份证，唯一约束',
  `userSex` varchar(1) DEFAULT NULL COMMENT '性别',
  `userHeight` double(5,2) DEFAULT NULL COMMENT '身高',
  PRIMARY KEY (`userId`) USING BTREE,
  UNIQUE KEY `userCard` (`userCard`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='MySQL Course 20200601';

SET FOREIGN_KEY_CHECKS = 1;

```

