package tp

class Bibliotheque {

    String nom
    String adresse
    int anneeConstruction

    static hasMany = [livres : Livre]

    static constraints = {
    }
}
