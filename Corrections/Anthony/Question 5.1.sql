--5.1
CREATE OR REPLACE FUNCTION fin_validite(p_numero int)
RETURN date
IS
  resultat date;
BEGIN

    SELECT 
      add_months(adhesion,duree)-14 INTO resultat 
    FROM 
      Membres m 
    WHERE 
      m.numero = p_numero;
  
  RETURN resultat;
END;

--5.1

SELECT 
  m.nom,
  fin_validite(m.numero)
FROM 
  Membres m
WHERE m.numero = 1