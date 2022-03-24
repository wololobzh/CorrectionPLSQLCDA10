DECLARE
  CURSOR curseur IS SELECT * FROM membres WHERE
    months_between(sysdate, add_months(adhesion, duree)) > 24;
  total_non_rendu int;
BEGIN
  FOR item IN curseur LOOP
    SELECT
      count(*) INTO total_non_rendu
    FROM
      Emprunts e
      JOIN Details d ON e.numero = d.emprunt
    WHERE
      rendule IS NULL
      AND membre = item.numero;
    IF (total_non_rendu = 0) THEN
      DELETE Membres WHERE numero = item.numero;
    END IF;
  END LOOP;
  COMMIT;--Si tout va bien on commit
EXCEPTION
  WHEN OTHERS THEN --Quelle que soit l'erreur. 
	--On annule toutes les modifications.
    ROLLBACK; 
	--On informe que le bloc n'a pas pu faire son travail.
    RAISE_APPLICATION_ERROR(-20150,'Erreur lors de la suppression des membres non adherents'); 
END;



  

  
