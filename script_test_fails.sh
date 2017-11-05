#!/bin/bash

#set -x

if [[ $1 == "--help" ]] || [[ $1 == "-h" ]] ; then
	echo ""
	echo "UTILISATION : $0 [OPTION]"
	echo ""
	echo "OBJECTIF : Permet de vérifier les codes erreurs l'API RESTfull des bibliotheques et des livres."
	echo ""
	echo "OPTION :"
	echo -e "\t--all,\t\tTest toutes les fonctionnalités."
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
	echo -e "\t$0 --all > log.txt"
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

	echo "/////////////////////////////////////////////////////"
	echo "///// TOKEN"

	echo ""
	echo ""
	echo "/// Lorsqu'on ne donne pas tous les params : code 400"
	echo "curl.exe http://localhost:8080/API/getToken -d \"pseudo=admin&password=\""
	curl.exe -i http://localhost:8080/API/getToken  -d "pseudo=admin&password="
	
	echo ""
	echo "curl.exe http://localhost:8080/API/getToken -d \"pseudo=admin\""
	curl.exe -i http://localhost:8080/API/getToken  -d "pseudo=admin"
	
	echo ""
	echo ""
	echo "/// Lorsqu'on donne une mauvaise combinaison pseudo/pwd : code 404"
	echo "curl.exe http://localhost:8080/API/getToken -d \"pseudo=admin&password=aze\""
	curl.exe -i http://localhost:8080/API/getToken  -d "pseudo=admin&password=aze"

	echo ""
	echo ""
	echo "/// On récupere un token pour tester la suite"
	echo "curl.exe http://localhost:8080/API/getToken -d \"pseudo=admin&password=pwdAdmin\""
	TOKEN=$(curl.exe http://localhost:8080/API/getToken  -d "pseudo=admin&password=pwdAdmin")
	echo "TOKEN : $TOKEN"
	
	
	
	
if [[ $TODO == "--bib" ]] || [[ $1 == "--all" ]] ; then

	echo "/////////////////////////////////////////////////////"
	echo "///// BIBLIOTHEQUE"


	echo ""
	echo ""
	echo "/// POST fail code : 400 // parametre manquant"
	outputCURL=$(curl.exe  -X POST http://localhost:8080/API/bibliotheque/1?token=$TOKEN  -d "adresse=QQEPART&anneeConstruction=1989")
	echo "curl.exe  -X POST http://localhost:8080/API/bibliotheque/1?token=$TOKEN  -d \"adresse=QQEPART&anneeConstruction=1989\""
	echo "OUTPUT : $outputCURL"

	echo ""
	echo ""
	echo "/// POST (pour test la suite)"
	outputCURL=$(curl.exe  -X POST http://localhost:8080/API/bibliotheque/1?token=$TOKEN  -d "nom=NOUVEAU&adresse=QQEPART&anneeConstruction=1989")
	echo "curl.exe  -X POST http://localhost:8080/API/bibliotheque/1?token=$TOKEN  -d \"nom=NOUVEAU&adresse=QQEPART&anneeConstruction=1989\""
	echo "OUTPUT : $outputCURL"

	echo ""
	echo ""
	echo "/// PUT id bibli inexistant"
	echo curl.exe -i -X PUT http://localhost:8080/API/bibliotheque/10000000?token=$TOKEN -d "nom=jojookoko&adresse=ADjijijijR&anneeConstruction=18"
	curl.exe -i -X PUT http://localhost:8080/API/bibliotheque/10000000?token=$TOKEN -d "nom=jojookoko&adresse=ADjijijijR&anneeConstruction=18"

	echo ""
	echo ""
	echo "/// PUT params manquant"
	echo curl.exe -i -X PUT http://localhost:8080/API/bibliotheque/$outputCURL?token=$TOKEN -d "adresse=ADjijijijR&anneeConstruction=18"
	curl.exe -i -X PUT http://localhost:8080/API/bibliotheque/$outputCURL?token=$TOKEN -d "adresse=ADjijijijR&anneeConstruction=18"
	
	echo ""
	echo ""
	echo "/// PUT annee constrcution n'est pas un int"
	echo curl.exe -i -X PUT http://localhost:8080/API/bibliotheque/$outputCURL?token=$TOKEN -d "adresse=ADjijijijR&anneeConstruction=ALLO"
	curl.exe -i -X PUT http://localhost:8080/API/bibliotheque/$outputCURL?token=$TOKEN -d "adresse=ADjijijijR&anneeConstruction=ALLO"
	
	echo ""
	echo ""
	echo "/// GET/JSON id bibli inexistant"
	echo curl.exe -i -H "Accept: application/json" -X GET http://localhost:8080/API/bibliotheque/84284?token=$TOKEN
	curl.exe -i -H "Accept: application/json" -X GET http://localhost:8080/API/bibliotheque/84284?token=$TOKEN
	
	echo ""
	echo 
	echo "/// GET/XML token mauvais "
	echo curl.exe -i -H "Accept: application/xml"  -X GET http://localhost:8080/API/bibliotheque/$outputCURL?token=randomTOken
	curl.exe -i -H "Accept: application/xml"  -X GET http://localhost:8080/API/bibliotheque/$outputCURL?token=randomTOken

	echo ""
	echo ""
	echo "/// DELETE id bibli inexistant"
	echo curl.exe -i -X DELETE http://localhost:8080/API/bibliotheque/84284?token=$TOKEN
	curl.exe -i -X DELETE http://localhost:8080/API/bibliotheque/84284?token=$TOKEN

fi

echo ""
echo ""
echo "/// Création d'une biblio pour le lirve et tester le token"
outputCURLBiblioTest=$(curl.exe  -X POST http://localhost:8080/API/bibliotheques?token=$TOKEN -d "nom=BIBTEEEEEST&adresse=QQEPARThehe&anneeConstruction=19889")
echo "curl.exe  -X POST http://localhost:8080/API/bibliotheques?token=$TOKEN  -d \"nom=BIBTEEEEEST&adresse=QQEPARThehe&anneeConstruction=19889\""
echo "OUTPUT : $outputCURLBiblioTest"




if [[ $TODO == "--liv" ]] || [[ $1 == "--all" ]] ; then

	echo ""
	echo ""
	echo "/////////////////////////////////////////////////////"
	echo "///// LIVRE"

	echo ""
	echo ""
	echo "/// POST (mauvais params) code : 400"
	outputCURL=$(curl.exe  -X POST http://localhost:8080/API/livre?token=$TOKEN  -d "dateParution=2013-02-28T12:24:56Z&ISBN=ui&auteur=huhu&bibliID=$outputCURLBiblioTest")
	echo "curl.exe  -X POST http://localhost:8080/API/livre?token=$TOKEN  -d \"dateParution=2013-02-28T12:24:56Z&ISBN=ui&auteur=huhu&bibliID=$outputCURLBiblioTest\""
	echo "OUTPUT : $outputCURL"

	echo ""
	echo ""
	echo "/// POST bon pour la suite"
	outputCURL=$(curl.exe  -X POST http://localhost:8080/API/livre?token=$TOKEN  -d "nom=AAAAAAAAAAAAAAAAAAAAAAAAAAAA&dateParution=2013-02-28T12:24:56Z&ISBN=ui&auteur=huhu&bibliID=$outputCURLBiblioTest")
	echo "curl.exe  -X POST http://localhost:8080/API/livre?token=$TOKEN  -d \"nom=AAAAAAAAAAAAAAAAAAAAAAAAAAAA&dateParution=2013-02-28T12:24:56Z&ISBN=ui&auteur=huhu&bibliID=$outputCURLBiblioTest\""
	echo "OUTPUT : $outputCURL"

	
	echo ""
	echo ""
	echo "/// PUT mauvais param 400"
	echo curl.exe -i -X PUT http://localhost:8080/API/livre/$outputCURL?token=$TOKEN -d "&dateParution=2013-02-28T12:24:56Z&ISBN=allo&auteur=HUEHUE"
	curl.exe -i -X PUT http://localhost:8080/API/livre/$outputCURL?token=$TOKEN -d "&dateParution=2013-02-28T12:24:56Z&ISBN=allo&auteur=HUEHUE"
	
	echo ""
	echo ""
	echo "/// PUT mauvais id livre 404 "
	echo curl.exe -i -X PUT http://localhost:8080/API/livre/10000?token=$TOKEN -d "nom=BBBBBBBBBBBBBB&dateParution=2013-02-28T12:24:56Z&ISBN=allo&auteur=HUEHUE"
	curl.exe -i -X PUT http://localhost:8080/API/livre/10000?token=$TOKEN -d "nom=BBBBBBBBBBBBBB&dateParution=2013-02-28T12:24:56Z&ISBN=allo&auteur=HUEHUE"

	echo ""
	echo ""
	echo "/// GET/JSON mauvais id 404"
	echo curl.exe -i -H "Accept: application/json" -X GET http://localhost:8080/API/livre/40000?token=$TOKEN
	curl.exe -i -H "Accept: application/json" -X GET http://localhost:8080/API/livre/40000?token=$TOKEN

	echo ""
	echo ""
	echo "/// DELETE mauvais id 404"
	echo curl.exe -i -X DELETE http://localhost:8080/API/livre/40000?token=$TOKEN
	curl.exe -i -X DELETE http://localhost:8080/API/livre/40000?token=$TOKEN

fi

if [[ $TODO == "--riList" ]] || [[ $1 == "--all" ]] ; then


	echo ""
	echo ""
	echo "/////////////////////////////////////////////////////"
	echo "///// REQUETE IMBRIQUE - LISTE"


	
	echo ""
	echo ""
	echo "/// POST id biblio inexistant 404"
	outputCURL=$(curl.exe  -X POST http://localhost:8080/API/bibliotheque/10000/livres?token=$TOKEN  -d "nom=CCCCCCCCCCCCCCCCCCCCCCCCC&dateParution=2013-02-28T12:24:56Z&ISBN=NANI&auteur=HOLAQUE TAL")
	echo "curl.exe  -X POST http://localhost:8080/API/bibliotheque/10000/livres?token=$TOKEN  -d \"nom=CCCCCCCCCCCCCCCCCCCCCCCCC&dateParution=2013-02-28T12:24:56Z&ISBN=NANI&auteur=HOLAQUE TAL\""
	echo "OUTPUT : $outputCURL"
	
		
	echo ""
	echo ""
	echo "/// POST id biblio inexistant 400"
	outputCURL=$(curl.exe  -X POST http://localhost:8080/API/bibliotheque/$outputCURLBiblioTest/livres?token=$TOKEN  -d "dateParution=2013-02-28T12:24:56Z&ISBN=NANI&auteur=HOLAQUE TAL")
	echo "curl.exe  -X POST http://localhost:8080/API/bibliotheque/$outputCURLBiblioTest/livres?token=$TOKEN  -d \"dateParution=2013-02-28T12:24:56Z&ISBN=NANI&auteur=HOLAQUE TAL\""
	echo "OUTPUT : $outputCURL"
	
	

	echo ""
	echo ""
	echo "/// POST bon pour la suite"
	outputCURL=$(curl.exe  -X POST http://localhost:8080/API/bibliotheque/$outputCURLBiblioTest/livres?token=$TOKEN  -d "nom=CCCCCCCCCCCCCCCCCCCCCCCCC&dateParution=2013-02-28T12:24:56Z&ISBN=NANI&auteur=HOLAQUE TAL")
	echo "curl.exe  -X POST http://localhost:8080/API/bibliotheque/$outputCURLBiblioTest/livres?token=$TOKEN  -d \"nom=CCCCCCCCCCCCCCCCCCCCCCCCC&dateParution=2013-02-28T12:24:56Z&ISBN=NANI&auteur=HOLAQUE TAL\""
	echo "OUTPUT : $outputCURL"
	
	echo ""
	echo ""
	echo "/// GET/JSON id biblio inexistant 404"
	echo	curl.exe -i -H "Accept: application/json" -X GET http://localhost:8080/API/bibliotheque/95959/livres?token=$TOKEN
	curl.exe -i -H "Accept: application/json" -X GET http://localhost:8080/API/bibliotheque/95959/livres?token=$TOKEN
	

	echo ""
	echo ""
	echo "/// DELETE id biblio inexistant 404"
	echo curl.exe -i -X DELETE http://localhost:8080/API/bibliotheque/5454/livres?token=$TOKEN
	curl.exe -i -X DELETE http://localhost:8080/API/bibliotheque/5454/livres?token=$TOKEN

fi

if [[ $TODO == "--riUnique" ]] || [[ $1 == "--all" ]] ; then


	echo ""
	echo ""
	echo "/////////////////////////////////////////////////////"
	echo "///// REQUETE IMBRIQUE - UNIQUE"


	echo ""
	echo ""
	echo "/// POST mauvais id bibli 404 "
	outputCURL=$(curl.exe  -X POST http://localhost:8080/API/bibliotheque/400000/livre/1?token=$TOKEN  -d "nom=DDDDDDDDDDDDDDDDDDD&dateParution=2013-02-28T12:24:56Z&ISBN=ui&auteur=huhu")
	echo "curl.exe  -X POST http://localhost:8080/API/bibliotheque/400000/livre/1?token=$TOKEN  -d \"nom=DDDDDDDDDDDDDDDDDDDDD&dateParution=2013-02-28T12:24:56Z&ISBN=ui&auteur=huhu\""
	echo "OUTPUT : $outputCURL"
	
	echo ""
	echo ""
	echo "/// POST probleme de params 400 "
	outputCURL=$(curl.exe  -X POST http://localhost:8080/API/bibliotheque/$outputCURLBiblioTest/livre/1?token=$TOKEN  -d "nom=&dateParution=2013-02-28T12:24:56Z&ISBN=ui&auteur=huhu")
	echo "curl.exe  -X POST http://localhost:8080/API/bibliotheque/$outputCURLBiblioTest/livre/1?token=$TOKEN  -d \"nom=&dateParution=2013-02-28T12:24:56Z&ISBN=ui&auteur=huhu\""
	echo "OUTPUT : $outputCURL"
	
	echo ""
	echo ""
	echo "/// POST bon pour la suite"
	outputCURL=$(curl.exe  -X POST http://localhost:8080/API/bibliotheque/$outputCURLBiblioTest/livre/1?token=$TOKEN  -d "nom=DDDDDDDDDDDDDDDDDDD&dateParution=2013-02-28T12:24:56Z&ISBN=ui&auteur=huhu")
	echo "curl.exe  -X POST http://localhost:8080/API/bibliotheque/$outputCURLBiblioTest/livre/1?token=$TOKEN  -d \"nom=DDDDDDDDDDDDDDDDDDDDD&dateParution=2013-02-28T12:24:56Z&ISBN=ui&auteur=huhu\""
	echo "OUTPUT : $outputCURL"


	echo ""
	echo 
	echo "/// GET/XML mauvais id biblio 404"
	echo 	curl.exe -i -H "Accept: application/xml"  -X GET http://localhost:8080/API/bibliotheque/7979/livre/$outputCURL?token=$TOKEN
	curl.exe -i -H "Accept: application/xml"  -X GET http://localhost:8080/API/bibliotheque/7979/livre/$outputCURL?token=$TOKEN

	echo ""
	echo ""
	echo "/// DELETE mauvais id bibli"
	echo curl.exe -i -X DELETE http://localhost:8080/API/bibliotheque/7998/livre/$outputCURL?token=$TOKEN
	curl.exe -i -X DELETE http://localhost:8080/API/bibliotheque/7998/livre/$outputCURL?token=$TOKEN
	
	
	echo ""
	echo ""
	echo "/// DELETE mauvais id livre "
	echo curl.exe -i -X DELETE http://localhost:8080/API/bibliotheque/$outputCURLBiblioTest/livre/92754?token=$TOKEN
	curl.exe -i -X DELETE http://localhost:8080/API/bibliotheque/$outputCURLBiblioTest/livre/92754?token=$TOKEN

fi

if [[ $TODO == "--bibList" ]] || [[ $1 == "--all" ]] ; then


	echo ""
	echo ""
	echo "/////////////////////////////////////////////////////"
	echo "///// BIBLIOTHEQUE - LISTE"

	echo ""
	echo ""
	echo "/// POST mauvais params 400 "
	outputCURL=$(curl.exe  -X POST http://localhost:8080/API/bibliotheques?token=$TOKEN -d "adresse=QQEPARThehe&anneeConstruction=19889")
	echo "curl.exe  -X POST http://localhost:8080/API/bibliotheques?token=$TOKEN  -d \"nom=BIBLISTE&adresse=QQEPARThehe&anneeConstruction=19889\""
	echo "OUTPUT : $outputCURL"

	echo ""
	echo ""
	echo "/// POST bon pour la suite"
	outputCURL=$(curl.exe  -X POST http://localhost:8080/API/bibliotheques?token=$TOKEN -d "nom=BIBLISTE&adresse=QQEPARThehe&anneeConstruction=19889")
	echo "curl.exe  -X POST http://localhost:8080/API/bibliotheques?token=$TOKEN  -d \"nom=BIBLISTE&adresse=QQEPARThehe&anneeConstruction=19889\""
	echo "OUTPUT : $outputCURL"


fi

if [[ $TODO == "--livList" ]] || [[ $1 == "--all" ]] ; then


	echo ""
	echo ""
	echo "/////////////////////////////////////////////////////"
	echo "///// LIVRE - LISTE"

	
	echo ""
	echo ""
	echo "/// Création d'une biblio pour le livre"
	outputCURLBiblioTest=$(curl.exe  -X POST http://localhost:8080/API/bibliotheques?token=$TOKEN -d "nom=BIBTEEEEEST&adresse=QQEPARThehe&anneeConstruction=19889")
	echo "curl.exe  -X POST http://localhost:8080/API/bibliotheques?token=$TOKEN  -d \"nom=BIBTEEEEEST&adresse=QQEPARThehe&anneeConstruction=19889\""
	echo "OUTPUT : $outputCURLBiblioTest"

	echo ""
	echo ""
	echo "/// POST mauvais id bibli en data"
	outputCURL=$(curl.exe  -X POST http://localhost:8080/API/livres?token=$TOKEN -d "nom=CCCCCCCCCCCCCCCCCCCCCCCCC&dateParution=2013-02-28T12:24:56Z&ISBN=NANI&auteur=HOLAQUE TAL&bibliID=84545")
	echo "curl.exe  -X POST http://localhost:8080/API/livres?token=$TOKEN  -d \"nom=CCCCCCCCCCCCCCCCCCCCCCCCC&dateParution=2013-02-28T12:24:56Z&ISBN=NANI&auteur=HOLAQUE TAL&bibliID=84545\""
	echo "OUTPUT : $outputCURL"
	
	
	echo ""
	echo ""
	echo "/// POST mauvais param"
	outputCURL=$(curl.exe  -X POST http://localhost:8080/API/livres?token=$TOKEN -d "nom=CCCCCCCCCCCCCCCCCCCCCCCCC&dateParution=2013-02-28T12:24:56Z&auteur=HOLAQUE TAL&bibliID=$outputCURLBiblioTest")
	echo "curl.exe  -X POST http://localhost:8080/API/livres?token=$TOKEN  -d \"nom=CCCCCCCCCCCCCCCCCCCCCCCCC&dateParution=2013-02-28T12:24:56Z&ISBN=NANI&auteur=HOLAQUE TAL&bibliID=$outputCURLBiblioTest\""
	echo "OUTPUT : $outputCURL"

	
fi

echo ""
echo ""
echo "/////////////////////////////////////////////////////"
echo "///// MAUVAIS TOKEN"
echo ""
echo ""
echo "/// GET/JSON avec un token mauvais" 
echo curl.exe -i -H "Accept: application/json" -X GET http://localhost:8080/API/bibliotheque/$outputCURLBiblioTest?token="MAUVAISTOKEN"
curl.exe -i -H "Accept: application/json" -X GET http://localhost:8080/API/bibliotheque/$outputCURLBiblioTest?token="MAUVAISTOKEN"
