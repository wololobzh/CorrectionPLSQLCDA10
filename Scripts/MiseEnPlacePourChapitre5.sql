--4.1
DECLARE
  CURSOR cLesExemplaires IS 
    SELECT * FROM exemplaires FOR UPDATE OF etat;
  Vetat exemplaires.etat%type;
  Vnbre number(3);
BEGIN
  FOR vexemplaire IN cLesExemplaires LOOP
    SELECT count(*) INTO vnbre FROM details 
    WHERE details.isbn=vexemplaire.isbn AND details.exemplaire=vexemplaire.numero;
    /*
    IF (vnbre<=10) 
      THEN vetat:='NE';
      ELSE IF (vnbre<=25) 
             THEN vetat:='BO';
             ELSE IF (vnbre<=40) 
                    THEN vetat:='MO';
                    ELSE vetat:='MA';
                  END IF;
           END IF;
    END IF;
    */
    
    case 
      when vnbre <= 10 then vetat := 'NE';
      when vnbre <= 25 then vetat := 'BO';
      when vnbre <= 40 then vetat := 'MO';
      else vetat := 'MA';
    end case;
    
    UPDATE exemplaires SET etat=vetat 
    WHERE CURRENT OF cLesExemplaires;
  END LOOP;
END;
/

--4.2
DECLARE
  CURSOR cLesMembres IS 
    SELECT numero FROM membres WHERE MONTHS_BETWEEN(sysdate, ADD_MONTHS(adhesion,duree))>24;
  Vnombre number(5);
  VnombreSortis number;
BEGIN
  FOR vLesMembres IN cLesMembres LOOP
    -- ce membre possède t il encore des fiches d'emprunts en cours
    SELECT count(*) INTO vnombre FROM emprunts 
        WHERE membre=vLesMembres.numero and etat='EC';
    IF (vnombre = 0) THEN
      UPDATE emprunts SET membre=null WHERE membre=vLesMembres.numero;
     -- Supprimer le membre
      DELETE FROM membres WHERE numero=vLesMembres.numero;
    END IF;
    -- Valider les modifications
    COMMIT;
  END LOOP;
END;
/

--4.6
ALTER TABLE exemplaires ADD (
nombreEmprunts number(3) DEFAULT 0, 
dateCalculEmprunts date DEFAULT SYSDATE);

UPDATE exemplaires SET dateCalculEmprunts =(select min(creele)
  FROM emprunts e, details de
  WHERE e.numero=de.emprunt
    AND de.isbn=exemplaires.isbn
    AND de.exemplaire=exemplaires.numero);
UPDATE exemplaires SET dateCalculEmprunts = sysdate
WHERE dateCalculEmprunts IS NULL;
COMMIT;

DECLARE
  CURSOR cLesExemplaires IS 
    SELECT * FROM exemplaires 
    FOR UPDATE OF nombreEmprunts, dateCalculEmprunts;
  vnbre exemplaires.nombreEmprunts%type;
BEGIN
  -- parcourir l'ensemble des exemplaires
  FOR vexemplaire IN CLesExemplaires LOOP
    -- Calcul du nombre d'emprunts
    SELECT count(*) INTO vnbre
      FROM details, emprunts
      WHERE details.emprunt=emprunts.numero
        AND isbn=vexemplaire.isbn 
        AND exemplaire=vexemplaire.numero
        AND creele>=vexemplaire.dateCalculEmprunts;
      -- mettre à jour les informations exemplaires
      UPDATE exemplaires SET 
        nombreEmprunts=nombreEmprunts+vnbre,
        dateCalculEmprunts=sysdate 
        WHERE CURRENT OF CLesExemplaires;
      -- Mise à jour de l'état des exemplaires
      UPDATE exemplaires SET etat='NE' 
        WHERE nombreEmprunts<=10;
      UPDATE exemplaires SET etat='BO' 
        WHERE nombreEmprunts BETWEEN 11 AND 25;
      UPDATE exemplaires SET etat='MO' 
        WHERE nombreEmprunts BETWEEN 26 AND 40;
      UPDATE exemplaires SET etat='MA' 
        WHERE nombreEmprunts >=41;
    END LOOP;
    -- valider les modifications 
    COMMIT;
  END;
/

--4.7
DECLARE
  Vnbre number(6);
  Vtotal number(6);
BEGIN
  -- calculer le rapport exemplaires dans un état moyen ou mauvais par rapport au nombre total d'exemplaires
  SELECT count(*) INTO vnbre 
  FROM exemplaires 
  WHERE etat IN ('MO','MA');
  SELECT count(*) INTO vtotal 
  FROM exemplaires;
  IF (vnbre>vtotal/2) THEN
    -- supprimer la contrainte existante
    EXECUTE IMMEDIATE 'ALTER TABLE exemplaires DROP CONSTRAINT ck_exemplaires_etat';
    -- ajouter la nouvelle contrainte
    EXECUTE IMMEDIATE 'ALTER TABLE exemplaires ADD CONSTRAINT ck_emplaires_etat CHECK etat IN (''NE'',''BO'',''MO'',''DO'',''MA'')';
    -- mettre à jour l'état de l'exemplaire
    UPDATE exemplaires SET etat='DO' 
      WHERE nombreEmprunts BETWEEN  41 AND 60;
    -- valider les modifications de données
    COMMIT;
  END IF;
END;
/

--4.8
DELETE FROM membres
WHERE numero IN (SELECT DISTINCT membre
FROM emprunts
GROUP BY membre
HAVING MAX(creele)<add_months(sysdate,-36));

--4.9
alter table MEMBRES drop constraint ck_membres_mobile; -- contrainte créée en 3.9

/*      
  Pas necessaire de le faire car fait dans le
  script MiseEnPlaceChapitre4
  ---------------------------------------------

ALTER TABLE membres MODIFY(mobile char(14));

DECLARE
  --- traiter les membresun par un
  CURSOR cLesMembres IS 
    SELECT mobile FROM membres 
    FOR UPDATE OF mobile;
  vnouveau membres.mobile%type;
BEGIN

  FOR vnumero IN cLesMembres LOOP
    IF (INSTR(vnumero.mobile,' ')!=2) THEN
      -- construction du nouveau numero

  
    vnouveau:=substr(vnumero.mobile,1,2)||' '||
        substr(vnumero.mobile,3,2)||' '||
        substr(vnumero.mobile,5,2)||' '||
        substr(vnumero.mobile,7,2)||' '||
        substr(vnumero.mobile,9,2);
      UPDATE membres
      SET mobile=vnouveau
      WHERE CURRENT OF cLesMembres;
    END IF;
  END LOOP;
END;
/

*/

ALTER TABLE membres ADD constraint ck_membres_mobile check (REGEXP_LIKE (mobile, '^06 [[:digit:]]{2} [[:digit:]]{2} [[:digit:]]{2} [[:digit:]]{2}$')) EXCEPTIONS INTO EXCEPTIONS;

