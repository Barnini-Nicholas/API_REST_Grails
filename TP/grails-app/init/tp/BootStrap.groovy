package tp

import grails.converters.JSON

class BootStrap {

    def init = { servletContext ->

        Calendar calendar1 = new GregorianCalendar(2013,1,28,13,24,56)
        Calendar calendar2 = new GregorianCalendar(1995,11,25,13,24,56)

        def b1 = new Bibliotheque(nom: "bibi", adresse: "60, chemin du heho", anneeConstruction: 1990)
        def l1 = new Livre(nom: "livre1", dateParution: calendar1.getTime(), ISBN: "numero1", auteur: "Jojo la fripouille")
        def l2 = new Livre(nom: "livre2", dateParution: calendar2.getTime(), ISBN: "numero2", auteur: "jacky chan")

        b1.addToLivres(l1)
        b1.addToLivres(l2)
        b1.save(flush : true)


    }
    def destroy = {
    }
}
