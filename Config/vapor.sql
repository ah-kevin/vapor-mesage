/*
 Navicat Premium Data Transfer

 Source Server         : 本地mysql
 Source Server Type    : MySQL
 Source Server Version : 50715
 Source Host           : localhost
 Source Database       : vapor

 Target Server Type    : MySQL
 Target Server Version : 50715
 File Encoding         : utf-8

 Date: 05/15/2017 17:36:38 PM
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `fluent`
-- ----------------------------
DROP TABLE IF EXISTS `fluent`;
CREATE TABLE `fluent` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `fluent`
-- ----------------------------
BEGIN;
INSERT INTO `fluent` VALUES ('1', 'Participant'), ('2', 'Message'), ('3', 'Thread'), ('4', 'User');
COMMIT;

-- ----------------------------
--  Table structure for `messages`
-- ----------------------------
DROP TABLE IF EXISTS `messages`;
CREATE TABLE `messages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `threadId` int(11) NOT NULL,
  `participantId` int(11) NOT NULL,
  `text` varchar(255) NOT NULL,
  `timestamp` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `messages`
-- ----------------------------
BEGIN;
INSERT INTO `messages` VALUES ('1', '1', '1', 'Did you take take out the trash today ?', '1494836017'), ('2', '1', '2', 'Is it full again ?', '1494836040'), ('3', '1', '1', 'Yes, can you take it out now ?', '1494836053'), ('4', '1', '2', 'OK, no problem', '1494836061'), ('5', '1', '1', 'Great', '1494836071'), ('6', '2', '1', 'This living room is a disaster, clean this up kids ! ', '1494836081'), ('7', '2', '3', 'Wasn\\\'t me Mom !', '1494836089'), ('8', '2', '4', 'Me neither Mom !', '1494836097'), ('9', '2', '4', 'Really ! ', '1494836103'), ('10', '2', '1', 'OK kids thats enough, tidy up the living room now please  ! ', '1494836112'), ('11', '3', '1', 'Everyone come to the table, dinner is ready', '1494836120'), ('12', '3', '3', 'No dad Im watching this cartoon its not over yet', '1494836127'), ('13', '3', '4', 'No Mom we want to keep watching TV too its my favorite show', '1494836134'), ('14', '3', '5', 'gaaaggggaaaaaaaaaa mhmaam mhaammmm mmaaammaaa paaappppaaaaa', '1494836141'), ('15', '3', '1', 'Maybe later, I\\\'m not hungry ', '1494836152'), ('16', '3', '1', 'Let\\\'s go everyone, put that on pause and come to the table, the dinner will be cold', '1494836160');
COMMIT;

-- ----------------------------
--  Table structure for `participants`
-- ----------------------------
DROP TABLE IF EXISTS `participants`;
CREATE TABLE `participants` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `participants`
-- ----------------------------
BEGIN;
INSERT INTO `participants` VALUES ('1', 'Alice'), ('2', 'Bob'), ('3', 'Chuck'), ('4', 'David'), ('5', 'Erin');
COMMIT;

-- ----------------------------
--  Table structure for `threads`
-- ----------------------------
DROP TABLE IF EXISTS `threads`;
CREATE TABLE `threads` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `threadId` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `threads`
-- ----------------------------
BEGIN;
INSERT INTO `threads` VALUES ('1', '1'), ('2', '2'), ('3', '3');
COMMIT;

-- ----------------------------
--  Table structure for `users`
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `users`
-- ----------------------------
BEGIN;
INSERT INTO `users` VALUES ('1', '123123', 'ke', '2123', '12312312'), ('2', '123123', 'ke', '2123', '12312312'), ('3', '123123', 'ke', '2123', '12312312');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
