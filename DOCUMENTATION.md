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
   - *POST :* (int : ibBiblio)
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
   
   
   
## TEMPLATE

 - **URL :** (racine)/API/getToken
 - **Structure data en entrée :** 
   - *GET :*
   - *POST :*
   - *PUT :*
   - *DELETE :*
   
 - **Structure data en sortie (si réussite) :** 
   - *GET :*
   - *POST :*
   - *PUT :*
   - *DELETE :*
   
 - **Listing des codes :** 
   - *200 :*
   - *201 :*
   - *400 :*
   - *404 :*
   
 - **Exemples CURL :**
   - ```  ```
