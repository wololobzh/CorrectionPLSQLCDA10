ALTER TABLE emprunts ADD(
  ajoutePar varchar2(80), 
  ajouteLe date) ;
ALTER TABLE details ADD(
  modifiePar varchar2(80), 
  modifieLe date) ;

CREATE OR REPLACE TRIGGER bf_ins_emprunts 
  BEFORE INSERT ON emprunts
  FOR EACH ROW
BEGIN
  -- r�cup�rer le nom de l�utilisateur Oracle
  :new.ajoutePar :=user() ;
  -- r�cup�rer la date et heure courante du serveur
  :new.ajouteLe :=sysdate() ;
END ;
/

CREATE TRIGGER bf_upd_details
  BEFORE UPDATE ON details
  FOR EACH ROW
  WHEN (old.rendule is null AND new.rendule is not null)
BEGIN
  -- r�cuprer le nom de l�utilisateur Oracle
  :new.modifiePar :=user() ;
  -- r�cup�rer la adte et heure courante du serveur
  :new.modifieLe :=sysdate() ;
END ;
/
