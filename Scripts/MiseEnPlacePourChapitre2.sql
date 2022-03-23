--1.2
drop table details; -- si ce script à déjà été passé, la table DetailsEmprunts a été renommée en Details
drop table detailsemprunts;
drop table emprunts;
drop table exemplaires;
drop table ouvrages;
drop table genres;
drop table membres;

CREATE TABLE GENRES (
  code char(5) constraint PK_GENRES primary key,
  libelle varchar2(80) not null
);

CREATE TABLE OUVRAGES (
  isbn number(10) constraint PK_OUVRAGES primary key,
  titre varchar2(200) not null,
  auteur varchar2(80),
  genre char(5) constraint FK_OUVRAGES_GENRES references GENRES(code),
  editeur varchar2(80)
);

create table EXEMPLAIRES (
  isbn number(10) constraint FK_EXEMPLAIRES_OUVRAGES references OUVRAGES(isbn),
  numero number(3),
  etat char(2) constraint CK_EXEMPLAIRES_ETAT check (etat in ('NE','BO','MO','MA')),
  constraint PK_EXEMPLAIRES primary key (isbn, numero)
);

create table MEMBRES (
  numero number(6) constraint PK_MEMBRES primary key,
  nom varchar2(80) not null,
  prenom varchar2(80) not null,
  adresse varchar2(80) not null,
  telephone varchar2(10) not null,
  adhesion date not null,
  duree number(2) not null constraint CK_MEMBRES_DUREE check (duree > 0)
);

create table EMPRUNTS (
  numero number(10) constraint PK_EMPRUNTS primary key,
  membre number(6) not null constraint FK_EMPRUNTS_MEMBRES references MEMBRES(numero),
  creele date default sysdate
);

create table DETAILSEMPRUNTS (
  emprunt number(10) constraint FK_DETAILS_EMPRUNTS references EMPRUNTS(numero),
  numero number(3),
  isbn number(10),
  exemplaire number(3),
  rendule date,
  constraint PK_DETAILSEMPRUNTS primary key(emprunt, numero),
  constraint FK_DETAILSEMPRUNTS_EXEMPLAIRES foreign key (isbn, exemplaire) references EXEMPLAIRES(isbn, numero)
);

--1.3
drop sequence SEQ_MEMBRE;
create sequence SEQ_MEMBRE start with 1 increment by 1;

--1.4
alter table MEMBRES add constraint UQ_MEMBRES unique (nom, prenom, telephone);

--1.5
alter table MEMBRES add (mobile varchar2(10) constraint ck_membres_mobile check(mobile like '06%'));

--1.6
alter table MEMBRES drop constraint UQ_MEMBRES;
alter table MEMBRES set unused (telephone);
alter table MEMBRES drop unused columns;
alter table MEMBRES add constraint UQ_MEMBRES unique (nom, prenom, mobile);

--1.7
Create index idx_ouvrages_genre on ouvrages(genre);
Create index idx_emplaires_isbn on exemplaires(isbn);
Create index idx_emprunts_membre on emprunts(membre);
Create index idx_details_emprunt on detailsemprunts(emprunt);
Create index idx_details_exemplaire on detailsemprunts(isbn, exemplaire);

--1.8
Alter table detailsemprunts drop constraint fk_details_emprunts;
Alter table detailsemprunts add constraint fk_details_emprunts foreign key(emprunt)references emprunts(numero) on delete cascade;

--1.9
Alter table exemplaires modify (etat char(2) default 'NE');

--1.10
drop synonym abonnes;
Create synonym abonnes for membres;

--1.11
Rename detailsemprunts to details;
