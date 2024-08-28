package shinhan.hackathon.ssyrial.service;

import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import shinhan.hackathon.ssyrial.model.CommonHeaderModel;
import shinhan.hackathon.ssyrial.model.bank.InquireBankCodes;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * BankService 클래스는 은행 코드 조회와 관련된 비즈니스 로직을 처리하는 서비스 클래스입니다.
 */
@Service
public class BankService extends ShinhanApiService {

  private static final Logger logger = LoggerFactory.getLogger(BankService.class);
  private final ObjectMapper objectMapper = new ObjectMapper();

  /**
   * BankService 생성자.
   * 
   * @param restTemplate 외부 API와의 통신을 위한 RestTemplate 객체
   * @param apiKey       API 호출에 필요한 API 키
   */
  public BankService(RestTemplate restTemplate, String apiKey) {
    super(restTemplate, apiKey);
  }

  /**
   * 은행 코드 조회 API 요청을 처리하는 메서드입니다.
   * 
   * 클라이언트로부터 별도의 요청 본문 없이 은행 코드 조회 요청을 처리하고,
   * 조회된 은행 코드 정보를 반환합니다.
   * 
   * @return InquireBankCodes.Response - 조회된 은행 코드 정보 응답
   */
  public InquireBankCodes.Response inquireBankCodes() {
    // 공통 헤더 생성, userKey는 필요하지 않음
    CommonHeaderModel.Request header = createCommonHeader("inquireBankCodes", "inquireBankCodes", null);
    try {
      // JSON 형식으로 로깅
      String headerJson = objectMapper.writeValueAsString(header);
      logger.info("Generated Common Header: {}", headerJson);
    } catch (JsonProcessingException e) {
      logger.error("Failed to log Common Header", e);
    }
    // 은행 코드 조회 요청 데이터 생성
    InquireBankCodes.Request request = InquireBankCodes.Request.builder()
        .Header(header)
        .build();

    // API 호출 및 응답 반환
    return sendRequest("/edu/bank/inquireBankCodes", HttpMethod.POST, request, InquireBankCodes.Response.class, true);
  }
}
