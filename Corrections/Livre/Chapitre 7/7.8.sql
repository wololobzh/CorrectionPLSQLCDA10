CREATE OR REPLACE PROCEDURE infoEquipe(pcode varchar) IS
  vnb integer;
  CURSOR CurCoureurs IS SELECT dossard,nom,prenom fROM coureurs WHERE equipe = pcode;
  vnat varchar2(3);
  vetape varchar2(8);
  vjour date;
  vvilles varchar2(200);
BEGIN
  SELECT count(*) INTO vnb FROM equipes WHERE code = pcode;
  IF vnb=0 THEN
    RAISE_APPLICATION_ERROR(-20051,'Cette �quipe n''existe pas');
  END IF;
  SELECT count(*) INTO vnb FROM coureurs WHERE equipe = pcode;
  IF vnb=0 THEN
    DBMS_OUTPUT.PUT_LINE('Cette �quipe ne dispose d''aucun coureur');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Cette �quipe est compos�e de ' || vnb || ' coureur(s) : ' );
   
    FOR vcour IN CurCoureurs LOOP
        DBMS_OUTPUT.PUT_LINE('      ' || vcour.nom || '   ' || vcour.prenom || '  dossard num�ro '|| vcour.dossard);
    END LOOP;
    DBMS_OUTPUT.NEW_LINE;
    SELECT nationalite INTO vnat FROM equipes WHERE code=pcode;
    SELECT count(*) - 1 INTO vnb FROM equipes WHERE nationalite = vnat;
    IF vnb = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Cette �quipe est de nationalit� ' || vnat || '. c''est la seule �quipe de cette nationalit�');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Cette �quipe est de nationalit� ' || vnat || '. Il y a '|| vnb || ' autre(s) �quipe(s) de cette nationalit�');
    END IF;
    SELECT count(distinct nationalite) into vnb FROM coureurs WHERE equipe = pcode;
    DBMS_OUTPUT.PUT_LINE('  On trouve '|| vnb|| ' nationalit�(s) diff�rente(s) au sein de l''�quipe');    
    DBMS_OUTPUT.NEW_LINE;
    SELECT count(*) into vnb FROM resultats INNER JOIN coureurs on coureurs.dossard = resultats.coureur
     WHERE coureurs.equipe = pcode;
     IF vnb = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Cette �quipe ne dispose d''aucun r�sultat');
     ELSE
        SELECT distinct etape,jour,villedepart || ' � '|| villearrivee INTO vetape,vjour,vvilles
        FROM resultats  INNER JOIN coureurs on coureurs.dossard = resultats.coureur
                        INNER JOIN etapes ON etapes.code = resultats.etape
        WHERE coureurs.equipe = pcode ORDER BY jour DESC FETCH FIRST 1 ROWS ONLY;
        DBMS_OUTPUT.PUT_LINE('Les derniers r�sultats pour cette �quipe concernent l''�tape ' || vetape || ' qui part de '|| vvilles || ' et s''est d�roul�e le '|| vjour);
     END IF;
  END IF;
END;
--test
SET SERVEROUTPUT ON
BEGIN
  infoEquipe('LST');
END;