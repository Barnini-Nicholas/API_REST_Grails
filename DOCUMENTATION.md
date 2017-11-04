# Spécifications et documentation technique


## Récupérer un token

 - **URL :** (racine)/API/getToken
 - **Structure data en entrée :** 
   - *GET :* (String : pseudo ;; String : password)
   - *POST :* (String : pseudo ;; String : password)
   - *PUT :* (String : pseudo ;; String : password)
   - *DELETE :* (String : pseudo ;; String : password)
   
 - **Structure data en sortie (si réussite) :** 
   - *GET :* (String : token)
   - *POST :* (String : token)
   - *PUT :* (String : token)
   - *DELETE :* (String : token)
   
 - **Listing des codes :** 
   - *201 :* Le token a été créé. 
   - *400 :* Un des paramètres n'a soit pas été fourni, est null, ou vide.
   - *404 :* La combinaison mot de passe et pseudo est erroné.
   
 - **Exemples CURL :**    
   - ```TOKEN=$(curl.exe http://localhost:8080/API/getToken  -d "pseudo=admin&password=pwdAdmin")```
   
   
## Bibliothèque avec un ID

 - **URL :** (racine)/API/bibliotheque/(id)
 - **Structure data en entrée :** 
   - *GET :* (String : token) // On peut rajouter un header pour récupérer soit du JSON ou du XML.
   - *POST :* (String : token ;; String : nom ;; String : adresse ;; int : anneeConstruction)
   - *PUT :* (String : token ;; String : nom ;; String : adresse ;; int : anneeConstruction)
   - *DELETE :* (String : token)
   
 - **Structure data en sortie (si réussite) :** 
   - *GET :* 
     - *JSON* : ```{"id":5,"livres":[],"nom":"NOUVEAU","adresse":"QQEPART","anneeConstruction":1989}```  
     - *XML* : ```<?xml version="1.0" encoding="UTF-8"?><bibliotheque id="5"><livres /><nom>NOUVEAU</nom><adresse>QQEPART</adresse><anneeConstruction>1989</anneeConstruction></bibliotheque>```
   - *POST :* (int : idBiblio)
   - *PUT :* Texte de confirmation.
   - *DELETE :* Texte de confirmation.
   
 - **Listing des codes :** 
   - *200 :* Requête accepté.
   - *201 :* La bibliothèque a été créé. 
   - *400 :* Un des paramètres n'a soit pas été fourni, est null, ou vide.
   - *404 :* Erreur d'id, de sauvegarde ou de suppression. Un texte est renvoyé expliquant l'erreur.
   
 - **Exemples CURL :**
   - ``` curl.exe  -X POST http://localhost:8080/API/bibliotheque/1?token=$TOKEN  -d "nom=NOUVEAU&adresse=QQEPART&anneeConstruction=1989" ```
   - ``` curl.exe -i -X PUT http://localhost:8080/API/bibliotheque/$outputCURL?token=$TOKEN -d "nom=jojookoko&adresse=ADjijijijR&anneeConstruction=18" ```
   - ``` curl.exe -i -H "Accept: application/json" -X GET http://localhost:8080/API/bibliotheque/$outputCURL?token=$TOKEN ```
   - ``` curl.exe -i -H "Accept: application/xml" -X GET http://localhost:8080/API/bibliotheque/$outputCURL?token=$TOKEN ```
   - ``` curl.exe -i -X DELETE http://localhost:8080/API/bibliotheque/$outputCURL?token=$TOKEN ```
   

## Livre avec un ID

 - **URL :** (racine)/API/livre/(id)
 - **Structure data en entrée :** 
   - *GET :* (String : token) // On peut rajouter un header pour récupérer soit du JSON ou du XML.
   - *POST :* (String : token ;; String : nom ;; Date : dateParution ;; String : ISBN ;; String : auteur ;; int : bibliID)
   - *PUT :* (String : token ;; String : nom ;; Date : dateParution ;; String : ISBN ;; String : auteur)
   - *DELETE :* (String : token)
   
 - **Structure data en sortie (si réussite) :** 
   - *GET :* 
     - *JSON* : ```{"id":8,"auteur":"huhu","dateParution":"2013-03-28T12:24:56Z","nom":"AAAAAAAAAAAAAAAAAAAAAAAAAAAA","ISBN":"ui","bibliotheque":{"id":7}}```  
     - *XML* : ```<?xml version="1.0" encoding="UTF-8"?><livre id="8"><auteur>huhu</auteur><dateParution>2013-03-28 13:24:56.0 CET</dateParution><nom>AAAAAAAAAAAAAAAAAAAAAAAAAAAA</nom><ISBN>ui</ISBN><bibliotheque id="7" /></livre>```
   - *POST :* (int : idLivre)
   - *PUT :* Texte de confirmation.
   - *DELETE :* Texte de confirmation.
   
 - **Listing des codes :** 
   - *200 :* Requête accepté.
   - *201 :* Le livre a été créé. 
   - *400 :* Un des paramètres n'a soit pas été fourni, est null, ou vide.
   - *404 :* Erreur d'id, de sauvegarde ou de suppression. Un texte est renvoyé expliquant l'erreur.
   
 - **Exemples CURL :**
   - ``` curl.exe  -X POST http://localhost:8080/API/livre?token=$TOKEN  -d "nom=AAAAAAAAAAAAAAAAAAAAAAAAAAAA&dateParution=2013-02-28T12:24:56Z&ISBN=ui&auteur=huhu&bibliID=$outputCURLBiblioTest" ```
   - ``` curl.exe -i -X PUT http://localhost:8080/API/livre/$outputCURL?token=$TOKEN -d "nom=BBBBBBBBBBBBBB&dateParution=2013-02-28T12:24:56Z&ISBN=allo&auteur=HUEHUE" ```
   - ``` curl.exe -i -H "Accept: application/json" -X GET http://localhost:8080/API/livre/$outputCURL?token=$TOKEN ```
   - ``` curl.exe -i -H "Accept: application/xml" -X GET http://localhost:8080/API/livre/$outputCURL?token=$TOKEN ```
   - ``` curl.exe -i -X DELETE http://localhost:8080/API/livre/$outputCURL?token=$TOKEN ```
   

## Tout les livres d'une bibliothèque

 - **URL :** (racine)/API/bibliotheque/(id)/livre(s)
 - **Structure data en entrée :** 
   - *GET :* (String : token) // On peut rajouter un header pour récupérer soit du JSON ou du XML.
   - *POST :* (String : token ;; String : nom ;; Date : dateParution ;; String : ISBN ;; String : auteur)
   - *DELETE :* (String : token)
   
 - **Structure data en sortie (si réussite) :** 
   - *GET :* 
     - *JSON* : ```[{"id":9,"auteur":"HOLAQUE TAL","dateParution":"2013-03-28T12:24:56Z","nom":"CCCCCCCCCCCCCCCCCCCCCCCCC","ISBN":"NANI","bibliotheque":{"id":8}}]```  
     - *XML* : ```<?xml version="1.0" encoding="UTF-8"?><set><livre id="9"><auteur>HOLAQUE TAL</auteur><dateParution>2013-03-28 13:24:56.0 CET</dateParution><nom>CCCCCCCCCCCCCCCCCCCCCCCCC</nom><ISBN>NANI</ISBN><bibliotheque id="8" /></livre></set>```
   - *POST :* (int : idLivre)
   - *DELETE :* Texte de confirmation.
   
 - **Listing des codes :** 
   - *200 :* Requête accepté.
   - *201 :* Le livre a été créé. 
   - *400 :* Un des paramètres n'a soit pas été fourni, est null, ou vide.
   - *404 :* Erreur d'id, de sauvegarde ou de suppression. Un texte est renvoyé expliquant l'erreur.
   
 - **Exemples CURL :**
   - ``` curl.exe  -X POST http://localhost:8080/API/bibliotheque/$outputCURLBiblioTest/livres?token=$TOKEN  -d "nom=CCCCCCCCCCCCCCCCCCCCCCCCC&dateParution=2013-02-28T12:24:56Z&ISBN=NANI&auteur=HOLAQUE TAL" ```
   - ``` curl.exe -i -H "Accept: application/json" -X GET http://localhost:8080/API/bibliotheque/$outputCURLBiblioTest/livres?token=$TOKEN ```
   - ``` curl.exe -i -H "Accept: application/xml" -X GET http://localhost:8080/API/bibliotheque/$outputCURLBiblioTest/livres?token=$TOKEN ```
   - ``` curl.exe -i -X DELETE http://localhost:8080/API/bibliotheque/$outputCURLBiblioTest/livres?token=$TOKEN ```
   

## Un livre d'une bibliothèque

 - **URL :** (racine)/API/bibliotheque/(id)/livre/(id)
 - **Structure data en entrée :** 
   - *GET :* (String : token) // On peut rajouter un header pour récupérer soit du JSON ou du XML.
   - *POST :* (String : token ;; String : nom ;; Date : dateParution ;; String : ISBN ;; String : auteur)
   - *PUT :* (String : token ;; String : nom ;; Date : dateParution ;; String : ISBN ;; String : auteur)
   - *DELETE :* (String : token)
   
 - **Structure data en sortie (si réussite) :** 
   - *GET :* 
     - *JSON* : ```{"id":10,"auteur":"huhu","dateParution":"2013-03-28T12:24:56Z","nom":"DDDDDDDDDDDDDDDDDDD","ISBN":"ui","bibliotheque":{"id":9}}```  
     - *XML* : ```<?xml version="1.0" encoding="UTF-8"?><livre id="10"><auteur>huhu</auteur><dateParution>2013-03-28 13:24:56.0 CET</dateParution><nom>DDDDDDDDDDDDDDDDDDD</nom><ISBN>ui</ISBN><bibliotheque id="9" /></livre>```
   - *POST :* (int : idLivre)
   - *PUT :* Texte de confirmation.
   - *DELETE :* Texte de confirmation.
   
 - **Listing des codes :** 
   - *200 :* Requête accepté.
   - *201 :* Le livre a été créé. 
   - *400 :* Un des paramètres n'a soit pas été fourni, est null, ou vide.
   - *404 :* Erreur d'id, de sauvegarde ou de suppression. Un texte est renvoyé expliquant l'erreur.
   
 - **Exemples CURL :**
   - ``` curl.exe  -X POST http://localhost:8080/API/bibliotheque/$outputCURLBiblioTest/livre/1?token=$TOKEN  -d "nom=DDDDDDDDDDDDDDDDDDD&dateParution=2013-02-28T12:24:56Z&ISBN=ui&auteur=huhu" ```
   - ``` curl.exe -i -X PUT http://localhost:8080/API/bibliotheque/$outputCURLBiblioTest/livre/$outputCURL?token=$TOKEN -d "nom=EEEEEEEEEEEEEEEEEEEEEEEEEEEEEE&dateParution=2013-02-28T12:24:56Z&ISBN=allo&auteur=HUEHUE&bibliID=1" ```
   - ``` curl.exe -i -H "Accept: application/json" -X GET http://localhost:8080/API/bibliotheque/$outputCURLBiblioTest/livre/$outputCURL?token=$TOKEN ```
   - ``` curl.exe -i -H "Accept: application/xml" -X GET http://localhost:8080/API/bibliotheque/$outputCURLBiblioTest/livre/$outputCURL?token=$TOKEN ```
   - ``` curl.exe -i -X DELETE http://localhost:8080/API/bibliotheque/$outputCURLBiblioTest/livre/$outputCURL?token=$TOKEN ```
   
   

## Tout les livres

 - **URL :** (racine)/API/livre(s)
 - **Structure data en entrée :** 
   - *GET :* (String : token) // On peut rajouter un header pour récupérer soit du JSON ou du XML.
   - *POST :* (String : token ;; String : nom ;; Date : dateParution ;; String : ISBN ;; String : auteur ;; int bibliID)
   - *DELETE :* (String : token)
   
 - **Structure data en sortie (si réussite) :** 
   - *GET :* 
     - *JSON* : ```[{"id":1,"auteur":"Jojo la fripouille","dateParution":"2013-02-28T12:24:56Z","nom":"livre10","ISBN":"numero10","bibliotheque":{"id":1}},{"id":2,"auteur":"jacky chan","dateParution":"1995-12-25T12:24:56Z","nom":"livre20","ISBN":"numero20","bibliotheque":{"id":1}},{"id":3,"auteur":"Jojo la fripouille","dateParution":"2013-02-28T12:24:56Z","nom":"livre11","ISBN":"numero11","bibliotheque":{"id":2}},{"id":4,"auteur":"jacky chan","dateParution":"1995-12-25T12:24:56Z","nom":"livre21","ISBN":"numero21","bibliotheque":{"id":2}},{"id":5,"auteur":"Jojo la fripouille","dateParution":"2013-02-28T12:24:56Z","nom":"livre12","ISBN":"numero12","bibliotheque":{"id":3}},{"id":6,"auteur":"jacky chan","dateParution":"1995-12-25T12:24:56Z","nom":"livre22","ISBN":"numero22","bibliotheque":{"id":3}},{"id":11,"auteur":"HOLAQUE TAL","dateParution":"2013-03-28T12:24:56Z","nom":"CCCCCCCCCCCCCCCCCCCCCCCCC","ISBN":"NANI","bibliotheque":{"id":11}}]```  
     - *XML* : ```<?xml version="1.0" encoding="UTF-8"?><list><livre id="1"><auteur>Jojo la fripouille</auteur><dateParution>2013-02-28 13:24:56.0 CET</dateParution><nom>livre10</nom><ISBN>numero10</ISBN><bibliotheque id="1" /></livre><livre id="2"><auteur>jacky chan</auteur><dateParution>1995-12-25 13:24:56.0 CET</dateParution><nom>livre20</nom><ISBN>numero20</ISBN><bibliotheque id="1" /></livre><livre id="3"><auteur>Jojo la fripouille</auteur><dateParution>2013-02-28 13:24:56.0 CET</dateParution><nom>livre11</nom><ISBN>numero11</ISBN><bibliotheque id="2" /></livre><livre id="4"><auteur>jacky chan</auteur><dateParution>1995-12-25 13:24:56.0 CET</dateParution><nom>livre21</nom><ISBN>numero21</ISBN><bibliotheque id="2" /></livre><livre id="5"><auteur>Jojo la fripouille</auteur><dateParution>2013-02-28 13:24:56.0 CET</dateParution><nom>livre12</nom><ISBN>numero12</ISBN><bibliotheque id="3" /></livre><livre id="6"><auteur>jacky chan</auteur><dateParution>1995-12-25 13:24:56.0 CET</dateParution><nom>livre22</nom><ISBN>numero22</ISBN><bibliotheque id="3" /></livre><livre id="11"><auteur>HOLAQUE TAL</auteur><dateParution>2013-03-28 13:24:56.0 CET</dateParution><nom>CCCCCCCCCCCCCCCCCCCCCCCCC</nom><ISBN>NANI</ISBN><bibliotheque id="11" /></livre></list>```
   - *POST :* (int : idLivre)
   - *DELETE :* Texte de confirmation.
   
 - **Listing des codes :** 
   - *200 :* Requête accepté.
   - *201 :* Le livre a été créé. 
   - *400 :* Un des paramètres n'a soit pas été fourni, est null, ou vide.
   - *404 :* Erreur d'id, de sauvegarde ou de suppression. Un texte est renvoyé expliquant l'erreur.
   
 - **Exemples CURL :**
   - ``` curl.exe  -X POST http://localhost:8080/API/livres?token=$TOKEN -d "nom=CCCCCCCCCCCCCCCCCCCCCCCCC&dateParution=2013-02-28T12:24:56Z&ISBN=NANI&auteur=HOLAQUE TAL&bibliID=$outputCURLBiblioTest" ```
   - ``` curl.exe -i -H "Accept: application/json" -X GET http://localhost:8080/API/livres?token=$TOKEN ```
   - ``` curl.exe -i -H "Accept: application/xml" -X GET http://localhost:8080/API/livres?token=$TOKEN ```
   - ``` curl.exe -i -X DELETE http://localhost:8080/API/livres?token=$TOKEN ```
  
  
   
## Toutes les bibliothèques

 - **URL :** (racine)/API/bibliotheque(s)
 - **Structure data en entrée :** 
   - *GET :* (String : token) // On peut rajouter un header pour récupérer soit du JSON ou du XML.
   - *POST :* (String : token ;; String : nom ;; String : adresse ;; int : anneeConstruction)
   - *DELETE :* (String : token)
   
 - **Structure data en sortie (si réussite) :** 
   - *GET :* 
     - *JSON* : ```[{"id":1,"livres":[],"nom":"bibi0","adresse":"60, chemin du heho","anneeConstruction":199},{"id":2,"livres":[],"nom":"bibi1","adresse":"60, chemin du heho","anneeConstruction":200},{"id":3,"livres":[],"nom":"bibi2","adresse":"60, chemin du heho","anneeConstruction":201},{"id":4,"livres":[],"nom":"BIBTEEEEEST","adresse":"QQEPARThehe","anneeConstruction":19889},{"id":6,"livres":[],"nom":"BIBTEEEEEST","adresse":"QQEPARThehe","anneeConstruction":19889},{"id":7,"livres":[],"nom":"BIBTEEEEEST","adresse":"QQEPARThehe","anneeConstruction":19889},{"id":8,"livres":[],"nom":"BIBTEEEEEST","adresse":"QQEPARThehe","anneeConstruction":19889},{"id":9,"livres":[],"nom":"BIBTEEEEEST","adresse":"QQEPARThehe","anneeConstruction":19889},{"id":10,"livres":[],"nom":"BIBTEEEEEST","adresse":"QQEPARThehe","anneeConstruction":19889},{"id":11,"livres":[],"nom":"BIBTEEEEEST","adresse":"QQEPARThehe","anneeConstruction":19889},{"id":12,"livres":[],"nom":"BIBTEEEEEST","adresse":"QQEPARThehe","anneeConstruction":19889},{"id":13,"livres":[],"nom":"BIBLISTE","adresse":"QQEPARThehe","anneeConstruction":19889}]```  
     - *XML* : ```<?xml version="1.0" encoding="UTF-8"?><list><bibliotheque id="1"><livres /><nom>bibi0</nom><adresse>60, chemin du heho</adresse><anneeConstruction>199</anneeConstruction></bibliotheque><bibliotheque id="2"><livres /><nom>bibi1</nom><adresse>60, chemin du heho</adresse><anneeConstruction>200</anneeConstruction></bibliotheque><bibliotheque id="3"><livres /><nom>bibi2</nom><adresse>60, chemin du heho</adresse><anneeConstruction>201</anneeConstruction></bibliotheque><bibliotheque id="4"><livres /><nom>BIBTEEEEEST</nom><adresse>QQEPARThehe</adresse><anneeConstruction>19889</anneeConstruction></bibliotheque><bibliotheque id="6"><livres /><nom>BIBTEEEEEST</nom><adresse>QQEPARThehe</adresse><anneeConstruction>19889</anneeConstruction></bibliotheque><bibliotheque id="7"><livres /><nom>BIBTEEEEEST</nom><adresse>QQEPARThehe</adresse><anneeConstruction>19889</anneeConstruction></bibliotheque><bibliotheque id="8"><livres /><nom>BIBTEEEEEST</nom><adresse>QQEPARThehe</adresse><anneeConstruction>19889</anneeConstruction></bibliotheque><bibliotheque id="9"><livres /><nom>BIBTEEEEEST</nom><adresse>QQEPARThehe</adresse><anneeConstruction>19889</anneeConstruction></bibliotheque><bibliotheque id="10"><livres /><nom>BIBTEEEEEST</nom><adresse>QQEPARThehe</adresse><anneeConstruction>19889</anneeConstruction></bibliotheque><bibliotheque id="11"><livres /><nom>BIBTEEEEEST</nom><adresse>QQEPARThehe</adresse><anneeConstruction>19889</anneeConstruction></bibliotheque><bibliotheque id="12"><livres /><nom>BIBTEEEEEST</nom><adresse>QQEPARThehe</adresse><anneeConstruction>19889</anneeConstruction></bibliotheque><bibliotheque id="13"><livres /><nom>BIBLISTE</nom><adresse>QQEPARThehe</adresse><anneeConstruction>19889</anneeConstruction></bibliotheque></list>```
   - *POST :* (int : idBiblio)
   - *DELETE :* Texte de confirmation.
   
 - **Listing des codes :** 
   - *200 :* Requête accepté.
   - *201 :* La bibliothèque a été créé. 
   - *400 :* Un des paramètres n'a soit pas été fourni, est null, ou vide.
   - *404 :* Erreur d'id, de sauvegarde ou de suppression. Un texte est renvoyé expliquant l'erreur.
   
 - **Exemples CURL :**
   - ``` curl.exe  -X POST http://localhost:8080/API/bibliotheques?token=$TOKEN -d "nom=BIBLISTE&adresse=QQEPARThehe&anneeConstruction=19889" ```
   - ``` curl.exe -i -H "Accept: application/json" -X GET http://localhost:8080/API/bibliotheques?token=$TOKEN" ```
   - ``` curl.exe -i -H "Accept: application/xml" -X GET http://localhost:8080/API/bibliotheques?token=$TOKEN ```
   - ``` curl.exe -i -X DELETE http://localhost:8080/API/bibliotheques?token=$TOKEN ```
     
