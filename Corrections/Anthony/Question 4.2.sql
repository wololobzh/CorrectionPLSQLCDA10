--4.2
DECLARE
CURSOR curseur IS SELECT
  *
FROM
  membres
WHERE
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
END;