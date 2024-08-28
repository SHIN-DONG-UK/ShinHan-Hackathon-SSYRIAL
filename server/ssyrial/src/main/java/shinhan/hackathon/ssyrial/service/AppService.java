package shinhan.hackathon.ssyrial.service;

import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import shinhan.hackathon.ssyrial.model.api.IssuedApiKeyModel;
import shinhan.hackathon.ssyrial.model.api.ReIssuedApiKeyModel;

/**
 * AppService 클래스는 API 키 발급 및 재발급과 관련된 비즈니스 로직을 처리하는 서비스 클래스입니다.
 */
@Service
public class AppService extends ShinhanApiService {

  /**
   * AppService 생성자.
   * 
   * @param restTemplate 외부 API와의 통신을 위한 RestTemplate 객체
   */
  public AppService(RestTemplate restTemplate) {
    super(restTemplate, null); // apiKey가 필요 없으므로 null로 설정
  }

  /**
   * API 키 발급 요청을 처리하는 메서드입니다.
   * 
   * 클라이언트로부터 API 키 발급 요청 데이터를 받아서 처리하고,
   * 발급된 API 키 정보를 반환합니다.
   * 
   * @param request IssuedApiKeyModel.Request - API 키 발급 요청 데이터
   * @return IssuedApiKeyModel.Response - 발급된 API 키 정보 응답
   */
  public IssuedApiKeyModel.Response getIssuedApiKey(IssuedApiKeyModel.Request request) {
    return sendRequest("/edu/app/issuedApiKey", HttpMethod.POST, request, IssuedApiKeyModel.Response.class, false);
  }

  /**
   * API 키 재발급 요청을 처리하는 메서드입니다.
   * 
   * @param request ReIssuedApiKeyModel.Request - API 키 재발급 요청 데이터
   * @return ReIssuedApiKeyModel.Response - 재발급된 API 키 정보 응답
   */
  public ReIssuedApiKeyModel.Response getReIssuedApiKey(ReIssuedApiKeyModel.Request request) {
    return sendRequest("/edu/app/reIssuedApiKey", HttpMethod.POST, request, ReIssuedApiKeyModel.Response.class, false);
  }
}
