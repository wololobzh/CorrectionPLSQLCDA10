CREATE OR REPLACE FUNCTION adhesionajour(p_numero int)
RETURN BOOLEAN
AS
BEGIN
  RETURN fin_validite(p_numero) > sysdate;
END;

BEGIN
  if(adhesionajour(1)) THEN
    dbms_output.put_line('OK');
  ELSE
    dbms_output.put_line('KO');
  END IF;
END;
