package tp

import grails.converters.JSON

class BootStrap {

    def init = { servletContext ->

        for (int i = 0; i < 3; i++) {
            Calendar calendar1 = new GregorianCalendar(2013, 1, 28, 13, 24, 56)
            Calendar calendar2 = new GregorianCalendar(1995, 11, 25, 13, 24, 56)

            def b1 = new Bibliotheque(nom: "bibi"+i, adresse: "60, chemin du heho", anneeConstruction: 199+i)
            def l1 = new Livre(nom: "livre1"+i, dateParution: calendar1.getTime(), ISBN: "numero1"+i, auteur: "Jojo la fripouille")
            def l2 = new Livre(nom: "livre2"+i, dateParution: calendar2.getTime(), ISBN: "numero2"+i, auteur: "jacky chan")

            b1.addToLivres(l1)
            b1.addToLivres(l2)
            b1.save(flush: true)
        }

    }
    def destroy = {
    }
}
