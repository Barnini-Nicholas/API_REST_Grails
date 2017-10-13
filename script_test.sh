#!/bin/bash

#set -x

echo "BIBLIOTHEQUE"


echo ""
echo ""
echo "POST"
#on store l'id de la bilbliotheque pour la modif avec PUT 
outputCURL=$(curl.exe  -X POST http://localhost:8080/API/bibliotheque/  -d "nom=NOUVEAU&adresse=QQEPART&anneeConstruction=1989")
echo "curl.exe  -X POST http://localhost:8080/API/bibliotheque/  -d \"nom=NOUVEAU&adresse=QQEPART&anneeConstruction=1989\""
echo "OUTPUT : $outputCURL"


echo ""
echo ""
echo "PUT"
curl.exe -i -X PUT http://localhost:8080/API/bibliotheque/$outputCURL -d "nom=jojookoko&adresse=ADjijijijR&anneeConstruction=18"

echo ""
echo ""
echo "GET/JSON"
curl.exe -i -H "Accept: application/json" -X GET http://localhost:8080/API/bibliotheque/$outputCURL
echo ""
echo 
echo "GET/XML"
curl.exe -i -H "Accept: application/xml"  -X GET http://localhost:8080/API/bibliotheque/$outputCURL

echo ""
echo ""
echo "DELETE"
curl.exe -i -X DELETE http://localhost:8080/API/bibliotheque/$outputCURL



echo ""
echo ""
echo "REQUETE IMBRIQUE"
