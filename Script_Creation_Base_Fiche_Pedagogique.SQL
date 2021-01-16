DROP DATABASE IF EXISTS fichePedagogique;

CREATE DATABASE IF NOT EXISTS fichePedagogique;
USE fichePedagogique;
# -----------------------------------------------------------------------------
#       TABLE : SECRETARIAT
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS SECRETARIAT
 (
   ID_ADMINISTRATIF MEDIUMINT(4) NOT NULL AUTO_INCREMENT ,
   ID_UTILISATEUR MEDIUMINT(4) NOT NULL  
   , PRIMARY KEY (ID_ADMINISTRATIF) 
 ) 
 ENGINE=InnoDB DEFAULT VARCHARSET=utf8mb4;

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE SECRETARIAT
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_SECRETARIAT_UTLISATEUR
     ON SECRETARIAT (ID_UTILISATEUR ASC);

# -----------------------------------------------------------------------------
#       TABLE : FICHE
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS FICHE
 (
   ID_FICHE MEDIUMINT(4) NOT NULL AUTO_INCREMENT ,
   NUMERO_ETUDIANT VARCHAR(16) NOT NULL  ,
   ID_PROMO MEDIUMINT(4) NOT NULL  ,
   ETAT_FICHE VARCHAR(16) NULL  ,
   DATE_SIGNATURE DATE NULL  ,
   DATE_VALIDATION DATE NULL  ,
   DATE_TRANSMISSION DATE NULL  ,
   RSE TINYINT(2) DEFAULT 0 NOT NULL  ,
   TIER_TEMPS TINYINT(2) DEFAULT 0 NOT NULL  ,
   REDOUBLANT TINYINT(2) DEFAULT 0 NOT NULL  ,
   AJAC TINYINT(2) DEFAULT 0 NOT NULL  
   , PRIMARY KEY (ID_FICHE) 
   , CONSTRAINT CHECK_TIER_TEMPS CHECK ((TIER_TEMPS IN ('Non','Pause rattrapable','Oui')))
 ) 
 ENGINE=InnoDB DEFAULT VARCHARSET=utf8mb4;

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE FICHE
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_FICHE_ETUDIANT
     ON FICHE (NUMERO_ETUDIANT ASC);

CREATE  INDEX I_FK_FICHE_PROMO
     ON FICHE (ID_PROMO ASC);

# -----------------------------------------------------------------------------
#       TABLE : PROMO
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS PROMO
 (
   ID_PROMO MEDIUMINT(4) NOT NULL AUTO_INCREMENT ,
   ID_PERIODE MEDIUMINT(4) NOT NULL  ,
   ID_PARCOURS MEDIUMINT(4) NOT NULL  ,
   ID_ENSEIGNANT MEDIUMINT(4) NOT NULL  
   , PRIMARY KEY (ID_PROMO) 
 ) 
 ENGINE=InnoDB DEFAULT VARCHARSET=utf8mb4;

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE PROMO
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_PROMO_PERIODE_SCOLAIRE
     ON PROMO (ID_PERIODE ASC);

CREATE  INDEX I_FK_PROMO_PARCOURS
     ON PROMO (ID_PARCOURS ASC);

CREATE  INDEX I_FK_PROMO_ENSEIGNANT
     ON PROMO (ID_ENSEIGNANT ASC);

# -----------------------------------------------------------------------------
#       TABLE : UTLISATEUR
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS UTLISATEUR
 (
   ID_UTILISATEUR MEDIUMINT(4) NOT NULL AUTO_INCREMENT ,
   LOGIN VARCHAR(128) NOT NULL  ,
   MDP VARCHAR(32) NOT NULL  ,
   NOM VARCHAR(32) NOT NULL  ,
   PRENOM VARCHAR(32) NOT NULL  ,
   ETAT TINYINT(2) DEFAULT 1 NOT NULL  
   , PRIMARY KEY (ID_UTILISATEUR) 
   , UNIQUE (LOGIN)
 ) 
 ENGINE=InnoDB DEFAULT VARCHARSET=utf8mb4;

# -----------------------------------------------------------------------------
#       TABLE : UNITE_ENSEIGNEMENT
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS UNITE_ENSEIGNEMENT
 (
   CODE_MODULE MEDIUMINT(4) NOT NULL AUTO_INCREMENT ,
   LIBELLE_MODULE VARCHAR(64) DEFAULT 0 NOT NULL  
   , PRIMARY KEY (CODE_MODULE) 
 ) 
 ENGINE=InnoDB DEFAULT VARCHARSET=utf8mb4;

# -----------------------------------------------------------------------------
#       TABLE : PERIODE_SCOLAIRE
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS PERIODE_SCOLAIRE
 (
   ID_PERIODE MEDIUMINT(4) NOT NULL AUTO_INCREMENT ,
   DATE_DEBUT DATE NOT NULL  ,
   DATE_FIN DATE NOT NULL  ,
   NUM_SEMESTRE TINYINT(4) NOT NULL  
   , PRIMARY KEY (ID_PERIODE) 
   , CONSTRAINT CHECK_NUM_SEMESTRE CHECK ((NUM_SEMESTRE IN (1,2)))
 ) 
 ENGINE=InnoDB DEFAULT VARCHARSET=utf8mb4;

# -----------------------------------------------------------------------------
#       TABLE : ETUDIANT
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS ETUDIANT
 (
   NUMERO_ETUDIANT VARCHAR(16) NOT NULL ,
   ID_UTILISATEUR MEDIUMINT(4) NOT NULL  ,
   DATE_DE_NAISSANCE DATE NULL  ,
   ADRESSE VARCHAR(32) NULL  ,
   NUM_TELEPHONE VARCHAR(32) NULL  ,
   NUM_PORTABLE VARCHAR(32) NULL  ,
   MAIL VARCHAR(32) NULL  ,
   ADRESSE_REFERENCE VARCHAR(32) NULL  
   , PRIMARY KEY (NUMERO_ETUDIANT) 
 ) 
 ENGINE=InnoDB DEFAULT VARCHARSET=utf8mb4;

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE ETUDIANT
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_ETUDIANT_UTLISATEUR
     ON ETUDIANT (ID_UTILISATEUR ASC);

# -----------------------------------------------------------------------------
#       TABLE : ENSEIGNANT
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS ENSEIGNANT
 (
   ID_ENSEIGNANT MEDIUMINT(4) NOT NULL AUTO_INCREMENT ,
   ID_UTILISATEUR MEDIUMINT(4) NOT NULL  
   , PRIMARY KEY (ID_ENSEIGNANT) 
 ) 
 ENGINE=InnoDB DEFAULT VARCHARSET=utf8mb4;

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE ENSEIGNANT
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_ENSEIGNANT_UTLISATEUR
     ON ENSEIGNANT (ID_UTILISATEUR ASC);

# -----------------------------------------------------------------------------
#       TABLE : PARCOURS
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS PARCOURS
 (
   ID_PARCOURS MEDIUMINT(4) NOT NULL AUTO_INCREMENT ,
   NIVEAU VARCHAR(16) NOT NULL  ,
   PARCOURS VARCHAR(32) NOT NULL  ,
   NUMERO_ANNEE TINYINT(4) NOT NULL  ,
   SPECIALITE VARCHAR(32) NULL  
   , PRIMARY KEY (ID_PARCOURS) 
   , CONSTRAINT CHECK_NIVEAU CHECK ((NIVEAU IN ('Licence','Master')))
   , CONSTRAINT CHECK_PARCOURS CHECK ((PARCOURS IN ('MIAGE','Ing�nierie informatique','Informatique')))
 ) 
 ENGINE=InnoDB DEFAULT VARCHARSET=utf8mb4;

# -----------------------------------------------------------------------------
#       TABLE : CONTENIR
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS CONTENIR
 (
   ID_PROMO MEDIUMINT(4) NOT NULL  ,
   CODE_MODULE MEDIUMINT(4) NOT NULL  ,
   ECTS INTEGER(4) NOT NULL  ,
   TYPE VARCHAR(12) NOT NULL  
   , PRIMARY KEY (ID_PROMO,CODE_MODULE) 
   , CONSTRAINT CHECK_TYPE_UE CHECK ((TYPE_UE IN ('Obligatoire','Optionnelle')))
 ) 
 ENGINE=InnoDB DEFAULT VARCHARSET=utf8mb4;

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE CONTENIR
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_CONTENIR_PROMO
     ON CONTENIR (ID_PROMO ASC);

CREATE  INDEX I_FK_CONTENIR_UNITE_ENSEIGNEMENT
     ON CONTENIR (CODE_MODULE ASC);

# -----------------------------------------------------------------------------
#       TABLE : RENSEIGNER
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS RENSEIGNER
 (
   ID_FICHE MEDIUMINT(4) NOT NULL  ,
   CODE_MODULE MEDIUMINT(4) NOT NULL  ,
   NOTE_MOYENNE FLOAT(4,2) NULL  ,
   TYPE_CONTROLE VARCHAR(8) NULL  
   , PRIMARY KEY (ID_FICHE,CODE_MODULE) 
   , CONSTRAINT CHECK_TYPE_CONTROLE CHECK ((TYPE_CONTROLE IN ('Continu','Terminal')))
 ) 
 ENGINE=InnoDB DEFAULT VARCHARSET=utf8mb4;

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE RENSEIGNER
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_RENSEIGNER_FICHE
     ON RENSEIGNER (ID_FICHE ASC);

CREATE  INDEX I_FK_RENSEIGNER_UNITE_ENSEIGNEMENT
     ON RENSEIGNER (CODE_MODULE ASC);


# -----------------------------------------------------------------------------
#       CREATION DES REFERENCES DE TABLE
# -----------------------------------------------------------------------------


ALTER TABLE SECRETARIAT 
  ADD FOREIGN KEY FK_SECRETARIAT_UTLISATEUR (ID_UTILISATEUR)
      REFERENCES UTLISATEUR (ID_UTILISATEUR) ;


ALTER TABLE FICHE 
  ADD FOREIGN KEY FK_FICHE_ETUDIANT (NUMERO_ETUDIANT)
      REFERENCES ETUDIANT (NUMERO_ETUDIANT) ;


ALTER TABLE FICHE 
  ADD FOREIGN KEY FK_FICHE_PROMO (ID_PROMO)
      REFERENCES PROMO (ID_PROMO) ;


ALTER TABLE PROMO 
  ADD FOREIGN KEY FK_PROMO_PERIODE_SCOLAIRE (ID_PERIODE)
      REFERENCES PERIODE_SCOLAIRE (ID_PERIODE) ;


ALTER TABLE PROMO 
  ADD FOREIGN KEY FK_PROMO_PARCOURS (ID_PARCOURS)
      REFERENCES PARCOURS (ID_PARCOURS) ;


ALTER TABLE PROMO 
  ADD FOREIGN KEY FK_PROMO_ENSEIGNANT (ID_ENSEIGNANT)
      REFERENCES ENSEIGNANT (ID_ENSEIGNANT) ;


ALTER TABLE ETUDIANT 
  ADD FOREIGN KEY FK_ETUDIANT_UTLISATEUR (ID_UTILISATEUR)
      REFERENCES UTLISATEUR (ID_UTILISATEUR) ;


ALTER TABLE ENSEIGNANT 
  ADD FOREIGN KEY FK_ENSEIGNANT_UTLISATEUR (ID_UTILISATEUR)
      REFERENCES UTLISATEUR (ID_UTILISATEUR) ;


ALTER TABLE CONTENIR 
  ADD FOREIGN KEY FK_CONTENIR_PROMO (ID_PROMO)
      REFERENCES PROMO (ID_PROMO) ;


ALTER TABLE CONTENIR 
  ADD FOREIGN KEY FK_CONTENIR_UNITE_ENSEIGNEMENT (CODE_MODULE)
      REFERENCES UNITE_ENSEIGNEMENT (CODE_MODULE) ;


ALTER TABLE RENSEIGNER 
  ADD FOREIGN KEY FK_RENSEIGNER_FICHE (ID_FICHE)
      REFERENCES FICHE (ID_FICHE) ;


ALTER TABLE RENSEIGNER 
  ADD FOREIGN KEY FK_RENSEIGNER_UNITE_ENSEIGNEMENT (CODE_MODULE)
      REFERENCES UNITE_ENSEIGNEMENT (CODE_MODULE) ;

