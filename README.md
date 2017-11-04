# API_REST_Grails
API Restfull permettant de gérer des bibliothèques et leurs livres. Cette API est protége par un système de TOKEN.


## Documentation

[LIEN vers la documentation.](DOCUMENTATION.md)


## Tester l'API

Pour tester l'API vous pouvez utiliser le script bash "script_test.sh". Grâce à ce script vous pouvez tester la totalité de l'API ou uniquement certaines parties (juste les livres d'une bibliothéque, toutes les bibliothèques, etc.), une option "--help" est disponible.


## Token

L'API nécessite d'utiliser dans un premier temps l'appel à <racine>/API/getToken?pseudo=<pseudo>&password=<password> pour récuper un token hasher en sha1 avec un salt, valide pour 60 secondes, qui doit être envoyé en paramètre à chaque requête (pour un exemple regarder le script de test d'API).
