package tp

class Livre {

    String nom
    Date dateParution
    String ISBN
    String auteur

    static belongsTo = [bibliotheque : Bibliotheque]

    static constraints = {
    }
}
