--3.9

ALTER TABLE membres DROP constraint ck_membres_mobile; 

-- La nouvelle contrainte implique que la taille de la colonne devienne 14
alter table membres modify (mobile char(14));

/*
 Modification des numeros presents en base pour qu'il soient
 bien formés pour ne pas violer la nouvelle contrainte.
*/
update membres 
set mobile = 
  concat(substr(mobile,1,2) , 
  concat(' ', 
  concat(substr(mobile,3,2) , 
  concat(' ', 
  concat(substr(mobile,5,2) , 
  concat(' ', 
  concat(substr(mobile,7,2), 
  concat(' ', substr(mobile,9,2)
  ))))))))
;

drop table exceptions;
create table exceptions(row_id rowid,
	                owner varchar2(30),
	                table_name varchar2(30),
		        constraint_name varchar2(30));

-- la suite de la correction de l'exercice
ALTER TABLE membres add constraint ck_membres_mobile check (regexp_like (mobile, '^06 [[:digit:]]{2} [[:digit:]]{2} [[:digit:]]{2} [[:digit:]]{2}$')) EXCEPTIONS INTO EXCEPTIONS;

SELECT * FROM membres WHERE rowid IN (SELECT row_id FROM exceptions WHERE constraint_name='CK_MEMBRES_MOBILE');

DELETE FROM exceptions WHERE constraint_name ='CK_MEMBRES_MOBILE';

commit;

--3.10
ALTER TABLE emprunts DROP CONSTRAINT fk_emprunts_membres;
ALTER TABLE emprunts ADD
CONSTRAINT fk_emprunts_membres 
FOREIGN KEY (membre) REFERENCES membres(numero)
INITIALLY DEFERRED;