package tp

class UrlMappings {

    static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/API/bibliotheque/${id}/livre/${idLivre}"(controller: "API", action: "UnLivreDansUneBibliotheque")
        "/API/bibliotheque/${id}/livre/${idLivre}/"(controller: "API", action: "UnLivreDansUneBibliotheque")

        "/API/bibliotheque/${id}/livres"(controller : "API", action : "listLivreDansUneBibliotheque")
        "/API/bibliotheque/${id}/livres/"(controller : "API", action : "listLivreDansUneBibliotheque")

        "/API/bibliotheque/${id}/livre"(controller : "API", action : "listLivreDansUneBibliotheque")
        "/API/bibliotheque/${id}/livre/"(controller : "API", action : "listLivreDansUneBibliotheque")

        //"/API/bibliotheque/${id}/livre"(controller : "API", action : "erreurPartieURLManquante")
        //"/API/bibliotheque/${id}/livre/"(controller : "API", action : "erreurPartieURLManquante")

        "/API/bibliotheques"(controller : "API", action : "listBibliotheque")
        "/API/bibliotheques/"(controller : "API", action : "listBibliotheque")

        "/API/bibliotheque"(controller : "API", action : "listBibliotheque")
        "/API/bibliotheque/"(controller : "API", action : "listBibliotheque")

        "/API/livres"(controller : "API", action : "listLivre")
        "/API/livres/"(controller : "API", action : "listLivre")

        "/API/livre"(controller : "API", action : "listLivre")
        "/API/livre/"(controller : "API", action : "listLivre")

        "/"(view:"/index")
        "500"(view:'/error')
        "404"(controller: "API", action:'erreurPartieURLManquante')
    }
}
