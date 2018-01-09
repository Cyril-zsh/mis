----------------------------------- sql server --------------------------------------------------------
--��������
Exec sp_helpindex BigData   --�鿴��������

Exec sp_rename 'BigData.idx_mobiel','idx_big_mobiel'  --����������'idx_mobiel' ��Ϊ'idx_big_mobiel'

drop index BigData.idx_big_mobiel  --ɾ��bigdata���е�idx_big_mobiel����

dbcc showcontig(bigdata,idx_mobiel) --���bigdata��������idx_mobiel����Ƭ��Ϣ

dbcc indexdefrag(Test,bigdata,idx_mobiel)  --����test���ݿ���bigdata�������idx_mobiel�ϵ���Ƭ

update statistics bigdata  --����bigdata���е�ȫ��������ͳ����Ϣ
EXEC dbo.sp_updatestats

--update where
update a set a.SOCRE = b.c, a.DISCIPLIN_NICK = d.DISCIPLIN_ID
  from ALS_T_STUDENT_EXTEND a, temp_zsh b, ALS_T_EXAM_STUDENT c, ALS_T_DISCIPLIN d
 where a.STUDENT_ID = c.STUDENT_ID 
   and c.TEST_CARD_CODE = b.a
   and d.DISCIPLIN_NICK = b.b
   and c.EXAM_ID = '25';

--�鿴����
select request_session_id spid,
	   OBJECT_NAME(resource_associated_entity_id) tableName   
  from sys.dm_tran_locks 
 where resource_type='OBJECT'

--��ȡ�ַ����е�һ������12
select stuff(
			stuff('��ѡ12_3', 1, patindex('%[0-9, .]%', '��ѡ12_3') - 1, ''),
			patindex('%[^0-9, .]%', stuff('��ѡ12_3', 1, patindex('%[0-9, .]%', '��ѡ12_3') - 1, '')),
			len('��ѡ12_3'), 
			'')

--��ȡ�ֶ�
select substring('��ѡ12_3',PATINDEX ('%[0-9]%', '��ѡ12_3'),1)