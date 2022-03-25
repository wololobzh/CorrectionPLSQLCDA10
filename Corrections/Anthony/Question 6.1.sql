CREATE OR REPLACE TRIGGER stop_aux_emprunts_cassants 
BEFORE INSERT ON Emprunts
FOR EACH ROW
BEGIN
  IF(fin_validite(:NEW.membre)<sysdate) THEN
    RAISE_APPLICATION_ERROR(-20156,'Le membre n''est pas a jour');
  END IF;
END;

/*UPDATE membres SET adhesion=sysdate-3000 WHERE numero = 10;
SELECT * FROM membres
SELECT * FROM emprunts
INSERT INTO emprunts VALUES (seq_emprunt.nextval,10,sysdate,'EC');*/



