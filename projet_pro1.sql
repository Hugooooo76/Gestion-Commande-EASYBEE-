SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

DROP TABLE IF EXISTS `bondelivraison`;
CREATE TABLE IF NOT EXISTS `bondelivraison` (
  `idBonLivraison` int NOT NULL AUTO_INCREMENT,
  `dateLivraison` date NOT NULL,
  PRIMARY KEY (`idBonLivraison`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Structure de la table `caisse`

DROP TABLE IF EXISTS `caisse`;
CREATE TABLE IF NOT EXISTS `caisse` (
  `idCaisse` int NOT NULL AUTO_INCREMENT,
  `nomCaisse` varchar(50) NOT NULL,
  `idParametre` int NOT NULL,
  PRIMARY KEY (`idCaisse`),
  KEY `caisse_parametreCaisse_FK` (`idParametre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Structure de la table `categorieproduit`

DROP TABLE IF EXISTS `categorieproduit`;
CREATE TABLE IF NOT EXISTS `categorieproduit` (
  `idCategorie` int NOT NULL AUTO_INCREMENT,
  `nomCategorie` varchar(50) NOT NULL,
  PRIMARY KEY (`idCategorie`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Structure de la table `cmdeapprodepot`

DROP TABLE IF EXISTS `cmdeapprodepot`;
CREATE TABLE IF NOT EXISTS `cmdeapprodepot` (
  `id` int NOT NULL AUTO_INCREMENT,
  `dateCommande` date NOT NULL,
  `statutCommande` varchar(50) NOT NULL,
  `idSalarie` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cmdeApproDepot_preparateur_FK` (`idSalarie`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Structure de la table `commande`

DROP TABLE IF EXISTS `commande`;
CREATE TABLE IF NOT EXISTS `commande` (
  `id` int NOT NULL,
  `idProduit` int NOT NULL,
  `qteCmde` int NOT NULL,
  PRIMARY KEY (`id`,`idProduit`),
  KEY `commande_produit0_FK` (`idProduit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Structure de la table `concerner`

DROP TABLE IF EXISTS `concerner`;
CREATE TABLE IF NOT EXISTS `concerner` (
  `idBonLivraison` int NOT NULL,
  `idProduit` int NOT NULL,
  `qtePrepa` int NOT NULL,
  `qteRecep` int NOT NULL,
  `idCmdeAppropDepot` int DEFAULT NULL,
  PRIMARY KEY (`idBonLivraison`,`idProduit`),
  KEY `concerner_produit0_FK` (`idProduit`),
  KEY `fk_cmdeapprodepot` (`idCmdeAppropDepot`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Structure de la table `operationcaisse`

DROP TABLE IF EXISTS `operationcaisse`;
CREATE TABLE IF NOT EXISTS `operationcaisse` (
  `idOperation` int NOT NULL AUTO_INCREMENT,
  `dateOperation` date NOT NULL,
  `heureOperation` time NOT NULL,
  `totalPaiement` float NOT NULL,
  `idSalarie` int NOT NULL,
  `idCaisse` int NOT NULL,
  PRIMARY KEY (`idOperation`),
  KEY `operationCaisse_vendeur_FK` (`idSalarie`),
  KEY `operationCaisse_caisse0_FK` (`idCaisse`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Structure de la table `parametrecaisse`

DROP TABLE IF EXISTS `parametrecaisse`;
CREATE TABLE IF NOT EXISTS `parametrecaisse` (
  `idParametre` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idParametre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Structure de la table `preparateur`

DROP TABLE IF EXISTS `preparateur`;
CREATE TABLE IF NOT EXISTS `preparateur` (
  `idSalarie` int NOT NULL,
  `matriculeSalarie` varchar(20) NOT NULL,
  `nomSalarie` varchar(50) NOT NULL,
  `PrenomSalarie` varchar(50) NOT NULL,
  PRIMARY KEY (`idSalarie`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Structure de la table `produit`

DROP TABLE IF EXISTS `produit`;
CREATE TABLE IF NOT EXISTS `produit` (
  `idProduit` int NOT NULL AUTO_INCREMENT,
  `codeProduit` int NOT NULL,
  `stockMag` int NOT NULL,
  `stockMiniMag` int NOT NULL,
  `designationProduit` varchar(50) NOT NULL,
  `prixPdt` decimal(10, 2) NOT NULL,
  `stockEntrepot` int NOT NULL,
  `idCategorie` int NOT NULL,
  PRIMARY KEY (`idProduit`),
  KEY `produit_categorieProduit_FK` (`idCategorie`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Structure de la table `salarie`

DROP TABLE IF EXISTS `salarie`;
CREATE TABLE IF NOT EXISTS `salarie` (
  `idSalarie` int NOT NULL AUTO_INCREMENT,
  `matriculeSalarie` varchar(20) NOT NULL,
  `nomSalarie` varchar(50) NOT NULL,
  `PrenomSalarie` varchar(50) NOT NULL,
  PRIMARY KEY (`idSalarie`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Structure de la table `tarificationproduit`

DROP TABLE IF EXISTS `tarificationproduit`;
CREATE TABLE IF NOT EXISTS `tarificationproduit` (
  `idOperation` int NOT NULL,
  `idProduit` int NOT NULL,
  `tauxTVA` float NOT NULL,
  `prixUnitaire` decimal(10, 2) NOT NULL,
  PRIMARY KEY (`idOperation`,`idProduit`),
  KEY `TarificationProduit_produit0_FK` (`idProduit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Structure de la table `vendeur`

DROP TABLE IF EXISTS `vendeur`;
CREATE TABLE IF NOT EXISTS `vendeur` (
  `idSalarie` int NOT NULL,
  `matriculeSalarie` varchar(20) NOT NULL,
  `nomSalarie` varchar(50) NOT NULL,
  `PrenomSalarie` varchar(50) NOT NULL,
  PRIMARY KEY (`idSalarie`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Structure de la table `authentification`

DROP TABLE IF EXISTS `authentification`;
CREATE TABLE IF NOT EXISTS `authentification` (
  `idSalarie` int NOT NULL,
  `identifiant` varchar(100) NOT NULL,
  `motDePasse` varchar(100) NOT NULL,
  PRIMARY KEY (`idSalarie`),
  CONSTRAINT `authentification_salarie_FK` FOREIGN KEY (`idSalarie`) REFERENCES `salarie` (`idSalarie`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Contraintes pour les tables déchargées

-- Contraintes pour la table `caisse`

ALTER TABLE `caisse`
  ADD CONSTRAINT `caisse_parametreCaisse_FK` FOREIGN KEY (`idParametre`) REFERENCES `parametrecaisse` (`idParametre`);

-- Contraintes pour la table `cmdeapprodepot`

ALTER TABLE `cmdeapprodepot`
  ADD CONSTRAINT `cmdeApproDepot_preparateur_FK` FOREIGN KEY (`idSalarie`) REFERENCES `preparateur` (`idSalarie`);

-- Contraintes pour la table `commande`

ALTER TABLE `commande`
  ADD CONSTRAINT `commande_cmdeApproDepot_FK` FOREIGN KEY (`id`) REFERENCES `cmdeapprodepot` (`id`),
  ADD CONSTRAINT `commande_produit0_FK` FOREIGN KEY (`idProduit`) REFERENCES `produit` (`idProduit`);

-- Contraintes pour la table `concerner`

ALTER TABLE `concerner`
  ADD CONSTRAINT `concerner_BonDeLivraison_FK` FOREIGN KEY (`idBonLivraison`) REFERENCES `bondelivraison` (`idBonLivraison`);