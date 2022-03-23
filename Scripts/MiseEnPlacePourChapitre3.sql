-- 2.1
Insert into genres(code, libelle) values ('REC','Récit');
Insert into genres(code, libelle) values ('POL','Policier');
Insert into genres(code, libelle) values ('BD','Bande Dessinées');
Insert into genres(code, libelle) values ('INF','Informatique');
Insert into genres(code, libelle) values ('THE','Théâtre');
Insert into genres(code, libelle) values ('ROM','Roman');

Insert into ouvrages (isbn, titre, auteur, genre, editeur) 
values (2203314168, 'LEFRANC-L''ultimatum', 'Martin, Carin', 'BD', 'Casterman');
Insert into ouvrages (isbn, titre, auteur, genre, editeur) 
values (2746021285, 'HTML entraînez-vous pour maîtriser le code source', 'Luc Van Lancker', 'INF', 'ENI');
Insert into ouvrages (isbn, titre, auteur, genre, editeur) 
values (2746026090, ' Oracle 10g SQL, PL/SQL, SQL*Plus', 'J. Gabillaud', 'INF', 'ENI');
Insert into ouvrages (isbn, titre, auteur, genre, editeur) 
values (2266085816, 'Pantagruel', 'François RABELAIS', 'ROM', 'POCKET');
Insert into ouvrages (isbn, titre, auteur, genre, editeur) 
values (2266091611, 'Voyage au centre de la terre', 'Jules Verne', 'ROM', 'POCKET');
Insert into ouvrages (isbn, titre, auteur, genre, editeur) 
values (2253010219, 'Le crime de l''Orient Express', 'Agatha Christie', 'POL', 'Livre de Poche');
Insert into ouvrages (isbn, titre, auteur, genre, editeur) 
values (2070400816, 'Le Bourgeois gentilhomme', 'Moliere', 'THE', 'Gallimard');
Insert into ouvrages (isbn, titre, auteur, genre, editeur) 
values (2070367177, 'Le curé de Tours', 'Honoré de Balzac', 'ROM', 'Gallimard');
Insert into ouvrages (isbn, titre, auteur, genre, editeur) 
values (2080720872, 'Boule de suif', 'Guy de Maupassant', 'REC', 'Flammarion');
Insert into ouvrages (isbn, titre, auteur, genre, editeur) 
values (2877065073, 'La gloire de mon père', 'Marcel Pagnol', 'ROM', 'Fallois');
Insert into ouvrages (isbn, titre, auteur, genre, editeur) 
values (2020549522, ' L''aventure des manuscrits de la mer morte ', default, 'REC', 'Seuil');
Insert into ouvrages (isbn, titre, auteur, genre, editeur) 
values (2253006327, ' Vingt mille lieues sous les mers ', 'Jules Verne', 'ROM', 'LGF');
Insert into ouvrages (isbn, titre, auteur, genre, editeur) 
values (2038704015, 'De la terre à la lune', 'Jules Verne', 'ROM', 'Larousse');

Insert into exemplaires(isbn, numero, etat) select isbn, 1,'BO' from ouvrages;
Insert into exemplaires(isbn, numero, etat) select isbn, 2,'MO' from ouvrages;
Delete from exemplaires where isbn=2746021285 and numero=2;
Update exemplaires set etat='MO' where isbn=2203314168 and numero=1;
Update exemplaires set etat='BO' where isbn=2203314168 and numero=2;
Insert into exemplaires(isbn, numero, etat) values (2203314168,3,'NE');

--2.2
Insert into membres (numero, nom, prenom, adresse, mobile, adhesion, duree) values (seq_membre.nextval, 'ALBERT', 'Anne', '13 rue des alpes', '0601020304', sysdate-60, 1);
Insert into membres (numero, nom, prenom, adresse, mobile, adhesion, duree) values (seq_membre.nextval, 'BERNAUD', 'Barnabé', '6 rue des bécasses', '0602030105', sysdate-10, 3);
Insert into membres (numero, nom, prenom, adresse, mobile, adhesion, duree) values (seq_membre.nextval, 'CUVARD', 'Camille', '52 rue des cerisiers', '0602010509', sysdate-100, 6);
Insert into membres (numero, nom, prenom, adresse, mobile, adhesion, duree) values (seq_membre.nextval, 'DUPOND', 'Daniel', '11 rue des daims', '0610236515', sysdate-250, 12);
Insert into membres (numero, nom, prenom, adresse, mobile, adhesion, duree) values (seq_membre.nextval, 'EVROUX', 'Eglantine', '34 rue des elfes', '0658963125', sysdate-150, 6);
Insert into membres (numero, nom, prenom, adresse, mobile, adhesion, duree) values (seq_membre.nextval, 'FREGEON', 'Fernand', '11 rue des Francs', '0602036987', sysdate-400, 6);
Insert into membres (numero, nom, prenom, adresse, mobile, adhesion, duree) values (seq_membre.nextval, 'GORIT', 'Gaston', '96 rue de la glacerie ', '0684235781', sysdate-150, 1);
Insert into membres (numero, nom, prenom, adresse, mobile, adhesion, duree) values (seq_membre.nextval, 'HEVARD', 'Hector', '12 rue haute', '0608546578', sysdate-250, 12);
Insert into membres (numero, nom, prenom, adresse, mobile, adhesion, duree) values (seq_membre.nextval, 'INGRAND', 'Irène', '54 rue des iris', '0605020409', sysdate-50, 12);
Insert into membres (numero, nom, prenom, adresse, mobile, adhesion, duree) values (seq_membre.nextval, 'JUSTE', 'Julien', '5 place des Jacobins', '0603069876', sysdate-100, 6);

--2.3
insert into emprunts(numero, membre, creele) values(1,1,sysdate-200);
insert into emprunts(numero, membre, creele) values(2,3,sysdate-190);
insert into emprunts(numero, membre, creele) values(3,4,sysdate-180);
insert into emprunts(numero, membre, creele) values(4,1,sysdate-170);
insert into emprunts(numero, membre, creele) values(5,5,sysdate-160);
insert into emprunts(numero, membre, creele) values(6,2,sysdate-150);
insert into emprunts(numero, membre, creele) values(7,4,sysdate-140);
insert into emprunts(numero, membre, creele) values(8,1,sysdate-130);
insert into emprunts(numero, membre, creele) values(9,9,sysdate-120);
insert into emprunts(numero, membre, creele) values(10,6,sysdate-110);
insert into emprunts(numero, membre, creele) values(11,1,sysdate-100);
insert into emprunts(numero, membre, creele) values(12,6,sysdate-90);
insert into emprunts(numero, membre, creele) values(13,2,sysdate-80);
insert into emprunts(numero, membre, creele) values(14,4,sysdate-70);
insert into emprunts(numero, membre, creele) values(15,1,sysdate-60);
insert into emprunts(numero, membre, creele) values(16,3,sysdate-50);
insert into emprunts(numero, membre, creele) values(17,1,sysdate-40);
insert into emprunts(numero, membre, creele) values(18,5,sysdate-30);
insert into emprunts(numero, membre, creele) values(19,4,sysdate-20);
insert into emprunts(numero, membre, creele) values(20,1,sysdate-10);

insert into details(emprunt, numero, isbn, exemplaire, rendule) values(1,1,2038704015,1,sysdate-195);
insert into details(emprunt, numero, isbn, exemplaire, rendule) values(1,2,2070367177,2,sysdate-190);
insert into details(emprunt, numero, isbn, exemplaire, rendule) values(2,1,2080720872,1,sysdate-180);
insert into details(emprunt, numero, isbn, exemplaire, rendule) values(2,2,2203314168,1,sysdate-179);
insert into details(emprunt, numero, isbn, exemplaire, rendule) values(3,1,2038704015,1,sysdate-170);
insert into details(emprunt, numero, isbn, exemplaire, rendule) values(4,1,2203314168,2,sysdate-155);
insert into details(emprunt, numero, isbn, exemplaire, rendule) values(4,2,2080720872,1,sysdate-155);
insert into details(emprunt, numero, isbn, exemplaire, rendule) values(4,3,2266085816,1,sysdate-159);
insert into details(emprunt, numero, isbn, exemplaire, rendule) values(5,1,2038704015,1,sysdate-140);
insert into details(emprunt, numero, isbn, exemplaire, rendule) values(6,1,2266085816,2,sysdate-141);
insert into details(emprunt, numero, isbn, exemplaire, rendule) values(6,2,2080720872,2,sysdate-130);
insert into details(emprunt, numero, isbn, exemplaire, rendule) values(6,3,2746021285,1,sysdate-133);
insert into details(emprunt, numero, isbn, exemplaire, rendule) values(7,1,2070367177,2,sysdate-100);
insert into details(emprunt, numero, isbn, exemplaire, rendule) values(8,1,2080720872,1,sysdate-116);
insert into details(emprunt, numero, isbn, exemplaire, rendule) values(9,1,2038704015,1,sysdate-100);
insert into details(emprunt, numero, isbn, exemplaire, rendule) values(10,1,2080720872,2,sysdate-107);
insert into details(emprunt, numero, isbn, exemplaire, rendule) values(10,2,2746026090,1,sysdate-78);
insert into details(emprunt, numero, isbn, exemplaire, rendule) values(11,1,2746021285,1,sysdate-81);
insert into details(emprunt, numero, isbn, exemplaire, rendule) values(12,1,2203314168,1,sysdate-86);
insert into details(emprunt, numero, isbn, exemplaire, rendule) values(12,2,2038704015,1,sysdate-60);
insert into details(emprunt, numero, isbn, exemplaire, rendule) values(13,1,2070367177,1,sysdate-65);
insert into details(emprunt, numero, isbn, exemplaire, rendule) values(14,1,2266091611,1,sysdate-66);
insert into details(emprunt, numero, isbn, exemplaire, rendule) values(15,1,2070400816,1,sysdate-50);
insert into details(emprunt, numero, isbn, exemplaire, rendule) values(16,1,2253010219,2,sysdate-41);
insert into details(emprunt, numero, isbn, exemplaire, rendule) values(16,2,2070367177,2,sysdate-41);
insert into details(emprunt, numero, isbn, exemplaire, rendule) values(17,1,2877065073,2,sysdate-36);
insert into details(emprunt, numero, isbn, exemplaire, rendule) values(18,1,2070367177,1,sysdate-14);
insert into details(emprunt, numero, isbn, exemplaire, rendule) values(19,1,2746026090,1,sysdate-12);
insert into details(emprunt, numero, isbn, exemplaire, rendule) values(20,1,2266091611,1,default);
insert into details(emprunt, numero, isbn, exemplaire, rendule) values(20,2,2253010219,1,default);

Insert into ouvrages (isbn, titre, auteur, genre, editeur) values (2080703234, 'Cinq semaines en ballon', 'Jules Verne', 'ROM', 'Flammarion');

-- 2.6
Alter table emprunts add(etat char(2) default 'EC');
Alter table emprunts add constraint ck_emprunts_etat check (etat in ('EC','RE'));

Update emprunts set etat='RE' where etat='EC' and numero not in (select emprunt from details where rendule is null);

--2.7
insert into details(emprunt, numero, isbn, exemplaire, rendule) values(7,2,2038704015,1,sysdate-136);
insert into details(emprunt, numero, isbn, exemplaire, rendule) values(8,2,2038704015,1,sysdate-127);
insert into details(emprunt, numero, isbn, exemplaire, rendule) values(11,2,2038704015,1,sysdate-95);
insert into details(emprunt, numero, isbn, exemplaire, rendule) values(15,2,2038704015,1,sysdate-54);
insert into details(emprunt, numero, isbn, exemplaire, rendule) values(16,3,2038704015,1,sysdate-43);
insert into details(emprunt, numero, isbn, exemplaire, rendule) values(17,2,2038704015,1,sysdate-36);
insert into details(emprunt, numero, isbn, exemplaire, rendule) values(18,2,2038704015,1,sysdate-24);
insert into details(emprunt, numero, isbn, exemplaire, rendule) values(19,2,2038704015,1,sysdate-13);
insert into details(emprunt, numero, isbn, exemplaire, rendule) values(20,3,2038704015,1,sysdate-3);
UPDATE exemplaires SET etat='NE' WHERE isbn=2038704015 and numero=1;
commit;

Create table tempoExemplaires as select isbn, exemplaire, count(*) as locations 
from details group by isbn, exemplaire;

Merge into exemplaires e 
using (select isbn, exemplaire, locations from tempoexemplaires) t
on (t.isbn=e.isbn and t.exemplaire=e.numero)
when matched then
  update set etat='BO' where t.locations between 11 and 25
 delete where t.locations>60;

Drop table tempoExemplaires;

-- 2.8
INSERT INTO exemplaires(isbn, numero, etat) VALUES (2203314168,4,'MA');
INSERT INTO exemplaires(isbn, numero, etat) VALUES (2746021285,3,'MA');
commit;
DELETE FROM exemplaires WHERE etat='MA';

commit;

