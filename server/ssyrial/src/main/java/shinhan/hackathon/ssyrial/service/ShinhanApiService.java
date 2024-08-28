package shinhan.hackathon.ssyrial.service;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import java.util.Map;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import shinhan.hackathon.ssyrial.common.codes.ErrorCode;
import shinhan.hackathon.ssyrial.config.exception.BusinessExceptionHandler;
import shinhan.hackathon.ssyrial.model.CommonHeaderModel;

@Service
public abstract class ShinhanApiService {

  private static final Logger logger = LoggerFactory.getLogger(ShinhanApiService.class);

  protected final RestTemplate restTemplate;
  protected static final String BASE_URL = "https://finopenapi.ssafy.io/ssafy/api/v1";
  protected final String apiKey;

  public ShinhanApiService(RestTemplate restTemplate, String apiKey) {
    this.restTemplate = restTemplate;
    this.apiKey = apiKey;
  }

  protected CommonHeaderModel.Request createCommonHeader(String apiName, String apiServiceCode, String userKey) {
    return CommonHeaderModel.Request.builder()
        .apiName(apiName)
        .apiServiceCode(apiServiceCode)
        .apiKey(apiKey)
        .userKey(userKey)
        .build();
  }

  protected <T> T sendRequest(String endpoint, HttpMethod method, Object requestBody, Class<T> responseType,
      boolean useApiKey) {
    HttpHeaders headers = new HttpHeaders();
    headers.set("Content-Type", "application/json");

    if (useApiKey && apiKey != null) {
      requestBody = addApiKeyToRequestBody(requestBody, apiKey);
    }

    HttpEntity<Object> entity = new HttpEntity<>(requestBody, headers);

    try {
      ResponseEntity<String> responseEntity = restTemplate.exchange(
          BASE_URL + endpoint,
          method,
          entity,
          String.class);

      String responseBody = responseEntity.getBody();
      logger.info("Received response from Shinhan API: {}", responseBody);

      ObjectMapper objectMapper = new ObjectMapper();
      return objectMapper.readValue(responseBody, responseType);

    } catch (HttpClientErrorException e) {
      throw new BusinessExceptionHandler(e.getResponseBodyAsString(), ErrorCode.BUSINESS_EXCEPTION_ERROR);
    } catch (Exception e) {
      throw new BusinessExceptionHandler(e.getMessage(), ErrorCode.BUSINESS_EXCEPTION_ERROR);
    }
  }

  private Object addApiKeyToRequestBody(Object requestBody, String apiKey) {
    try {
      ObjectMapper objectMapper = new ObjectMapper();
      Map<String, Object> bodyMap = objectMapper.convertValue(requestBody, new TypeReference<Map<String, Object>>() {
      });
      bodyMap.put("apiKey", apiKey);
      return bodyMap;
    } catch (Exception e) {
      throw new BusinessExceptionHandler(e.getMessage(), ErrorCode.BUSINESS_EXCEPTION_ERROR);
    }
  }
}
