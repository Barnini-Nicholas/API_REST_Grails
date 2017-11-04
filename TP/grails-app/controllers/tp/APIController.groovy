package tp

import grails.converters.JSON
import grails.converters.XML

import grails.transaction.Transactional

@Transactional(readOnly = true)
class APIController {

    public TokenService = new TokenService();

    String pseudo = "admin";
    String pwd = "pwdAdmin";


    def getToken() {

        if (params.pseudo == null || params.pseudo == "") {
            render(status: 400, text: "Le pseudo n'a pas été fourni pour récupérer un token") as JSON
        } else if (params.password == null || params.password == "") {
            render(status: 400, text: "Le password n'a pas été fourni pour récupérer un token") as JSON
        }

        if (pseudo == params.pseudo && pwd == params.password) {
            System.out.println("TOKEN : Création d'un token -> " + new Date().toString())
            String returnedToken = TokenService.createToken(new Date(), 60, params.pseudo + params.password)
            render(status: 201, text: "${returnedToken}")
        } else {
            response.status = 404
        }
    }

    def bibliotheque() {

        println("PARAMS: " + params)

        System.out.println("params.token == " + params.token)
        if (params.token == null || params.token == "") {
            this.render(status: 400, text: "Le token n'a pas été fourni dans la requête") as JSON
            return false
        }
        if (!TokenService.isValid(params.token)) {
            this.render(status: 404, text: "Le token n'est plus valide") as JSON
            return false
        }

        switch (request.getMethod()) {

            case "POST": // Créer

                if (params.nom == null || params.nom == "") {
                    render(status: 400, text: "Le nom n'a pas été fourni pour créer la bibliothéque") as JSON
                } else if (params.adresse == null || params.adresse == "") {
                    render(status: 400, text: "L'adresse n'a pas été fourni pour créer la bibliothéque") as JSON
                } else if (params.anneeConstruction == null || params.anneeConstruction == "" || !APIService.isInt(params.anneeConstruction)) {
                    render(status: 400, text: "L'anneeConstruction n'a pas été fourni ou n'est pas un entier.") as JSON
                }

                def bibliInstance = new Bibliotheque(params)
                if (bibliInstance.save(flush: true)) {
                    render(status: 201, text: "${bibliInstance.id}")
                } else {
                    response.status = 404
                }


                break;

            case "GET": // Récupérer

                def bibli = Bibliotheque.findById(params.id)
                if (!bibli) {
                    render(status: 404, text: "L'id de cette bibliotheque n'existe pas.") as JSON
                } else {
                    withFormat {
                        json { render bibli as JSON }
                        xml { render bibli as XML }
                    }
                }
                break;

            case "PUT": // Modifier

                def bibli = Bibliotheque.findById(params.id)
                if (!bibli) {
                    render(status: 404, text: "L'id de cette bibliotheque n'existe pas.") as JSON
                }

                boolean hasBeenModified = false

                if (!(params.nom == null || params.nom == "")) {
                    bibli.nom = params.nom
                    hasBeenModified = true
                }
                if (!(params.adresse == null || params.adresse == "")) {
                    bibli.adresse = params.adresse
                    hasBeenModified = true
                }
                if (!(params.anneeConstruction == null || params.anneeConstruction == "" || !APIService.isInt(params.anneeConstruction))) {
                    bibli.anneeConstruction = Integer.parseInt(params.anneeConstruction)
                    hasBeenModified = true
                }

                if (!hasBeenModified) { // rien modifier
                    render(status: 400, text: "Aucune modification n'a été faites ou il manque des params.") as JSON
                } else {
                    if (bibli.save(flush: true)) {
                        render(status: 200, text: "La bibliotheque (${bibli.id}) a été modifié.")
                    } else {
                        response.status = 404
                    }
                }
                break;

            case "DELETE": // Supprimer

                def bibli = Bibliotheque.findById(params.id)
                if (!bibli) {
                    render(status: 404, text: "L'id de cette bibliotheque n'existe pas.") as JSON
                } else {
                    def IDdef = bibli.id
                    bibli.delete(flush: true)
                    if (!Bibliotheque.exists(IDdef))
                        render(status: 200, text: "La bibliotheque ($IDdef) a été supprimé.") as JSON
                    else
                        render(status: 404, text: "La bibliotheque ($IDdef) n'a pas pu être supprimé.") as JSON
                }

                break;

        //case "HEAD": // Informations sur une ressource

        //break;

            default:
                render(status: 405, text: "Vous essayez d'utiliser autres chose que GET/PUT/POST/DELETE.") as JSON
                break;
        }
    }

    def livre() {

        println("PARAMS: " + params)

        System.out.println("params.token == " + params.token)
        if (params.token == null || params.token == "") {
            this.render(status: 400, text: "Le token n'a pas été fourni dans la requête") as JSON
            return false
        }
        if (!TokenService.isValid(params.token)) {
            this.render(status: 404, text: "Le token n'est plus valide") as JSON
            return false
        }

        switch (request.getMethod()) {

            case "POST": // Créer


                if (params.nom == null || params.nom == "") {
                    render(status: 400, text: "Le nom n'a pas été fourni pour créer le livre") as JSON
                } else if (params.ISBN == null || params.ISBN == "") {
                    render(status: 400, text: "L'ISBN n'a pas été fourni pour créer le livre") as JSON
                } else if (params.auteur == null || params.auteur == "") {
                    render(status: 400, text: "L'auteur n'a pas été fourni pour créer le livre") as JSON
                } else if (params.dateParution == null || params.dateParution == "") {
                    render(status: 400, text: "La date n'a pas été fourni pour créer le livre") as JSON
                } else if (params.bibliID == null || params.bibliID == "") {
                    render(status: 400, text: "La bibliID n'a pas été fourni pour créer le livre") as JSON
                }

                def bibli = Bibliotheque.findById(params.bibliID)
                if (bibli == null) {
                    render(status: 404, text: "L'id de cette bibliotheque n'existe pas.") as JSON
                } else {

                    Livre li = new Livre(nom: params.nom, dateParution: APIService.getDateFromStringSeri(params.dateParution), ISBN: params.ISBN, auteur: params.auteur)

                    bibli.addToLivres(li)
                    if (bibli.save(flush: true) == null)
                        render(status: 404, text: "Le livre n'a pas pu être sauvegardé.") as JSON
                    else
                        render(status: 201, text: "${li.id}") as JSON
                }

                break;

            case "GET": // Récupérer

                def livre = Livre.findById(params.id)
                if (!livre) {
                    render(status: 404, text: "L'id de ce livre n'existe pas.") as JSON
                } else {
                    withFormat {
                        json { render livre as JSON }
                        xml { render livre as XML }
                    }
                }
                break;

            case "PUT": // Modifier

                def livre = Livre.findById(params.id)
                if (!livre) {
                    render(status: 404, text: "L'id de ce livre n'existe pas.") as JSON
                }

                boolean hasBeenModified = false

                if (!(params.nom == null || params.nom == "")) {
                    livre.nom = params.nom
                    hasBeenModified = true
                }

                if (!(params.ISBN == null || params.ISBN == "")) {
                    livre.ISBN = params.ISBN
                    hasBeenModified = true
                }

                if (!(params.auteur == null || params.auteur == "")) {
                    livre.auteur = params.auteur
                    hasBeenModified = true
                }

                if (!(params.dateParution == null || params.dateParution == "")) {
                    livre.dateParution = APIService.getDateFromStringSeri(params.dateParution)
                    hasBeenModified = true
                }

                if (!hasBeenModified) { // rien modifier
                    render(status: 400, text: "Aucune modification n'a été faites ou il manque des params.") as JSON
                } else {
                    if (livre.save(flush: true)) {
                        render(status: 200, text: "Le livre (${livre.id}) a été modifié.")
                    } else {
                        response.status = 404
                    }
                }
                break;

            case "DELETE": // Supprimer

                def livre = Livre.findById(params.id)

                if (!livre) {
                    render(status: 404, text: "L'id de ce livre n'existe pas.") as JSON
                } else {
                    def livreIDdef = livre.id
                    livre.delete(flush: true)
                    if (!Livre.exists(livreIDdef))
                        render(status: 200, text: "Le livre ($livreIDdef) a été supprimé.") as JSON
                    else
                        render(status: 404, text: "Le livre ($livreIDdef) n'a pas pu être supprimé.") as JSON
                }

                break;

        //case "HEAD": // Informations sur une ressource

        //break;

            default:
                render(status: 405, text: "Vous essayez d'utiliser autres chose que GET/PUT/POST/DELETE.") as JSON
                break;
        }
    }

    def listLivreDansUneBibliotheque() {

        println("PARAMS: " + params)

        System.out.println("params.token == " + params.token)
        if (params.token == null || params.token == "") {
            this.render(status: 400, text: "Le token n'a pas été fourni dans la requête") as JSON
            return false
        }
        if (!TokenService.isValid(params.token)) {
            this.render(status: 404, text: "Le token n'est plus valide") as JSON
            return false
        }

        switch (request.getMethod()) {
            case "GET":

                def bibli = Bibliotheque.findById(params.id)
                if (!bibli) {
                    render(status: 404, text: "L'id de cette bibliotheque n'existe pas.") as JSON
                } else {

                    Set<Livre> listLivre = bibli.livres

                    withFormat {
                        json { render listLivre as JSON }
                        xml { render listLivre as XML }
                    }
                }

                break

            case "DELETE":

                def bibli = Bibliotheque.findById(params.id)
                if (!bibli) {
                    render(status: 404, text: "L'id de cette bibliotheque n'existe pas.") as JSON
                } else {

                    def livres = Livre.findAllByBibliotheque(bibli)
                    livres.each { livre ->
                        bibli.removeFromLivres(livre)
                        livre.delete(flush: true)
                    }

                    render(status: 200, text: "Les livres ont été supprimés de la bibliothéque n°${params.id} avec succés.") as JSON
                }

                break

            case "POST":
                // A FINIR
                def bibli = Bibliotheque.findById(params.id)
                if (!bibli) {
                    render(status: 404, text: "L'id de cette bibliotheque n'existe pas.") as JSON
                } else {

                    if (params.nom == null || params.nom == "") {
                        render(status: 400, text: "Le nom n'a pas été fourni pour créer le livre") as JSON
                    } else if (params.ISBN == null || params.ISBN == "") {
                        render(status: 400, text: "L'ISBN n'a pas été fourni pour créer le livre") as JSON
                    } else if (params.auteur == null || params.auteur == "") {
                        render(status: 400, text: "L'auteur n'a pas été fourni pour créer le livre") as JSON
                    } else if (params.dateParution == null || params.dateParution == "") {
                        render(status: 400, text: "La date n'a pas été fourni pour créer le livre") as JSON
                    }

                    Livre li = new Livre(nom: params.nom, dateParution: APIService.getDateFromStringSeri(params.dateParution), ISBN: params.ISBN, auteur: params.auteur)

                    bibli.addToLivres(li)
                    if (bibli.save(flush: true) == null)
                        render(status: 404, text: "Le livre n'a pas pu être sauvegardé.") as JSON
                    else
                        render(status: 201, text: "$li.id") as JSON
                }

                break

            default:
                render(status: 405, text: "Uniquement GET, POST et DELETE supporté pour \"API/bibliotheque/<id>/livres.\"") as JSON
                break
        }
    }

    def UnLivreDansUneBibliotheque() {

        println("PARAMS: " + params)

        System.out.println("params.token == " + params.token)
        if (params.token == null || params.token == "") {
            this.render(status: 400, text: "Le token n'a pas été fourni dans la requête") as JSON
            return false
        }
        if (!TokenService.isValid(params.token)) {
            this.render(status: 404, text: "Le token n'est plus valide") as JSON
            return false
        }

        switch (request.getMethod()) {

            case "POST": // A FINIR
                if (params.nom == null || params.nom == "") {
                    render(status: 400, text: "Le nom n'a pas été fourni pour créer le livre") as JSON
                } else if (params.ISBN == null || params.ISBN == "") {
                    render(status: 400, text: "L'ISBN n'a pas été fourni pour créer le livre") as JSON
                } else if (params.auteur == null || params.auteur == "") {
                    render(status: 400, text: "L'auteur n'a pas été fourni pour créer le livre") as JSON
                } else if (params.dateParution == null || params.dateParution == "") {
                    render(status: 400, text: "La date n'a pas été fourni pour créer le livre") as JSON
                }

                def bibli = Bibliotheque.findById(params.id)
                if (bibli == null) {
                    render(status: 404, text: "L'id de cette bibliotheque n'existe pas.") as JSON
                } else {

                    Livre li = new Livre(nom: params.nom, dateParution: APIService.getDateFromStringSeri(params.dateParution), ISBN: params.ISBN, auteur: params.auteur)

                    bibli.addToLivres(li)
                    if (bibli.save(flush: true) == null)
                        render(status: 404, text: "Le livre n'a pas pu être sauvegardé.") as JSON
                    else
                        render(status: 201, text: "$li.id") as JSON
                }

                break

            case "GET":
                def bibli = Bibliotheque.findById(params.id)
                if (!bibli) {
                    render(status: 404, text: "L'id de cette bibliotheque (${params.id}) n'existe pas.") as JSON
                } else {

                    def livre = Livre.findById(params.idLivre)

                    if (livre == null) {
                        render(status: 404, text: "L'id de ce livre (${params.idLivre}) n'existe pas.") as JSON
                    }

                    if (livre.bibliotheque.id != bibli.id)
                        render(status: 404, text: "Le livre n'est pas dans la bibliothéque spécifié") as JSON


                    withFormat {
                        json { render livre as JSON }
                        xml { render livre as XML }
                    }


                }
                break

            case "PUT":

                def bibli = Bibliotheque.findById(params.id)
                if (!bibli) {
                    render(status: 404, text: "L'id de cette bibliotheque (${params.id}) n'existe pas.") as JSON
                }


                def livre = Livre.findById(params.idLivre)
                if (!livre) {
                    render(status: 404, text: "L'id de ce livre n'existe pas.") as JSON
                }

                if (livre.bibliotheque.id != bibli.id)
                    render(status: 404, text: "Le livre n'est pas dans la bibliothéque spécifié") as JSON

                boolean hasBeenModified = false

                if (!(params.nom == null || params.nom == "")) {
                    livre.nom = params.nom
                    hasBeenModified = true
                }

                if (!(params.ISBN == null || params.ISBN == "")) {
                    livre.ISBN = params.ISBN
                    hasBeenModified = true
                }

                if (!(params.auteur == null || params.auteur == "")) {
                    livre.auteur = params.auteur
                    hasBeenModified = true
                }

                if (!(params.dateParution == null || params.dateParution == "")) {
                    livre.dateParution = APIService.getDateFromStringSeri(params.dateParution)
                    hasBeenModified = true
                }

                if (!hasBeenModified) { // rien modifier
                    render(status: 400, text: "Aucune modification n'a été faites ou il manque des params.") as JSON
                } else {
                    if (livre.save(flush: true)) {
                        render(status: 200, text: "Le livre (${livre.id}) a été modifié.")
                    } else {
                        response.status = 404
                    }
                }
                break

            case "DELETE":

                def bibli = Bibliotheque.findById(params.id)
                if (!bibli) {
                    render(status: 404, text: "L'id de cette bibliotheque (${params.id}) n'existe pas.") as JSON
                } else {

                    def livre = Livre.findById(params.idLivre)
                    if (livre == null) {
                        render(status: 404, text: "L'id de ce livre (${params.idLivre}) n'existe pas.") as JSON
                    } else {

                        if (livre.bibliotheque.id != bibli.id)
                            render(status: 404, text: "Le livre n'est pas dans la bibliothéque spécifié") as JSON

                        def livreIDDef = livre.id
                        livre.delete(flush: true)

                        if (!Livre.exists(livre.id))
                            render(status: 201, text: "Le livre ($livreIDDef) a été supprimé.") as JSON
                        else
                            render(status: 404, text: "Le livre ($livreIDDef) n'a pas pu être supprimé.") as JSON
                    }
                }

                break

            default:
                render(status: 405, text: "Vous essayez d'utiliser autres chose que GET/PUT/POST/DELETE.") as JSON
                break;

        }

    }

    def listBibliotheque() {

        println("PARAMS: " + params)

        System.out.println("params.token == " + params.token)
        if (params.token == null || params.token == "") {
            this.render(status: 400, text: "Le token n'a pas été fourni dans la requête") as JSON
            return false
        }
        if (!TokenService.isValid(params.token)) {
            this.render(status: 404, text: "Le token n'est plus valide") as JSON
            return false
        }

        switch (request.getMethod()) {
            case "GET":

                def bibli = Bibliotheque.findAll()
                if (bibli.size() < 1) {
                    render(status: 404, text: "Aucune bibliothéque à afficher.") as JSON
                } else {

                    withFormat {
                        json { render bibli as JSON }
                        xml { render bibli as XML }
                    }
                }

                break

            case "DELETE":

                def bibli = Bibliotheque.findAll()
                if (bibli.size() < 1) {
                    render(status: 404, text: "Aucune bibliothéque à supprimer.") as JSON
                } else {

                    bibli.each { bibliotheque ->
                        bibliotheque.delete(flush: true)
                    }

                    render(status: 200, text: "Les bibliothéques ainsi que leurs livres correspondants ont bien été supprimés.") as JSON
                }

                break

            case "POST":

                if (params.nom == null || params.nom == "") {
                    render(status: 400, text: "Le nom n'a pas été fourni pour créer la bibliothéque") as JSON
                } else if (params.adresse == null || params.adresse == "") {
                    render(status: 400, text: "L'adresse n'a pas été fourni pour créer la bibliothéque") as JSON
                } else if (params.anneeConstruction == null || params.anneeConstruction == "" || !APIService.isInt(params.anneeConstruction)) {
                    render(status: 400, text: "L'anneeConstruction n'a pas été fourni ou n'est pas un entier") as JSON
                }

                def bibliInstance = new Bibliotheque(params)
                if (bibliInstance.save(flush: true)) {
                    render(status: 201, text: "${bibliInstance.id}")
                } else {
                    response.status = 404
                }


                break

            default:
                render(status: 405, text: "Uniquement GET, POST et DELETE supporté pour \"API/bibliotheques.\"") as JSON
                break
        }
    }

    def listLivre() {


        println("PARAMS: " + params)

        System.out.println("params.token == " + params.token)
        if (params.token == null || params.token == "") {
            this.render(status: 400, text: "Le token n'a pas été fourni dans la requête") as JSON
            return false
        }
        if (!TokenService.isValid(params.token)) {
            this.render(status: 404, text: "Le token n'est plus valide") as JSON
            return false
        }
        switch (request.getMethod()) {
            case "GET":

                def livres = Livre.findAll()
                if (livres.size() < 1) {
                    render(status: 404, text: "Aucun livres à afficher.") as JSON
                } else {

                    withFormat {
                        json { render livres as JSON }
                        xml { render livres as XML }
                    }
                }

                break

            case "DELETE":

                def livres = Livre.findAll()
                if (livres.size() < 1) {
                    render(status: 404, text: "Aucun livres à supprimer.") as JSON
                } else {

                    livres.each { livre ->
                        livre.delete(flush: true)
                    }

                    render(status: 200, text: "Les livres ont bien été supprimés.") as JSON
                }

                break

            case "POST":

                if (params.nom == null || params.nom == "") {
                    render(status: 400, text: "Le nom n'a pas été fourni pour créer le livre") as JSON
                } else if (params.ISBN == null || params.ISBN == "") {
                    render(status: 400, text: "L'ISBN n'a pas été fourni pour créer le livre") as JSON
                } else if (params.auteur == null || params.auteur == "") {
                    render(status: 400, text: "L'auteur n'a pas été fourni pour créer le livre") as JSON
                } else if (params.dateParution == null || params.dateParution == "") {
                    render(status: 400, text: "La date n'a pas été fourni pour créer le livre") as JSON
                } else if (params.bibliID == null || params.bibliID == "") {
                    render(status: 400, text: "La bibliID n'a pas été fourni pour créer le livre") as JSON
                }

                def bibli = Bibliotheque.findById(params.bibliID)
                if (bibli == null) {
                    render(status: 404, text: "L'id de cette bibliotheque n'existe pas.") as JSON
                } else {

                    Livre li = new Livre(nom: params.nom, dateParution: APIService.getDateFromStringSeri(params.dateParution), ISBN: params.ISBN, auteur: params.auteur)

                    bibli.addToLivres(li)
                    if (bibli.save(flush: true) == null)
                        render(status: 404, text: "Le livre n'a pas pu être sauvegardé.") as JSON
                    else
                        render(status: 201, text: "${li.id}") as JSON
                }

                break

            default:
                render(status: 405, text: "Uniquement GET, POST et DELETE supporté pour \"API/livres.\"") as JSON
                break
        }
    }

    def erreurPartieURLManquante() {
        render(status: 404, text: "L'URL indiqué est mauvaise. Vous pouvez utiliser : \n" +
                " - (racine)/API/getToken?pseudo=admin&password=pwdAdmin\n" +
                " - (racine)/API/bibliotheque/(idBibli)/livre/(idLivre)\n" +
                " - (racine)/API/bibliotheque/(idBibli)/livres\n" +
                " - (racine)/API/bibliotheques\n" +
                " - (racine)/API/bibliotheque/(idBibli)\n" +
                " - (racine)/API/livre/(idLivre)\n" +
                " - (racine)/API/livres") as JSON

    }


}
