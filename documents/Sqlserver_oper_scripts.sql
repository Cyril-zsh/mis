----------------------------------- sql server --------------------------------------------------------
--索引操作
Exec sp_helpindex BigData   --查看索引定义

Exec sp_rename 'BigData.idx_mobiel','idx_big_mobiel'  --将索引名由'idx_mobiel' 改为'idx_big_mobiel'

drop index BigData.idx_big_mobiel  --删除bigdata表中的idx_big_mobiel索引

dbcc showcontig(bigdata,idx_mobiel) --检查bigdata表中索引idx_mobiel的碎片信息

dbcc indexdefrag(Test,bigdata,idx_mobiel)  --整理test数据库中bigdata表的索引idx_mobiel上的碎片

update statistics bigdata  --更新bigdata表中的全部索引的统计信息
EXEC dbo.sp_updatestats

--update where
update a set a.SOCRE = b.c, a.DISCIPLIN_NICK = d.DISCIPLIN_ID
  from ALS_T_STUDENT_EXTEND a, temp_zsh b, ALS_T_EXAM_STUDENT c, ALS_T_DISCIPLIN d
 where a.STUDENT_ID = c.STUDENT_ID 
   and c.TEST_CARD_CODE = b.a
   and d.DISCIPLIN_NICK = b.b
   and c.EXAM_ID = '25';

--查看锁表
select request_session_id spid,
	   OBJECT_NAME(resource_associated_entity_id) tableName   
  from sys.dm_tran_locks 
 where resource_type='OBJECT'

--获取字符串中第一个数字12
select stuff(
			stuff('单选12_3', 1, patindex('%[0-9, .]%', '单选12_3') - 1, ''),
			patindex('%[^0-9, .]%', stuff('单选12_3', 1, patindex('%[0-9, .]%', '单选12_3') - 1, '')),
			len('单选12_3'), 
			'')

--截取字段
select substring('单选12_3',PATINDEX ('%[0-9]%', '单选12_3'),1)