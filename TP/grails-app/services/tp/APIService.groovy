package tp

import grails.gorm.transactions.Transactional

@Transactional
class APIService {

    static Date getDateFromStringSeri(String stringDate) {

        String [] firstSplit = stringDate.substring(0, stringDate.length()-1).split("T")
        String [] date =    firstSplit[0].split("-")
        String [] hours =   firstSplit[1].split(":")
        Date dateLivre = new GregorianCalendar(Integer.parseInt(date[0]), Integer.parseInt(date[1]), Integer.parseInt(date[2]), Integer.parseInt(hours[0]) + 1, Integer.parseInt(hours[1]), Integer.parseInt(hours[2])).getTime()

        return dateLivre
    }

    static boolean isInt(String s){
        return s != null && s.matches("\\d+")
    }
}
