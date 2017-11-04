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
   
   
## TEMPLATE

 - **URL :** (racine)/API/getToken
 - **Structure data en entrée :** 
   - *GET*
   - *POST*
   - *PUT*
   - *DELETE*
   
 - **Structure data en sortie :** 
   - *GET*
   - *POST*
   - *PUT*
   - *DELETE*
   
 - **Listing des codes :** 
   - *200*
   - *201*
   - *400*
   
 - **Exemples CURL :**
   - *404*
