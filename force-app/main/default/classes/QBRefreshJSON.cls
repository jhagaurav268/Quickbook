public class QBRefreshJSON {
	public Integer x_refresh_token_expires_in;
    public String refresh_token;
    public String access_token;
    public String expires_in;
    public String token_type;
    
    public static QBRefreshJSON parse(String json){
        return (QBRefreshJSON) System.JSON.deserialize(json, QBRefreshJSON.class);
    }
}