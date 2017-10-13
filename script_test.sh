#!/bin/bash

#set -x

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



echo ""
echo ""
echo "/////////////////////////////////////////////////////"
echo "///// LIVRE"


echo ""
echo ""
echo "/// POST"
outputCURL=$(curl.exe  -X POST http://localhost:8080/API/livre  -d "nom=AAAAAAAAAAAAAAAAAAAAAAAAAAAA&dateParution=2013-02-28T12:24:56Z&ISBN=ui&auteur=huhu&bibliID=1")
echo "curl.exe  -X POST http://localhost:8080/API/livre  -d \"nom=AAAAAAAAAAAAAAAAAAAAAAAAAAAA&dateParution=2013-02-28T12:24:56Z&ISBN=ui&auteur=huhu&bibliID=1\""
echo "OUTPUT : $outputCURL"


echo ""
echo ""
echo "/// PUT"
curl.exe -i -X PUT http://localhost:8080/API/livre/$outputCURL -d "nom=BBBBBBBBBBBBBB&dateParution=2013-02-28T12:24:56Z&ISBN=allo&auteur=HUEHUE&bibliID=1"

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



echo ""
echo ""
echo "/////////////////////////////////////////////////////"
echo "///// REQUETE IMBRIQUE - LISTE"


echo ""
echo ""
echo "/// POST"
outputCURL=$(curl.exe  -X POST http://localhost:8080/API/bibliotheque/1/livres  -d "nom=CCCCCCCCCCCCCCCCCCCCCCCCC&dateParution=2013-02-28T12:24:56Z&ISBN=NANI&auteur=HOLAQUE TAL&bibliID=1")
echo "curl.exe  -X POST http://localhost:8080/API/bibliotheque/1/livres  -d \"nom=CCCCCCCCCCCCCCCCCCCCCCCCC&dateParution=2013-02-28T12:24:56Z&ISBN=NANI&auteur=HOLAQUE TAL&bibliID=1\""
echo "OUTPUT : $outputCURL"

echo ""
echo ""
echo "/// GET/JSON"
curl.exe -i -H "Accept: application/json" -X GET http://localhost:8080/API/bibliotheque/1/livres
echo ""
echo 
echo "/// GET/XML"
curl.exe -i -H "Accept: application/xml"  -X GET http://localhost:8080/API/bibliotheque/1/livres

echo ""
echo ""
echo "/// DELETE"
curl.exe -i -X DELETE http://localhost:8080/API/bibliotheque/1/livres



echo ""
echo ""
echo "/////////////////////////////////////////////////////"
echo "///// REQUETE IMBRIQUE - UNIQUE"


echo ""
echo ""
echo "/// POST"
outputCURL=$(curl.exe  -X POST http://localhost:8080/API/bibliotheque/1/livre/1  -d "nom=DDDDDDDDDDDDDDDDDDD&dateParution=2013-02-28T12:24:56Z&ISBN=ui&auteur=huhu")
echo "curl.exe  -X POST http://localhost:8080/API/bibliotheque/1/livre/1  -d \"nom=DDDDDDDDDDDDDDDDDDDDD&dateParution=2013-02-28T12:24:56Z&ISBN=ui&auteur=huhu\""
echo "OUTPUT : $outputCURL"

echo ""
echo ""
echo "/// PUT"
curl.exe -i -X PUT http://localhost:8080/API/bibliotheque/1/livre/$outputCURL -d "nom=EEEEEEEEEEEEEEEEEEEEEEEEEEEEEE&dateParution=2013-02-28T12:24:56Z&ISBN=allo&auteur=HUEHUE&bibliID=1"

echo ""
echo ""
echo "/// GET/JSON"
curl.exe -i -H "Accept: application/json" -X GET http://localhost:8080/API/bibliotheque/1/livre/$outputCURL
echo ""
echo 
echo "/// GET/XML"
curl.exe -i -H "Accept: application/xml"  -X GET http://localhost:8080/API/bibliotheque/1/livre/$outputCURL

echo ""
echo ""
echo "/// DELETE"
curl.exe -i -X DELETE http://localhost:8080/API/bibliotheque/1/livre/$outputCURL
