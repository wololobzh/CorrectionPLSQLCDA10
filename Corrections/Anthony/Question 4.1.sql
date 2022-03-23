DECLARE
  CURSOR curseur_emprunt IS SELECT
                              isbn,
                              exemplaire,
                              count(*) as total
                            FROM
                              Details
                            GROUP BY
                              isbn,
                              exemplaire;
  etat_exemplaire char(2);
BEGIN

  FOR item IN curseur_emprunt LOOP
  
    CASE 
      WHEN item.total >= 4 AND item.total <= 10 THEN
        etat_exemplaire := 'BO';
      WHEN item.total > 10 AND item.total <= 20 THEN
        etat_exemplaire := 'MO';
      WHEN item.total > 20 THEN
        etat_exemplaire := 'MA';
      ELSE
        etat_exemplaire := 'NE';
    END CASE;
    
    UPDATE exemplaires SET etat = etat_exemplaire WHERE isbn = item.isbn AND numero = item.exemplaire;
      
  END LOOP;
END;
  
SELECT * FROM Exemplaires

SELECT * FROM Details WHERE isbn = '2038704015' AND exemplaire = 1

SELECT * FROM ouvrages WHERE isbn = '2038704015';
