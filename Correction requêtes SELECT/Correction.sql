-- Liste des ouvrages de la biblihoteque
SELECT
  *
FROM
  Ouvrages;

-- Liste des membres qui ont emprunté un ouvrage depuis strictement plus que deux semaines.
--Affichez le nom nom de l'ouvrage ainsi que la personne qui la emprunté.
SELECT
  o.titre,
  m.nom,
  m.prenom
FROM
  Membres m
  JOIN Emprunts e ON m.numero = e.membre
  JOIN Details d ON e.numero = d.emprunt
  JOIN Exemplaires ex ON ex.isbn = d.isbn AND d.exemplaire = ex.numero
  JOIN Ouvrages o ON o.isbn = ex.isbn
WHERE
  e.creele < sysdate -14 AND
  d.rendule IS NULL;
  
SELECT 
  sysdate 
FROM
  Dual;
  
-- Etablissez le nombre d'ouvrage par categorie
SELECT
  g.libelle,
  count(*)
FROM
  Ouvrages o
  JOIN Genres g ON o.genre = g.code
GROUP BY
  g.code,
  g.libelle
-- Etablissez la durée moyenne d'emprunt d'un livre par un membre : Mode Laura
SELECT
  AVG(d.rendule - e.creele)
FROM
  Emprunts e
  JOIN Details d ON e.numero = d.emprunt
WHERE
  e.membre = 1 
  AND rendule IS NOT NULL
-- Etablissez la durée moyenne d'emprunt d'un livre par un membre : Mode Moi
SELECT
  AVG(d.rendule - e.creele)
FROM
  Emprunts e
  JOIN Details d ON e.numero = d.emprunt
WHERE
  rendule IS NOT NULL
-- Afficher la durée moyenne de l'emprunt en fonction du genre du livre
SELECT
  g.libelle,
  ROUND(AVG(d.rendule - e.creele),2)
FROM
  Genres g
  JOIN Ouvrages o ON g.code = o.genre
  JOIN Exemplaires ex ON ex.isbn = o.isbn
  JOIN Details d ON d.isbn = ex.isbn AND d.exemplaire = ex.numero
  JOIN Emprunts e ON e.numero = d.emprunt
WHERE
  rendule IS NOT NULL
GROUP BY
  g.code,
  g.libelle
-- Etablissez la liste des ouvrages loués plus de 10 fois au cours des 12 derniers mois.
SELECT
  o.titre
FROM
  Ouvrages o
  JOIN Exemplaires ex ON o.isbn = ex.isbn
  JOIN Details d ON d.isbn = ex.isbn AND d.exemplaire = ex.numero
  JOIN Emprunts e ON e.numero = d.emprunt
WHERE
  creele > ADD_MONTHS(sysdate,-12)
GROUP BY
  o.isbn,
  o.titre
HAVING 
  count(*) > 10









  



  
  
  
  