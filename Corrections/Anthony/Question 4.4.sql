DECLARE
  CURSOR curseur IS SELECT
    d.isbn,
    count(*) as total
  FROM
    Details d
  GROUP BY 
    d.isbn
  ORDER BY
    TOTAL DESC
  FETCH NEXT 5 ROWS ONLY;
  
  compteur PLS_INTEGER := 1;
  
BEGIN
  FOR item IN curseur LOOP
      dbms_output.put_line('Numéro ' || compteur || ' - isbn : ' || item.isbn);
      compteur := compteur + 1;
  END LOOP;
END;