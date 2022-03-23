DECLARE
  CURSOR curseur IS SELECT
    m.numero,
    m.nom,
    count(*) total
  FROM
    Membres m
    JOIN Emprunts e ON m.numero = e.membre
    JOIN Details d ON e.numero = d.emprunt
  WHERE
    e.creele > add_months(sysdate, -10)
  GROUP BY
    m.numero,
    m.nom
  ORDER BY 
    total DESC
  FETCH NEXT 3 ROWS ONLY;
  
CURSOR emprunt_le_moins IS SELECT
    m.numero,
    m.nom,
    count(*) total
  FROM
    Membres m
    JOIN Emprunts e ON m.numero = e.membre
    JOIN Details d ON e.numero = d.emprunt
  WHERE
    e.creele > add_months(sysdate, -10)
  GROUP BY
    m.numero,
    m.nom
  ORDER BY 
    total ASC
  FETCH NEXT 3 ROWS ONLY;
  
  compteur PLS_INTEGER := 1;
  
BEGIN
  DBMS_OUTPUT.PUT_LINE('Les plus gros emprunteurs');
  
  FOR item IN curseur LOOP
    dbms_output.put_line(' ' || compteur || ')' || item.numero || ' ' || item.nom);
    compteur := compteur + 1;
  END LOOP;
  
  compteur := 1;
  
  DBMS_OUTPUT.PUT_LINE('Les plus faibles emprunteurs');
  
  FOR item IN emprunt_le_moins LOOP
    dbms_output.put_line(' ' || compteur || ')' || item.numero || ' ' || item.nom);
    compteur := compteur + 1;
  END LOOP;
END;
