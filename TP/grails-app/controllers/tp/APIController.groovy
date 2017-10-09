package tp

import grails.converters.JSON
import grails.converters.XML

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class APIController {

    def bibliotheque() {
        switch (request.getMethod()) {

            case "POST": // Créer

                if (params.nom == null || params.nom == "") {
                    render(status: 404, text: "Le nom n'a pas été fourni pour créer la bibliothéque") as JSON
                } else if (params.adresse == null || params.adresse == "") {
                    render(status: 404, text: "L'adresse n'a pas été fourni pour créer la bibliothéque") as JSON
                } else if (params.anneeConstruction == null || params.anneeConstruction == "") {
                    render(status: 404, text: "L'anneeConstruction n'a pas été fourni pour créer la bibliothéque") as JSON
                }

                def bibliInstance = new Bibliotheque(params)
                if (bibliInstance.save(flush: true)) {
                    render(status: 201, text: "La bibliotheque(${bibliInstance.id}) a été créé.")
                } else {
                    response.status = 400
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
                if (!(params.anneeConstruction == null || params.anneeConstruction == "")) {
                    bibli.anneeConstruction = Integer.parseInt(params.anneeConstruction)
                    hasBeenModified = true
                }

                if (!hasBeenModified) { // rien modifier
                    render(status: 404, text: "Aucune modification n'a été faites ou il manque des params.") as JSON
                } else {
                    if (bibli.save(flush: true)) {
                        render(status: 201, text: "La bibliotheque (${bibli.id}) a été modifié.")
                    } else {
                        response.status = 400
                    }
                }
                break;

            case "DELETE": // Supprimer

                def bibli = Bibliotheque.findById(params.id)
                if (!bibli) {
                    render(status: 404, text: "L'id de cette bibliotheque n'existe pas.") as JSON
                } else {
                    bibli.delete()
                    if (bibli.save(flush: true))
                        render(status: 201, text: "La bibliotheque (${bibli.id}) a été supprimé.") as JSON
                    else
                        render(status: 404, text: "La bibliotheque (${bibli.id}) n'a pas pu être supprimé.") as JSON
                }

                break;

        //case "HEAD": // Informations sur une ressource

        //break;

            default:

                break;
        }
    }

    def livre() {
        switch (request.getMethod()) {

            case "POST": // Créer

                // FAIRE LA DATE
                if (params.nom == null || params.nom == "") {
                    render(status: 404, text: "Le nom n'a pas été fourni pour créer le livre") as JSON
                } else if (params.ISBN == null || params.ISBN == "") {
                    render(status: 404, text: "L'ISBN n'a pas été fourni pour créer le livre") as JSON
                } else if (params.auteur == null || params.auteur == "") {
                    render(status: 404, text: "L'auteur n'a pas été fourni pour créer le livre") as JSON
                }

                def livreInstance = new Livre(params)
                if (livreInstance.save(flush: true)) {
                    render(status: 201, text: "Le livre (${livreInstance.id}) a été créé.")
                } else {
                    response.status = 400
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

                // FAIRE LA DATE

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

                if (!hasBeenModified) { // rien modifier
                    render(status: 404, text: "Aucune modification n'a été faites ou il manque des params.") as JSON
                } else {
                    if (livre.save(flush: true)) {
                        render(status: 201, text: "Le livre (${livre.id}) a été modifié.")
                    } else {
                        response.status = 400
                    }
                }
                break;

            case "DELETE": // Supprimer

                def livre = Livre.findById(params.id)

                if (!livre) {
                    render(status: 404, text: "L'id de ce livre n'existe pas.") as JSON
                } else {
                    if (livre.delete(flush: true))
                        render(status: 201, text: "Le livre (${livre.id}) a été supprimé.") as JSON
                    else
                        render(status: 404, text: "Le livre (${livre.id}) n'a pas pu être supprimé.") as JSON
                }

                break;

        //case "HEAD": // Informations sur une ressource

        //break;

            default:

                break;
        }
    }


}
