package com.calclogic.externalservices;

import java.io.UnsupportedEncodingException;
import java.util.logging.Level;
import java.util.logging.Logger;

// The following libraries are used to send a post request to an external server
import org.json.simple.JSONObject;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.springframework.beans.factory.annotation.Autowired;

/**
 *
 * @author ronald
 */
public class MicroServices {
    
    // URL in which there is the server that transforms a string into HTML format
    private static /*final*/ String URL_LATEX_TO_HTML; //= "http://localhost:83/example";
    //private static final String URL_LATEX_TO_HTML = "http://nodejs:83/example";

    public static void setURL_LATEX_TO_HTML(String url_latex_to_html) {
        URL_LATEX_TO_HTML = url_latex_to_html;
    } 
    
    /**
     * Transforms a string into another string
     *
     * Source: https://mkyong.com/java/apache-httpclient-examples/
     * (That source missed to add the corresponding setContentType in one of its examples)
     *
     * @param stringToEdit Is the string that will be transformed
     * @param serverURL The direction in which the corresponding server is located
     * @param propertyName Is the name of the JSON's property in which the content will be sent
     * @return The transformed string, or the same original one if there was an exception
     */
    private static String StringToStringThroughJson(String stringToEdit, String serverURL, String propertyName){
        JSONObject json = new JSONObject();
        json.put(propertyName, stringToEdit);
        HttpPost post = new HttpPost(serverURL);

        try {
            StringEntity entity = new StringEntity(json.toString());
            entity.setContentType("application/json; charset=UTF-8");
            post.setEntity(entity);
        }
        catch(UnsupportedEncodingException e){
            Logger.getLogger(MicroServices.class.getName()).log(Level.SEVERE, null, e);
        }

        try (CloseableHttpClient httpClient = HttpClients.createDefault();
             CloseableHttpResponse response = httpClient.execute(post)) {

            stringToEdit = EntityUtils.toString(response.getEntity());
        }
        catch(Exception e){
            Logger.getLogger(MicroServices.class.getName()).log(Level.SEVERE, null, e);
        }
        return stringToEdit;
    }

    /**
     * Calls an external server so it transforms the LaTeX code inside a string to HTML.
     * @param latexFormula Is the string that has the LaTeX code
     * @return The transformed string with the HTML inside
     */
    public static String transformLaTexToHTML(String latexFormula){
    	return StringToStringThroughJson(latexFormula, URL_LATEX_TO_HTML, "formula");
    }
}