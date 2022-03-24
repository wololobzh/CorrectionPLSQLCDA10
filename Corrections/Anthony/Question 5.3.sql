CREATE OR REPLACE PROCEDURE retourExemplaire(p_isbn int,p_exemplaire int)
AS
BEGIN
  UPDATE details SET rendule = sysdate WHERE isbn = p_isbn AND p_exemplaire = exemplaire;
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    RAISE_APPLICATION_ERROR(-20540,'Erreur lors du retour de l''exemplaire');  
END;

SELECT * FROM details;

EXECUTE retourExemplaire(2080720872,4);

