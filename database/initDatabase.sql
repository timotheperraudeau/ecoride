CREATE DATABASE ecoride;

CREATE TABLE utilisateur(
    id_utilisateur SERIAL PRIMARY KEY,
    nom VARCHAR(50),
    prenom VARCHAR(50),
    email VARCHAR(50) NOT NULL,
    password VARCHAR(50) NOT NULL,
    adresse VARCHAR(50),
    date_naissance DATE,
    photo BYTEA,
    pseudo VARCHAR(50) NOT NULL,
    credits FLOAT
);

CREATE TABLE role (
    id_role SERIAL PRIMARY KEY,
    libelle VARCHAR(20) NOT NULL
);

CREATE TABLE utilisateur_role (
    id_utilisateur INT, 
    id_role INT,  
    PRIMARY KEY (id_utilisateur, id_role),
    FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utilisateur) ON DELETE CASCADE,
    FOREIGN KEY (id_role) REFERENCES role(id_role) ON DELETE CASCADE
);

CREATE TABLE covoiturage(
    id_covoiturage SERIAL PRIMARY KEY,
    date_depart DATE NOT NULL,
    heure_depart TIME NOT NULL,
    lieu_depart VARCHAR(50) NOT NULL,
    date_arrivee DATE NOT NULL,
    heure_arrivee TIME NOT NULL,
    lieu_arrivee VARCHAR(50) NOT NULL,
    statut VARCHAR(50) NOT NULL,
    nb_place int NOT NULL,
    prix_personne FLOAT NOT NULL,
    id_utilisateur INT,
    FOREIGN KEY (id_utilisateur) REFERENCES utilisateur (id_utilisateur) ON DELETE CASCADE
);

CREATE TABLE voiture(
    id_voiture SERIAL PRIMARY KEY,
    model VARCHAR(50) NOT NULL,
    immatriculation VARCHAR(50) NOT NULL,
    energie VARCHAR(50) NOT NULL,
    couleur VARCHAR(50) NOT NULL,
    date_première_immatriculation DATE NOT NULL,
    id_utilisateur INT,
    FOREIGN KEY (id_utilisateur) REFERENCES utilisateur (id_utilisateur) ON DELETE CASCADE
);

CREATE TABLE marque(
    id_marque SERIAL PRIMARY KEY,
    libelle VARCHAR(50) NOT NULL,
    id_utilisateur INT,
    FOREIGN KEY (id_utilisateur) REFERENCES utilisateur (id_utilisateur) ON DELETE CASCADE
);

-- intégration de données

-- insertion des rôles
INSERT INTO role (libelle)
VALUES
('passager'),
('chauffeur'),
('suspendu'),
('employe'),
('admin');

-- création du compte admin
INSERT INTO utilisateur (nom, prenom, email, password, pseudo)
VALUES ('admin', 'system', 'admin@example.com', 'H7g!pT2#c9X@qF', 'ECO_Mngr_2025' );
INSERT INTO utilisateur_role (id_utilisateur, id_role)
VALUES(
    (SELECT id_utilisateur FROM utilisateur WHERE pseudo = 'ECO_Mngr_2025'),
    (SELECT id_role FROM role WHERE libelle = 'admin')
);



-- création utilisateur role passager et chauffeur
INSERT INTO utilisateur (nom, prenom, email, password, adresse, date_naissance, pseudo, credits)
VALUES ('doe', 'john', 'john.doe@example.com', 'JoHnDoE@1985', 'nantes', '1985-02-12', 
        'John85', 0);

INSERT INTO utilisateur_role (id_utilisateur, id_role)
VALUES 
    ((SELECT id_utilisateur FROM utilisateur WHERE email = 'john.doe@example.com'), 
     (SELECT id_role FROM role WHERE libelle = 'passager')),
    ((SELECT id_utilisateur FROM utilisateur WHERE email = 'john.doe@example.com'), 
     (SELECT id_role FROM role WHERE libelle = 'chauffeur'));

INSERT INTO marque (libelle, id_utilisateur) 
VALUES ('Peugeot', (SELECT id_utilisateur FROM utilisateur WHERE email = 'john.doe@example.com'));

SELECT id_marque FROM marque WHERE id_utilisateur = (SELECT id_utilisateur FROM utilisateur WHERE email = 'john.doe@example.com');
INSERT INTO voiture (model, immatriculation, energie, couleur, date_première_immatriculation, id_utilisateur)
VALUES ('3008', 'aa-085-bb', 'gasoil', 'noire', '2019-03-06', 
        (SELECT id_utilisateur FROM utilisateur WHERE email = 'john.doe@example.com'));


-- création utilisateur role passager
INSERT INTO utilisateur (nom, prenom, email, password, adresse, date_naissance, pseudo, credits)
VALUES ('pignon', 'françois', 'francois.pignon@example.com', 'FrAnCoIsP@1978', 'paris', '1978-06-30', 
        'Fanfan78', 20);

INSERT INTO utilisateur_role (id_utilisateur, id_role)
VALUES 
    ((SELECT id_utilisateur FROM utilisateur WHERE email = 'francois.pignon@example.com'), 
     (SELECT id_role FROM role WHERE libelle = 'passager'));

-- création utilisateur role chauffeur
INSERT INTO utilisateur (nom, prenom, email, password, adresse, date_naissance, pseudo, credits)
VALUES ('dupond', 'steven', 'steven.dupond@example.com', 'StEvEnD@1990', 'bordeaux', '1990-11-07', 
        'Steve90', 20);

INSERT INTO utilisateur_role (id_utilisateur, id_role)
VALUES 
    ((SELECT id_utilisateur FROM utilisateur WHERE email = 'steven.dupond@example.com'), 
     (SELECT id_role FROM role WHERE libelle = 'chauffeur'));

INSERT INTO marque (libelle, id_utilisateur) 
VALUES ('Fiat', (SELECT id_utilisateur FROM utilisateur WHERE email = 'steven.dupond@example.com'));



SELECT id_marque FROM marque WHERE id_utilisateur = (SELECT id_utilisateur FROM utilisateur WHERE email = 'steven.dupond@example.com');
INSERT INTO voiture (model, immatriculation, energie, couleur, date_première_immatriculation, id_utilisateur)
VALUES ('stilo', 'cc-090-dd', 'electrique', 'blanche', '2021-05-11', 
        (SELECT id_utilisateur FROM utilisateur WHERE email = 'steven.dupond@example.com'));

--Création d'un covoiturage proposé par John85
INSERT INTO covoiturage (date_depart, heure_depart, lieu_depart, date_arrivee, heure_arrivee, lieu_arrivee, statut, nb_place, prix_personne, id_utilisateur) 
VALUES
('2025-11-01', '8:00:00', 'nantes', '2025-11-01', '13:00:00', 'paris', 'disponible', 3, 5, (SELECT id_utilisateur FROM utilisateur WHERE pseudo = 'John85'));

-- Création d'un covoiturage proposé par Steve90
INSERT INTO covoiturage (date_depart, heure_depart, lieu_depart, date_arrivee, heure_arrivee, lieu_arrivee, statut, nb_place, prix_personne, id_utilisateur) 
VALUES
('2025-11-01', '12:00:00', 'bordeaux', '2025-11-01', '15:00:00', 'nantes', 'disponible', 2, 3, (SELECT id_utilisateur FROM utilisateur WHERE pseudo = 'Steve90') );