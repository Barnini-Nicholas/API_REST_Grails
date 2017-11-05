package tp

import java.security.MessageDigest

class TokenService {

    HashMap<String, TokenAPI> listToken = new HashMap<String, TokenAPI>();


    // Méthode créant un token sha1 en utilisant le pseudo + pass et un salt qui est la date au moment de la création
    String createToken(Date dateCreation, int tempsValide, String pseudoPwd) {

        String salt = new Date().toString()
        String stringToHash = pseudoPwd + salt
        String returnSha1
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-1");
            digest.reset();
            digest.update(stringToHash.getBytes("utf8"));
            returnSha1 = String.format("%040x", new BigInteger(1, digest.digest()));
        } catch (Exception e) {
            e.printStackTrace();
        }

        listToken.put(returnSha1, new TokenAPI(dateCreation, tempsValide))
        return returnSha1;
    }

    public boolean isValid(String token){
        TokenAPI ta = (TokenAPI) listToken.get(token)
        //System.out.println("ta = " + ta)
        //System.out.println("tokenParam = " + token)
        if ( ta == null)
            return false
        return ta.isValid()
    }
}
