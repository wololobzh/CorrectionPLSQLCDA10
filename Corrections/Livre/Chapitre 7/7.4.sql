-- Liste des coureurs par �quipe puis tri�s par nom
SELECT equipes.nom, coureurs.dossard, coureurs.nom, coureurs.prenom
FROM coureurs INNER JOIN equipes ON coureurs.equipe=equipes.code
order by equipes.code desc,coureurs.nom asc;
-- Liste de tous les coureurs de nationalit� Fran�aise
SELECT *
FROM coureurs
WHERE nationalite='FRA';
-- Liste de tous les coureurs de nationalit� fran�aise ou faisant partie d'une �quipe de nationnalit� fran�aise
SELECT coureurs.*
FROM coureurs INNER JOIN equipes ON coureurs.equipe=equipes.code
WHERE coureurs.nationalite='FRA' OR equipes.nationalite='FRA';
