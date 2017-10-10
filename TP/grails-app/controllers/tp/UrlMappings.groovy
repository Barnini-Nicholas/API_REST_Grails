package tp

class UrlMappings {

    static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/API/bibliotheque/${id}/livre/${idLivre}"(controller: "API", action: "bibliotheque")
        "/API/livre/${id}/bibliotheque/${idBibliotheque}"(controller: "API", action: "livre")

        "/"(view:"/index")
        "500"(view:'/error')
        "404"(view:'/notFound')
    }
}
