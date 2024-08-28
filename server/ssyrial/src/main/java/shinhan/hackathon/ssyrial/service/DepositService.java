/*
/deposit/createDeposit
예금 상품 등록

/deposit/inquireDepositProducts
예금 상품 조회

/deposit/inquireDepositPaymentModel
예금 납입 상세 조회
 */

package shinhan.hackathon.ssyrial.service;

import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import shinhan.hackathon.ssyrial.model.CommonHeaderModel;
import shinhan.hackathon.ssyrial.model.deposit.*;

/**
 * DepositService 클래스는 예금 상품 관련 비즈니스 로직을 처리하는 서비스 클래스입니다.
 * 이 클래스는 예금 상품 등록, 목록 조회 및 납입 상세 조회와 관련된 API 요청을 처리합니다.
 */
@Service
public class DepositService extends ShinhanApiService {

  /**
   * DepositService 생성자.
   *
   * @param restTemplate RestTemplate 객체로, 외부 API와의 통신에 사용됩니다.
   * @param apiKey       API 호출 시 사용할 API 키.
   */
  public DepositService(RestTemplate restTemplate, String apiKey) {
    super(restTemplate, apiKey);
  }

  /**
   * 예금 상품을 등록하는 메서드입니다.
   *
   * 이 메서드는 은행 코드와 상품 정보를 받아, 해당 정보를 기반으로
   * 예금 상품을 등록하는 API 요청을 보냅니다.
   *
   * @param bankCode           은행 코드
   * @param accountName        상품 이름
   * @param accountDescription 상품 설명
   * @return CreateDepositModel.Response - 등록된 상품 정보가 담긴 응답
   */
  public CreateDepositModel.Response createDeposit(String bankCode, String accountName, String accountDescription) {
    // 공통 헤더 생성
    CommonHeaderModel.Request header = createCommonHeader("createDeposit", "createDeposit", null);

    // 요청 객체 생성
    CreateDepositModel.Request request = CreateDepositModel.Request.builder()
        .header(header)
        .bankCode(bankCode)
        .accountName(accountName)
        .accountDescription(accountDescription)
        .build();

    // API 요청 보내기
    return sendRequest("/edu/deposit/createDeposit", HttpMethod.POST, request, CreateDepositModel.Response.class, true);
  }

  /**
   * 예금 상품 목록을 조회하는 메서드입니다.
   *
   * 이 메서드는 예금 상품 목록을 조회하는 API 요청을 보내고,
   * 그 결과를 반환합니다.
   *
   * @return InquireDepositProductsModel.Response - 조회된 상품 목록이 담긴 응답
   */
  public InquireDepositProductsModel.Response inquireDepositProducts() {
    // 공통 헤더 생성
    CommonHeaderModel.Request header = createCommonHeader("inquireDepositProducts", "inquireDepositProducts", null);

    // 요청 객체 생성
    InquireDepositProductsModel.Request request = InquireDepositProductsModel.Request.builder()
        .Header(header)
        .build();

    // API 요청 보내기
    return sendRequest("/edu/deposit/inquireDepositProducts", HttpMethod.POST, request,
        InquireDepositProductsModel.Response.class, true);
  }

  /**
   * 예금 납입 상세를 조회하는 메서드입니다.
   *
   * 이 메서드는 납입 고유번호를 받아 납입 상세를 조회하는 API 요청을 보냅니다.
   *
   * @param accountNo 납입 고유번호
   * @return InquireDepositPaymentModel.Response - 납입 상세 정보가 담긴 응답
   */
  public InquireDepositPaymentModel.Response inquireDepositPaymentModel(String accountNo) {
    // 공통 헤더 생성
    CommonHeaderModel.Request header = createCommonHeader("inquireDepositPaymentModel", "inquireDepositPaymentModel",
        null);

    // 요청 객체 생성
    InquireDepositPaymentModel.Request request = InquireDepositPaymentModel.Request.builder()
        .Header(header)
        .accountNo(accountNo)
        .build();

    // API 요청 보내기
    return sendRequest("/edu/deposit/inquireDepositPaymentModel", HttpMethod.POST, request,
        InquireDepositPaymentModel.Response.class, true);
  }
}
