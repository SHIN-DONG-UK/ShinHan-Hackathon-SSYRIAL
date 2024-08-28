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

import shinhan.hackathon.ssyrial.model.CommonHeaderModel;

/**
 * ShinhanApiService 클래스는 외부 API와의 통신을 처리하는 추상화된 서비스 클래스입니다.
 * RestTemplate을 사용하여 API 요청을 보냅니다.
 */
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

  /**
   * 공통 헤더를 생성하는 메서드입니다.
   * 
   * @param apiName        API 이름
   * @param apiServiceCode API 서비스 코드
   * @param userKey        사용자 키 (선택 사항)
   * @return 공통 헤더 모델
   */
  protected CommonHeaderModel.Request createCommonHeader(String apiName, String apiServiceCode, String userKey) {
    return CommonHeaderModel.Request.builder()
        .apiName(apiName)
        .apiServiceCode(apiServiceCode)
        .apiKey(apiKey)
        .userKey(userKey)
        .build();
  }

  /**
   * 외부 API에 요청을 보내고 응답을 받는 메서드입니다.
   * 
   * @param <T>          응답 데이터의 타입
   * @param endpoint     호출할 API 엔드포인트
   * @param method       HTTP 메서드 (GET, POST 등)
   * @param requestBody  요청 데이터
   * @param responseType 응답 데이터의 클래스 타입
   * @param useApiKey    API 키 사용 여부
   * @return T - 응답 데이터
   */
  protected <T> T sendRequest(String endpoint, HttpMethod method, Object requestBody, Class<T> responseType,
      boolean useApiKey) {
    HttpHeaders headers = new HttpHeaders();
    headers.set("Content-Type", "application/json");

    // 요청 본문에 API 키를 추가해야 하는 경우 처리
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

      // Convert the response body to the desired response type
      ObjectMapper objectMapper = new ObjectMapper();
      return objectMapper.readValue(responseBody, responseType);

    } catch (HttpClientErrorException e) {
      logger.error("Error calling Shinhan API: {}", e.getResponseBodyAsString());
      throw e;
    } catch (Exception e) {
      logger.error("Unexpected error occurred: {}", e.getMessage(), e);
      throw new RuntimeException("Error processing Shinhan API response", e);
    }
  }

  /**
   * 요청 본문에 API 키를 추가하는 메서드입니다.
   * 
   * @param requestBody 기존 요청 데이터
   * @param apiKey      추가할 API 키
   * @return 수정된 요청 데이터
   */
  private Object addApiKeyToRequestBody(Object requestBody, String apiKey) {
    try {
      // 요청 본문을 Map으로 변환 후 API 키 추가
      ObjectMapper objectMapper = new ObjectMapper();

      // TypeReference를 사용하여 타입 안전성 확보
      Map<String, Object> bodyMap = objectMapper.convertValue(requestBody, new TypeReference<Map<String, Object>>() {
      });

      bodyMap.put("apiKey", apiKey);
      return bodyMap;
    } catch (Exception e) {
      logger.error("Failed to add apiKey to request body: {}", e.getMessage());
      throw new RuntimeException("Failed to add apiKey to request body", e);
    }
  }
}
