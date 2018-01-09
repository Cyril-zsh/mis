--�鿴����վ�б�
--select object_name,original_name,partition_name,type,ts_name,createtime,droptime from recyclebin
--where original_name = 'QB_T_QUESTION_TYPE';

--�ָ���ע������9i��10g���ϰ汾֧�֣�flashback�޷��ָ�ȫ��������
--flashback table ALS_T_EXAM_STUDENT to before drop;
--flashback table "BIN$T2JkO8VGRMer56HdKu7Ktw==$0" to before drop;

--���ݱ�
--create table QB_T_QUESTION_TYPE_new_2 as select * from QB_T_QUESTION_TYPE;

--��ѯ��ռ��ļ�����·��
--select * from dba_data_files;
--select * from dba_temp_files;

--��ѯ��ռ�ʹ�����
/*
select upper(f.tablespace_name) "��ռ���",
       d.tot_grootte_mb "��ռ��С(m)",
       d.tot_grootte_mb - f.total_bytes "��ʹ�ÿռ�(m)",
       to_char(round((d.tot_grootte_mb - f.total_bytes) / d.tot_grootte_mb * 100, 2), '990.99') || '%' "ʹ�ñ�",
       f.total_bytes "���пռ�(m)",
       f.max_bytes "����(m)"
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

--�鿴scott�û���Ĭ�ϱ�ռ䡢��ʱ��ռ�
/*
select username, default_tablespace, temporary_tablespace
  from dba_users
 where username = 'JW';
*/

--�鿴scott�û���ϵͳȨ��
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


----------------------------- oracle ������ռ���û� start -----------------------------------
--1��������ʱ��ռ�
/*
create temporary tablespace user_temp  
tempfile 'Q:\oracle\product\10.2.0\oradata\Test\xyrj_temp.dbf' 
size 50m  
autoextend on  
next 50m maxsize 20480m  
extent management local;
*/

--2���������ݱ�ռ�
/*
create tablespace TBS_UIM  
logging  
datafile 'd:\app\administrator\oradata\orcl\TBS_UIM.dbf' 
size 256m  
autoextend on  
next 50m maxsize 2048m  
extent management local;
*/

--3�������û���ָ����ռ�
/*
create user frame identified by frame  
default tablespace TBS_UIM  
temporary tablespace TEMP;
*/  
 
--4�����û�����Ȩ��
--grant connect, resource, dba to frame;

----------------------------- oracle ������ռ���û� end -----------------------------------

----------------------------- oracle ���ݿⱸ�ݼ����� start -----------------------------------
-------- exp���ݵ�����
--1 �����ݿ�TEST��ȫ����,�û���system ����manager ������D:\daochu.dmp�� 
--exp system/manager@TEST file=d:\daochu.dmp full=y
--exp jw/jw@172.29.140.123:1521/yqdb file=d:\yq.dmp full=y 

--2 �����ݿ���system�û���sys�û��ı��� 
--exp system/manager@TEST file=d:\daochu.dmp owner=(system,sys) 

--3 �����ݿ��еı�inner_notify��notify_staff_relat���� 
--exp aichannel/aichannel@TESTDB2 file= d:\data\newsmgnt.dmp tables=(inner_notify,notify_staff_relat) 

--4 �����ݿ��еı�table1�е��ֶ�filed1��"00"��ͷ�����ݵ��� 
--exp system/manager@TEST file=d:\daochu.dmp tables=(table1) query=\" where filed1 like '00%'\" 
 
-------- imp���ݵ��룺
--1 ��D:\daochu.dmp �е����ݵ��� TEST���ݿ��С� 
--imp system/manager@TEST file=d:\daochu.dmp 
--�еı��Ѿ����ڣ�Ȼ�����ͱ����Ըñ�Ͳ����е��롣�ں������ ignore=y �Ϳ�����
--imp aichannel/aichannel@HUST full=y file=file= d:\data\newsmgnt.dmp ignore=y 

--2 ��d:\daochu.dmp�еı�table1 ���� 
--imp system/manager@TEST file=d:\daochu.dmp tables=(table1) 


--expdp/impdp
--1.��¼ ��cmd���
--sqlplus xj/xj@192.130.11.10:1521/yqdb

--SQL> create directory dir as '/home/oracle/';
--SQL> grant read,write on directory dir to jw; --������dba�û���Ȩ�޸���jw

--����jw�û����� ��cmd ���
--expdp jw/jw@192.130.11.10:1521/yqdb directory=dir dumpfile=data.dmp schemas=jw logfile=data.log

--����jw�û��������ݵ�xj������ת����ռ�jwΪxj��cmd ���
--impdp system/oracle directory=dir dumpfile=data.dmp remap_tablespace=JW_DATA:TBS_XJ remap_schema=JW:XJ logfile=data.log

----------------------------- oracle ���ݿⱸ�ݼ����� end -----------------------------------











