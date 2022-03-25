CREATE OR REPLACE FUNCTION mesureActivite(p_mois int)
RETURN int
AS
  resultat int;
BEGIN
  SELECT
    e.membre INTO resultat
  FROM
    Emprunts e 
    JOIN Details d ON e.numero = d.emprunt
  WHERE
    creele > add_months(sysdate,p_mois*-1)
    AND e.membre IS NOT NULL
  GROUP BY
    e.membre
  ORDER BY
    count(*) DESC
  FETCH NEXT 1 ROWS ONLY;
  
  RETURN resultat;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20999,'Aucune donnée trouvée');
END;

SELECT
  *
FROM
  membres
WHERE
  numero = MESUREACTIVITE(3);

