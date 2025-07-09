CREATE DATABASE bdnb_belfort_db;
USE bdnb_belfort_db;


/* 1. Vérification des valeurs aberrantes pour la variable s_geom_groupe (surface au sol de la géométrie du bâtiment groupe). */
SELECT 
	bg.batiment_groupe_id,
	bg.s_geom_groupe,
	bgspu.usage_principal_bdnb_open,
    bgbzc.l_nature,
    bgbzc.l_nature_detaillee,
    bgbzc.l_toponyme,
    a.numero,
    a.type_voie,
    a.nom_voie,
    a.libelle_adresse,
    a.code_commune_insee,
	a.libelle_commune
FROM batiment_groupe AS bg
LEFT JOIN batiment_groupe_synthese_propriete_usage AS bgspu ON bg.batiment_groupe_id = bgspu.batiment_groupe_id
LEFT JOIN batiment_groupe_bdtopo_zoac_corrige AS bgbzc ON bgspu.batiment_groupe_id = bgbzc.batiment_groupe_id
LEFT JOIN rel_batiment_groupe_adresse AS rbga ON bgbzc.batiment_groupe_id = rbga.batiment_groupe_id
LEFT JOIN adresse AS a ON rbga.cle_interop_adr = a.cle_interop_adr
ORDER BY s_geom_groupe DESC
LIMIT 10;


/* 2. Vérification des valeurs aberrantes pour les variables hauteur_mean et max_hauteur. */
SELECT
	bgbb.batiment_groupe_id,
    bgbb.l_nature,
    bgbb.l_usage_1,
    bgbb.l_usage_2,
    bgbb.max_hauteur,
	bgspu.usage_principal_bdnb_open,
    bgbzc.l_nature,
    bgbzc.l_nature_detaillee,
    bgbzc.l_toponyme,
    a.numero,
    a.type_voie,
    a.nom_voie,
    a.libelle_adresse,
    a.code_commune_insee,
	a.libelle_commune
FROM batiment_groupe_bdtopo_bat AS bgbb
LEFT JOIN batiment_groupe_synthese_propriete_usage AS bgspu ON bgbb.batiment_groupe_id = bgspu.batiment_groupe_id
LEFT JOIN batiment_groupe_bdtopo_zoac_corrige AS bgbzc ON bgspu.batiment_groupe_id = bgbzc.batiment_groupe_id
LEFT JOIN rel_batiment_groupe_adresse AS rbga ON bgbzc.batiment_groupe_id = rbga.batiment_groupe_id
LEFT JOIN adresse AS a ON rbga.cle_interop_adr = a.cle_interop_adr
WHERE max_hauteur = 0;


/* 3. Vérification des valeurs aberrantes pour la variable valeurs foncières. */
SELECT
	bgdosc.batiment_groupe_id,
    bgdosc.valeur_fonciere_max,
    bgspu.usage_principal_bdnb_open,
	bgbzc.l_nature,
    bgbzc.l_nature_detaillee,
    bgbzc.l_toponyme,
    a.numero,
    a.type_voie,
    a.nom_voie,
    a.libelle_adresse,
    a.code_commune_insee,
	a.libelle_commune
FROM batiment_groupe_dvf_open_statistique_corrige AS bgdosc
LEFT JOIN batiment_groupe_synthese_propriete_usage AS bgspu ON bgdosc.batiment_groupe_id = bgspu.batiment_groupe_id
LEFT JOIN batiment_groupe_bdtopo_zoac_corrige AS bgbzc ON bgspu.batiment_groupe_id = bgbzc.batiment_groupe_id
LEFT JOIN rel_batiment_groupe_adresse AS rbga ON bgbzc.batiment_groupe_id = rbga.batiment_groupe_id
LEFT JOIN adresse AS a ON rbga.cle_interop_adr = a.cle_interop_adr
ORDER BY valeur_fonciere_max DESC
LIMIT 10;


/* 4. Vérification des valeurs aberrantes pour la variable prix au m². */
SELECT
	bgdosc.batiment_groupe_id,
    bgdosc.prix_m2_local_max,
    bgspu.usage_principal_bdnb_open,
	bgbzc.l_nature,
    bgbzc.l_nature_detaillee,
    bgbzc.l_toponyme,
    a.numero,
    a.type_voie,
    a.nom_voie,
    a.libelle_adresse,
    a.code_commune_insee,
	a.libelle_commune
FROM batiment_groupe_dvf_open_statistique_corrige AS bgdosc
LEFT JOIN batiment_groupe_synthese_propriete_usage AS bgspu ON bgdosc.batiment_groupe_id = bgspu.batiment_groupe_id
LEFT JOIN batiment_groupe_bdtopo_zoac_corrige AS bgbzc ON bgspu.batiment_groupe_id = bgbzc.batiment_groupe_id
LEFT JOIN rel_batiment_groupe_adresse AS rbga ON bgbzc.batiment_groupe_id = rbga.batiment_groupe_id
LEFT JOIN adresse AS a ON rbga.cle_interop_adr = a.cle_interop_adr
ORDER BY prix_m2_local_max DESC
LIMIT 10;


/* 5. Vérification des valeurs aberrantes pour la variable de surface des parcelles. */
SELECT
	p.parcelle_id,
    p.s_geom_parcelle,
    bgspu.batiment_groupe_id,
    bgspu.usage_principal_bdnb_open,
	bgbzc.l_nature,
    bgbzc.l_nature_detaillee,
    bgbzc.l_toponyme,
    a.numero,
    a.type_voie,
    a.nom_voie,
    a.libelle_adresse,
    a.code_commune_insee,
	a.libelle_commune
FROM parcelle AS p
LEFT JOIN rel_batiment_groupe_parcelle AS rbgp ON p.parcelle_id = rbgp.parcelle_id
LEFT JOIN batiment_groupe_synthese_propriete_usage AS bgspu ON rbgp.batiment_groupe_id = bgspu.batiment_groupe_id
LEFT JOIN batiment_groupe_bdtopo_zoac_corrige AS bgbzc ON bgspu.batiment_groupe_id = bgbzc.batiment_groupe_id
LEFT JOIN rel_batiment_groupe_adresse AS rbga ON bgbzc.batiment_groupe_id = rbga.batiment_groupe_id
LEFT JOIN adresse AS a ON rbga.cle_interop_adr = a.cle_interop_adr
ORDER BY s_geom_parcelle DESC
LIMIT 10;
