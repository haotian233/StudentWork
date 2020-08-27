/*
SQLyog Ultimate v8.32 
MySQL - 5.5.28 : Database - swctools
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`swctools` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `swctools`;

/*Table structure for table `task` */

DROP TABLE IF EXISTS `task`;

CREATE TABLE `task` (
  `taskNum` varchar(128) NOT NULL COMMENT '任务编号',
  `taskName` text NOT NULL COMMENT '任务名称',
  `taskDescribe` text NOT NULL COMMENT '任务介绍',
  `taskFileName` varchar(255) NOT NULL COMMENT '任务(附件)文件名称',
  `startTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '任务发布时间',
  `userId` int(11) NOT NULL COMMENT '教师用户id',
  PRIMARY KEY (`taskNum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `task` */

insert  into `task`(`taskNum`,`taskName`,`taskDescribe`,`taskFileName`,`startTime`,`userId`) values ('T9934433444','任务','任务','TF00944722601591978769965_Config.java','2020-06-13 00:19:29',1);

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `username` varchar(255) NOT NULL COMMENT '用户名(学生为11位学号,教师为教工编号)',
  `password` varchar(255) NOT NULL COMMENT '密码',
  `name` varchar(255) NOT NULL COMMENT '姓名',
  `status` varchar(128) NOT NULL COMMENT '状态(教师 或 学生)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `user` */

insert  into `user`(`id`,`username`,`password`,`name`,`status`) values (1,'6','6','郑大地','教师'),(2,'22222222222','2','林谢','学生'),(3,'11111111111','1','林永榉','学生');

/*Table structure for table `work` */

DROP TABLE IF EXISTS `work`;

CREATE TABLE `work` (
  `workNum` varchar(128) NOT NULL COMMENT '作业编号',
  `workName` text NOT NULL COMMENT '作业名称',
  `workAnswer` text NOT NULL COMMENT '作业内容',
  `workFileName` varchar(512) NOT NULL COMMENT '作业(附件)文件名称',
  `upTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '作业提交时间',
  `taskNum` varchar(128) NOT NULL COMMENT '任务编号',
  `userId` int(11) NOT NULL COMMENT '学生用户id',
  PRIMARY KEY (`workNum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `work` */

insert  into `work`(`workNum`,`workName`,`workAnswer`,`workFileName`,`upTime`,`taskNum`,`userId`) values ('W1617198228','44个','是否是','WF62044218961591981388612_说明.txt','2020-06-13 01:03:08','T9934433444',3),('W8512749584','不错吧','高分订购','WF24661619391591980579419_4.txt','2020-06-13 00:49:39','T9934433444',2);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
