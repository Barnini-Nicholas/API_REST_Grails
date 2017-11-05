package tp

class TokenAPI {

    private Date dateCreation;
    private int tempsValide;

    public TokenAPI(Date dateCreation, int tempsValide) {
        this.dateCreation = dateCreation
        this.tempsValide = tempsValide
    }

    boolean isValid(){

        //System.out.println(dateCreation.date + tempsValide)
        //System.out.println(new Date().date)
        //System.out.println(new Date().date > dateCreation.date + tempsValide)
        if (new Date().date > dateCreation.date + tempsValide)
            return false
        return true;
    }

    Date getDateCreation() {
        return dateCreation
    }

    void setDateCreation(Date dateCreation) {
        this.dateCreation = dateCreation
    }

    int getTempsValide() {
        return tempsValide
    }

    void setTempsValide(int tempsValide) {
        this.tempsValide = tempsValide
    }
}
