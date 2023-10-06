package ca.jrvs.apps.trading.utilities;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;

import java.io.IOException;

public class JsonUtil {

    public static String objectToJson(Object object, boolean prettyJson, boolean includeNullValues) throws JsonProcessingException, JsonProcessingException {
        ObjectMapper m = new ObjectMapper();
        if (!includeNullValues){
            m.setSerializationInclusion(JsonInclude.Include.NON_NULL);
        }
        if (prettyJson){
            m.enable(SerializationFeature.INDENT_OUTPUT);
        }
        return m.writeValueAsString(object);
    }

    public static <T> T jsonToObject(String json, Class clazz) throws IOException, IOException {
        ObjectMapper m = new ObjectMapper();
        return (T)m.readValue(json,clazz);
    }
}
