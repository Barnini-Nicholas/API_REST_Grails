#!/bin/bash

#set -x

if [[ $1 == "--help" ]] || [[ $1 == "-h" ]] ; then
	echo ""
	echo "UTILISATION : $0 [OPTION]"
	echo ""
	echo "OBJECTIF : Permet de tester l'API RESTfull des bibliotheques et des livres."
	echo ""
	echo "OPTION :"
	echo -e "\t--bib,\t\tBiliothèque avec ID."
	echo -e "\t--liv,\t\tLivre avec ID."
	echo -e "\t--riList,\tListe de livres d'une bibliotheque donnée (requête imbriqué)."
	echo -e "\t--riUnique,\tLivre avec ID pour une biliotheque donnée  (requête imbriqué)."
	echo -e "\t--bibList,\tListe des bibliotheques."
	echo -e "\t--livList,\tListe des livres."
	echo ""
	echo "AUTEUR : Barnini Nicholas"
	echo ""
	echo "EXEMPLE : "
	echo -e "\t$0"
	echo -e "\t$0 --all"
	echo -e "\t$0 --riList"
	exit 0
fi

if [[ $# -eq 0 ]] ; then
    TODO="--all"
elif [ $1 == "--bib" ] || [ $1 == "--liv" ]  || [ $1 == "--riList" ] || [ $1 == "--riUnique" ] || [ $1 == "--bibList" ] || [ $1 == "--livList" ] || [ $1 == "--all" ] ; then
	TODO=$1
else
	echo "Probleme d'arguments."
	exit -1
fi


if [[ $TODO == "--bib" ]] || [[ $1 == "--all" ]] ; then

	echo "/////////////////////////////////////////////////////"
	echo "///// BIBLIOTHEQUE"


	echo ""
	echo ""
	echo "/// POST"
	outputCURL=$(curl.exe  -X POST http://localhost:8080/API/bibliotheque/  -d "nom=NOUVEAU&adresse=QQEPART&anneeConstruction=1989")
	echo "curl.exe  -X POST http://localhost:8080/API/bibliotheque/  -d \"nom=NOUVEAU&adresse=QQEPART&anneeConstruction=1989\""
	echo "OUTPUT : $outputCURL"


	echo ""
	echo ""
	echo "/// PUT"
	curl.exe -i -X PUT http://localhost:8080/API/bibliotheque/$outputCURL -d "nom=jojookoko&adresse=ADjijijijR&anneeConstruction=18"

	echo ""
	echo ""
	echo "/// GET/JSON"
	curl.exe -i -H "Accept: application/json" -X GET http://localhost:8080/API/bibliotheque/$outputCURL
	echo ""
	echo 
	echo "/// GET/XML"
	curl.exe -i -H "Accept: application/xml"  -X GET http://localhost:8080/API/bibliotheque/$outputCURL

	echo ""
	echo ""
	echo "/// DELETE"
	curl.exe -i -X DELETE http://localhost:8080/API/bibliotheque/$outputCURL

fi

echo ""
echo ""
echo "/// Création d'une biblio pour le livre"
outputCURLBiblioTest=$(curl.exe  -X POST http://localhost:8080/API/bibliotheques -d "nom=BIBTEEEEEST&adresse=QQEPARThehe&anneeConstruction=19889")
echo "curl.exe  -X POST http://localhost:8080/API/bibliotheques  -d \"nom=BIBTEEEEEST&adresse=QQEPARThehe&anneeConstruction=19889\""
echo "OUTPUT : $outputCURLBiblioTest"


if [[ $TODO == "--liv" ]] || [[ $1 == "--all" ]] ; then

	echo ""
	echo ""
	echo "/////////////////////////////////////////////////////"
	echo "///// LIVRE"

	echo ""
	echo ""
	echo "/// POST"
	outputCURL=$(curl.exe  -X POST http://localhost:8080/API/livre  -d "nom=AAAAAAAAAAAAAAAAAAAAAAAAAAAA&dateParution=2013-02-28T12:24:56Z&ISBN=ui&auteur=huhu&bibliID=$outputCURLBiblioTest")
	echo "curl.exe  -X POST http://localhost:8080/API/livre  -d \"nom=AAAAAAAAAAAAAAAAAAAAAAAAAAAA&dateParution=2013-02-28T12:24:56Z&ISBN=ui&auteur=huhu&bibliID=$outputCURLBiblioTest\""
	echo "OUTPUT : $outputCURL"


	echo ""
	echo ""
	echo "/// PUT"
	curl.exe -i -X PUT http://localhost:8080/API/livre/$outputCURL -d "nom=BBBBBBBBBBBBBB&dateParution=2013-02-28T12:24:56Z&ISBN=allo&auteur=HUEHUE"

	echo ""
	echo ""
	echo "/// GET/JSON"
	curl.exe -i -H "Accept: application/json" -X GET http://localhost:8080/API/livre/$outputCURL
	echo ""
	echo 
	echo "/// GET/XML"
	curl.exe -i -H "Accept: application/xml"  -X GET http://localhost:8080/API/livre/$outputCURL

	echo ""
	echo ""
	echo "/// DELETE"
	curl.exe -i -X DELETE http://localhost:8080/API/livre/$outputCURL

fi

if [[ $TODO == "--riList" ]] || [[ $1 == "--all" ]] ; then


	echo ""
	echo ""
	echo "/////////////////////////////////////////////////////"
	echo "///// REQUETE IMBRIQUE - LISTE"


	echo ""
	echo ""
	echo "/// POST"
	outputCURL=$(curl.exe  -X POST http://localhost:8080/API/bibliotheque/$outputCURLBiblioTest/livres  -d "nom=CCCCCCCCCCCCCCCCCCCCCCCCC&dateParution=2013-02-28T12:24:56Z&ISBN=NANI&auteur=HOLAQUE TAL")
	echo "curl.exe  -X POST http://localhost:8080/API/bibliotheque/$outputCURLBiblioTest/livres  -d \"nom=CCCCCCCCCCCCCCCCCCCCCCCCC&dateParution=2013-02-28T12:24:56Z&ISBN=NANI&auteur=HOLAQUE TAL\""
	echo "OUTPUT : $outputCURL"

	echo ""
	echo ""
	echo "/// GET/JSON"
	curl.exe -i -H "Accept: application/json" -X GET http://localhost:8080/API/bibliotheque/$outputCURLBiblioTest/livres
	echo ""
	echo 
	echo "/// GET/XML"
	curl.exe -i -H "Accept: application/xml"  -X GET http://localhost:8080/API/bibliotheque/$outputCURLBiblioTest/livres

	echo ""
	echo ""
	echo "/// DELETE"
	curl.exe -i -X DELETE http://localhost:8080/API/bibliotheque/$outputCURLBiblioTest/livres

fi

if [[ $TODO == "--riUnique" ]] || [[ $1 == "--all" ]] ; then


	echo ""
	echo ""
	echo "/////////////////////////////////////////////////////"
	echo "///// REQUETE IMBRIQUE - UNIQUE"


	echo ""
	echo ""
	echo "/// POST"
	outputCURL=$(curl.exe  -X POST http://localhost:8080/API/bibliotheque/$outputCURLBiblioTest/livre/1  -d "nom=DDDDDDDDDDDDDDDDDDD&dateParution=2013-02-28T12:24:56Z&ISBN=ui&auteur=huhu")
	echo "curl.exe  -X POST http://localhost:8080/API/bibliotheque/$outputCURLBiblioTest/livre/1  -d \"nom=DDDDDDDDDDDDDDDDDDDDD&dateParution=2013-02-28T12:24:56Z&ISBN=ui&auteur=huhu\""
	echo "OUTPUT : $outputCURL"

	echo ""
	echo ""
	echo "/// PUT"
	curl.exe -i -X PUT http://localhost:8080/API/bibliotheque/$outputCURLBiblioTest/livre/$outputCURL -d "nom=EEEEEEEEEEEEEEEEEEEEEEEEEEEEEE&dateParution=2013-02-28T12:24:56Z&ISBN=allo&auteur=HUEHUE&bibliID=1"

	echo ""
	echo ""
	echo "/// GET/JSON"
	curl.exe -i -H "Accept: application/json" -X GET http://localhost:8080/API/bibliotheque/$outputCURLBiblioTest/livre/$outputCURL
	echo ""
	echo 
	echo "/// GET/XML"
	curl.exe -i -H "Accept: application/xml"  -X GET http://localhost:8080/API/bibliotheque/$outputCURLBiblioTest/livre/$outputCURL

	echo ""
	echo ""
	echo "/// DELETE"
	curl.exe -i -X DELETE http://localhost:8080/API/bibliotheque/$outputCURLBiblioTest/livre/$outputCURL

fi

if [[ $TODO == "--bibList" ]] || [[ $1 == "--all" ]] ; then


	echo ""
	echo ""
	echo "/////////////////////////////////////////////////////"
	echo "///// BIBLIOTHEQUE - LISTE"


	echo ""
	echo ""
	echo "/// POST"
	outputCURL=$(curl.exe  -X POST http://localhost:8080/API/bibliotheques -d "nom=BIBLISTE&adresse=QQEPARThehe&anneeConstruction=19889")
	echo "curl.exe  -X POST http://localhost:8080/API/bibliotheques  -d \"nom=BIBLISTE&adresse=QQEPARThehe&anneeConstruction=19889\""
	echo "OUTPUT : $outputCURL"

	echo ""
	echo ""
	echo "/// GET/JSON"
	curl.exe -i -H "Accept: application/json" -X GET http://localhost:8080/API/bibliotheques
	echo ""
	echo 
	echo "/// GET/XML"
	curl.exe -i -H "Accept: application/xml"  -X GET http://localhost:8080/API/bibliotheques

	echo ""
	echo ""
	echo "/// DELETE"
	curl.exe -i -X DELETE http://localhost:8080/API/bibliotheques

fi

if [[ $TODO == "--livList" ]] || [[ $1 == "--all" ]] ; then


	echo ""
	echo ""
	echo "/////////////////////////////////////////////////////"
	echo "///// LIVRE - LISTE"

	
	echo ""
	echo ""
	echo "/// Création d'une biblio pour le livre"
	outputCURLBiblioTest=$(curl.exe  -X POST http://localhost:8080/API/bibliotheques -d "nom=BIBTEEEEEST&adresse=QQEPARThehe&anneeConstruction=19889")
	echo "curl.exe  -X POST http://localhost:8080/API/bibliotheques  -d \"nom=BIBTEEEEEST&adresse=QQEPARThehe&anneeConstruction=19889\""
	echo "OUTPUT : $outputCURLBiblioTest"

	echo ""
	echo ""
	echo "/// POST"
	outputCURL=$(curl.exe  -X POST http://localhost:8080/API/livres -d "nom=CCCCCCCCCCCCCCCCCCCCCCCCC&dateParution=2013-02-28T12:24:56Z&ISBN=NANI&auteur=HOLAQUE TAL&bibliID=$outputCURLBiblioTest")
	echo "curl.exe  -X POST http://localhost:8080/API/livres  -d \"nom=CCCCCCCCCCCCCCCCCCCCCCCCC&dateParution=2013-02-28T12:24:56Z&ISBN=NANI&auteur=HOLAQUE TAL&bibliID=$outputCURLBiblioTest\""
	echo "OUTPUT : $outputCURL"

	echo ""
	echo ""
	echo "/// GET/JSON"
	curl.exe -i -H "Accept: application/json" -X GET http://localhost:8080/API/livres
	echo ""
	echo 
	echo "/// GET/XML"
	curl.exe -i -H "Accept: application/xml"  -X GET http://localhost:8080/API/livres

	echo ""
	echo ""
	echo "/// DELETE"
	curl.exe -i -X DELETE http://localhost:8080/API/livres
	
fi

