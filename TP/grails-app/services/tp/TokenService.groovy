package tp

class TokenService {

    HashMap<String, TokenAPI> listToken = new HashMap<String, TokenAPI>();

    public String createToken(Date dateCreation, int tempsValide) {
        String tokenKey = listToken.size()+"";
        listToken.put(tokenKey, new TokenAPI(dateCreation, tempsValide))
        return tokenKey;
    }

    public boolean isValid(String token){
        TokenAPI ta = (TokenAPI) listToken.get(token)
        System.out.println("ta = " + ta)
        System.out.println("tokenParam = " + token)
        if ( ta == null)
            return false
        return ta.isValid()
    }
}
