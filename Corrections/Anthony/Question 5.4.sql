CREATE OR REPLACE PROCEDURE purgeMembres
AS
BEGIN
  DELETE
    Membres m
  WHERE 
    add_months(m.adhesion,(36+m.duree)) < sysdate;   
  COMMIT;             
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    RAISE_APPLICATION_ERROR(-20156,'Erreur lors de la purge oups');
END;

EXECUTE purgeMembres;
SELECT * FROM Membres;

