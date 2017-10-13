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

        "/API/bibliotheque/${id}/livre"(controller : "API", action : "erreurPartieURLManquante")
        "/API/bibliotheque/${id}/livre/"(controller : "API", action : "erreurPartieURLManquante")

        "/"(view:"/index")
        "500"(view:'/error')
        "404"(view:'/notFound')
    }
}
