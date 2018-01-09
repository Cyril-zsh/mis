--查看回收站中表
--select object_name,original_name,partition_name,type,ts_name,createtime,droptime from recyclebin
--where original_name = 'QB_T_QUESTION_TYPE';

--恢复表（注：必须9i或10g以上版本支持，flashback无法恢复全文索引）
--flashback table ALS_T_EXAM_STUDENT to before drop;
--flashback table "BIN$T2JkO8VGRMer56HdKu7Ktw==$0" to before drop;

--备份表
--create table QB_T_QUESTION_TYPE_new_2 as select * from QB_T_QUESTION_TYPE;

--查询表空间文件所在路径
--select * from dba_data_files;
--select * from dba_temp_files;

--查询表空间使用情况
/*
select upper(f.tablespace_name) "表空间名",
       d.tot_grootte_mb "表空间大小(m)",
       d.tot_grootte_mb - f.total_bytes "已使用空间(m)",
       to_char(round((d.tot_grootte_mb - f.total_bytes) / d.tot_grootte_mb * 100, 2), '990.99') || '%' "使用比",
       f.total_bytes "空闲空间(m)",
       f.max_bytes "最大块(m)"
  from (select tablespace_name,
               round(sum(bytes) / (1024 * 1024), 2) total_bytes,
               round(max(bytes) / (1024 * 1024), 2) max_bytes
          from sys.dba_free_space
         group by tablespace_name) f,
       (select dd.tablespace_name,
               round(sum(dd.bytes) / (1024 * 1024), 2) tot_grootte_mb
          from sys.dba_data_files dd
         group by dd.tablespace_name) d
 where d.tablespace_name = f.tablespace_name
 order by 1;
*/

--查看scott用户的默认表空间、临时表空间
/*
select username, default_tablespace, temporary_tablespace
  from dba_users
 where username = 'JW';
*/

--查看scott用户的系统权限
/*
select * from dba_tab_privs where owner = 'ALS';
select * from user_tab_privs where owner = 'ALS';
select * from dba_sys_privs;
select * from user_sys_privs where username='ALS';
select * from dba_role_privs where grantee='ALS';
select * from user_role_privs where username='ALS';
select username, privilege, admin_option
  from user_sys_privs
 where username = 'JW';
*/


----------------------------- oracle 创建表空间和用户 start -----------------------------------
--1：创建临时表空间
/*
create temporary tablespace user_temp  
tempfile 'Q:\oracle\product\10.2.0\oradata\Test\xyrj_temp.dbf' 
size 50m  
autoextend on  
next 50m maxsize 20480m  
extent management local;
*/

--2：创建数据表空间
/*
create tablespace TBS_UIM  
logging  
datafile 'd:\app\administrator\oradata\orcl\TBS_UIM.dbf' 
size 256m  
autoextend on  
next 50m maxsize 2048m  
extent management local;
*/

--3：创建用户并指定表空间
/*
create user frame identified by frame  
default tablespace TBS_UIM  
temporary tablespace TEMP;
*/  
 
--4：给用户授予权限
--grant connect, resource, dba to frame;

----------------------------- oracle 创建表空间和用户 end -----------------------------------

----------------------------- oracle 数据库备份及导入 start -----------------------------------
-------- exp数据导出：
--1 将数据库TEST完全导出,用户名system 密码manager 导出到D:\daochu.dmp中 
--exp system/manager@TEST file=d:\daochu.dmp full=y
--exp jw/jw@172.29.140.123:1521/yqdb file=d:\yq.dmp full=y 

--2 将数据库中system用户与sys用户的表导出 
--exp system/manager@TEST file=d:\daochu.dmp owner=(system,sys) 

--3 将数据库中的表inner_notify、notify_staff_relat导出 
--exp aichannel/aichannel@TESTDB2 file= d:\data\newsmgnt.dmp tables=(inner_notify,notify_staff_relat) 

--4 将数据库中的表table1中的字段filed1以"00"打头的数据导出 
--exp system/manager@TEST file=d:\daochu.dmp tables=(table1) query=\" where filed1 like '00%'\" 
 
-------- imp数据导入：
--1 将D:\daochu.dmp 中的数据导入 TEST数据库中。 
--imp system/manager@TEST file=d:\daochu.dmp 
--有的表已经存在，然后它就报错，对该表就不进行导入。在后面加上 ignore=y 就可以了
--imp aichannel/aichannel@HUST full=y file=file= d:\data\newsmgnt.dmp ignore=y 

--2 将d:\daochu.dmp中的表table1 导入 
--imp system/manager@TEST file=d:\daochu.dmp tables=(table1) 


--expdp/impdp
--1.登录 （cmd命令）
--sqlplus xj/xj@192.130.11.10:1521/yqdb

--SQL> create directory dir as '/home/oracle/';
--SQL> grant read,write on directory dir to jw; --用其他dba用户将权限赋予jw

--导出jw用户数据 （cmd 命令）
--expdp jw/jw@192.130.11.10:1521/yqdb directory=dir dumpfile=data.dmp schemas=jw logfile=data.log

--导入jw用户所有数据到xj，并且转换表空间jw为xj（cmd 命令）
--impdp system/oracle directory=dir dumpfile=data.dmp remap_tablespace=JW_DATA:TBS_XJ remap_schema=JW:XJ logfile=data.log

----------------------------- oracle 数据库备份及导入 end -----------------------------------











