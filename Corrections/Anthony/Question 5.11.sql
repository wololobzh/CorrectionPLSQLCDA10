CREATE OR REPLACE PROCEDURE empruntExpress(p_membre int,p_isbn int, p_ex int)
IS
BEGIN
  INSERT INTO Emprunts VALUES (seq_emprunt.nextval,p_membre,sysdate,'EC');
  INSERT INTO Details VALUES (seq_emprunt.currval,1,p_isbn,p_ex,null);
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    RAISE_APPLICATION_ERROR(-20123,'empruntExpress impossible');
END;

SELECT * FROM Emprunts
SELECT * FROM Details

CREATE SEQUENCE seq_emprunt START WITH 3000;
