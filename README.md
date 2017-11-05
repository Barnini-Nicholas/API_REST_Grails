# API_REST_Grails
API Restfull permettant de gérer des bibliothèques et leurs livres. Cette API est protége par un système de TOKEN.


## Documentation

[LIEN vers la documentation.](DOCUMENTATION.md)


## Tester l'API

 - Pour tester l'API vous pouvez utiliser le script bash "script_test_réussite.sh". Grâce à ce script vous pouvez tester la totalité de l'API ou uniquement certaines parties (juste les livres d'une bibliothéque, toutes les bibliothèques, etc.), une option "--help" est disponible. Ce premier script test tout les case de réussite.
 - Pour tester les cas d'erreur de l'API on peut vérifier avec le script "script_test_réussite.sh". Il affiche le cas d'erreur supposé être affiché. Comme le script précedent, on le lancer en totalité ou seulement une partie. Voir le --help.


## Token

L'API nécessite d'utiliser dans un premier temps l'appel à (racine)/API/getToken?pseudo=(pseudo)&password=(password) ou (racine)/API/getToken et en ajoutant pseudo et password en data dans curl pour récuper un token hasher en sha1 avec un salt, valide pour 60 secondes, qui doit être envoyé en paramètre à chaque requête (pour un exemple regarder le script de test d'API). Pour connaître l'appel exact : [ici](DOCUMENTATION.md#r%C3%A9cup%C3%A9rer-un-token).

A chaque appel dans l'API (sauf pour getToken) on vérifie si on a reçu un token, si oui on vérifie son existance grâce à la classe TokenService. Si le token existe on vérifie sa validité.
