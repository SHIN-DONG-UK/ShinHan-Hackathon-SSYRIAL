package shinhan.hackathon.ssyrial.service;

import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import shinhan.hackathon.ssyrial.model.CommonHeaderModel;
import shinhan.hackathon.ssyrial.model.demandDeposit.CreateDemandDepositAccountModel;
import shinhan.hackathon.ssyrial.model.demandDeposit.CreateDemandDepositModel;
import shinhan.hackathon.ssyrial.model.demandDeposit.InquireDemandDepositListModel;
import shinhan.hackathon.ssyrial.model.demandDeposit.InquireDemandDepositAccountHolderNameModel;
import shinhan.hackathon.ssyrial.model.demandDeposit.InquireDemandDepositAccountBalanceModel;
import shinhan.hackathon.ssyrial.model.demandDeposit.UpdateDemandDepositAccountTransferModel;
import shinhan.hackathon.ssyrial.model.demandDeposit.InquireTransactionHistoryListModel;
import shinhan.hackathon.ssyrial.model.demandDeposit.InquireTransactionHistoryModel;
import shinhan.hackathon.ssyrial.model.demandDeposit.InquireDemandDepositAccountListModel;
import shinhan.hackathon.ssyrial.model.demandDeposit.InquireDemandDepositAccountModel;

/**
 * DemandDepositService 클래스는 수시입출금 상품 관련 비즈니스 로직을 처리하는 서비스 클래스입니다.
 * 이 클래스는 정기 입출금 상품 등록, 목록 조회 및 계좌 생성과 관련된 API 요청을 처리합니다.
 */
@Service
public class DemandDepositService extends ShinhanApiService {

  /**
   * DemandDepositService 생성자.
   *
   * @param restTemplate RestTemplate 객체로, 외부 API와의 통신에 사용됩니다.
   * @param apiKey       API 호출 시 사용할 API 키.
   */
  public DemandDepositService(RestTemplate restTemplate, String apiKey) {
    super(restTemplate, apiKey);
  }

  /**
   * 정기 입출금 상품을 등록하는 메서드입니다.
   *
   * 이 메서드는 은행 코드와 상품 정보를 받아, 해당 정보를 기반으로
   * 정기 입출금 상품을 등록하는 API 요청을 보냅니다.
   *
   * @param bankCode           은행 코드
   * @param accountName        상품 이름
   * @param accountDescription 상품 설명
   * @return CreateDemandDepositModel.Response - 등록된 상품 정보가 담긴 응답
   */
  public CreateDemandDepositModel.Response createDemandDeposit(String bankCode, String accountName,
      String accountDescription) {
    // 공통 헤더 생성
    CommonHeaderModel.Request header = createCommonHeader("createDemandDeposit", "createDemandDeposit", null);

    // 요청 객체 생성
    CreateDemandDepositModel.Request request = CreateDemandDepositModel.Request.builder()
        .header(header)
        .bankCode(bankCode)
        .accountName(accountName)
        .accountDescription(accountDescription)
        .build();

    // API 요청 보내기
    return sendRequest("/edu/demandDeposit/createDemandDeposit", HttpMethod.POST, request,
        CreateDemandDepositModel.Response.class, true);
  }

  /**
   * 수시입출금 상품 목록 조회 요청을 처리하는 메서드입니다.
   *
   * 이 메서드는 정기 입출금 상품 목록을 조회하는 API 요청을 보내고,
   * 그 결과를 반환합니다.
   *
   * @return InquireDemandDepositListModel.Response - 조회된 상품 목록이 담긴 응답
   */
  public InquireDemandDepositListModel.Response inquireDemandDepositList() {
    // 공통 헤더 생성
    CommonHeaderModel.Request header = createCommonHeader("inquireDemandDepositList", "inquireDemandDepositList", null);

    // 요청 객체 생성
    InquireDemandDepositListModel.Request request = InquireDemandDepositListModel.Request.builder()
        .Header(header)
        .build();

    // API 요청 보내기
    return sendRequest("/edu/demandDeposit/inquireDemandDepositList", HttpMethod.POST, request,
        InquireDemandDepositListModel.Response.class, true);
  }

  /**
   * 수시입출금 계좌를 생성하는 메서드입니다.
   *
   * 이 메서드는 사용자 키와 상품 고유번호를 받아 계좌를 생성하는 API 요청을 보냅니다.
   *
   * @param userKey             사용자 키
   * @param accountTypeUniqueNo 상품 고유번호
   * @return CreateDemandDepositAccountModel.Response - 생성된 계좌 정보가 담긴 응답
   */
  public CreateDemandDepositAccountModel.Response createDemandDepositAccount(String userKey,
      String accountTypeUniqueNo) {
    // 공통 헤더 생성
    CommonHeaderModel.Request header = createCommonHeader("createDemandDepositAccount", "createDemandDepositAccount",
        userKey);

    // 요청 객체 생성
    CreateDemandDepositAccountModel.Request request = CreateDemandDepositAccountModel.Request.builder()
        .Header(header)
        .accountTypeUniqueNo(accountTypeUniqueNo)
        .build();

    // API 요청 보내기
    return sendRequest("/edu/demandDeposit/createDemandDepositAccount", HttpMethod.POST, request,
        CreateDemandDepositAccountModel.Response.class, true);
  }
  // ----------------------- 명석이가 만듦

  // ------------------------용현이가 만듦
  /**
   * 계좌에 대한 예금주를 조회하는 메서드입니다.
   *
   * 이 메서드는 계좌번호를 받아 예금주명을 조회하는 API 요청을 보냅니다.
   *
   * @param accountNo 계좌번호
   * @return InquireDemandDepositAccountHolderNameModel.Response - 예금주 정보가 담긴 응답
   */
  public InquireDemandDepositAccountHolderNameModel.Response inquireDemandDepositAccountHolderName(String userKey, String accountNo) {
    // 공통 헤더 생성
    CommonHeaderModel.Request header = createCommonHeader("inquireDemandDepositAccountHolderName",
        "inquireDemandDepositAccountHolderName", userKey);

    // 요청 객체 생성
    InquireDemandDepositAccountHolderNameModel.Request request = InquireDemandDepositAccountHolderNameModel.Request
        .builder()
        .Header(header)
        .accountNo(accountNo)
        .build();

    // API 요청 보내기
    return sendRequest("/edu/demandDeposit/inquireDemandDepositAccountHolderName", HttpMethod.POST, request,
        InquireDemandDepositAccountHolderNameModel.Response.class, true);
  }

  /**
   * 계좌 잔액을 조회하는 메서드입니다.
   *
   * 이 메서드는 계좌번호를 받아 계좌 잔액을 조회하는 API 요청을 보냅니다.
   *
   * @param accountNo 계좌번호
   * @return InquireDemandDepositAccountBalanceModel.Response - 계좌 잔액 정보가 담긴 응답
   */
  public InquireDemandDepositAccountBalanceModel.Response inquireDemandDepositAccountBalance(String userKey, String accountNo) {
    // 공통 헤더 생성
    CommonHeaderModel.Request header = createCommonHeader("inquireDemandDepositAccountBalance",
        "inquireDemandDepositAccountBalance", userKey);
    // 요청 객체 생성
    InquireDemandDepositAccountBalanceModel.Request request = InquireDemandDepositAccountBalanceModel.Request.builder()
        .Header(header)
        .accountNo(accountNo)
        .build();

    // API 요청 보내기
    return sendRequest("/edu/demandDeposit/inquireDemandDepositAccountBalance", HttpMethod.POST, request,
        InquireDemandDepositAccountBalanceModel.Response.class, true);
  }

  /**
   * 계좌 간 이체를 수행하는 메서드입니다.
   *
   * 이 메서드는 입금 계좌와 출금 계좌, 거래 금액 등을 받아 이체를 수행하는 API 요청을 보냅니다.
   *
   * @param depositAccountNo             입금 계좌번호
   * @param withdrawalAccountNo          출금 계좌번호
   * @param transactionBalance           거래금액
   * @param depositTransactionSummary    입금 계좌에 대한 거래 요약 내용
   * @param withdrawalTransactionSummary 출금 계좌에 대한 거래 요약 내용
   * @return UpdateDemandDepositAccountTransferModel.Response - 이체 거래 정보가 담긴 응답
   */
  public UpdateDemandDepositAccountTransferModel.Response updateDemandDepositAccountTransfer(
      String depositAccountNo, String withdrawalAccountNo, Long transactionBalance,
      String depositTransactionSummary, String withdrawalTransactionSummary) {

    // 공통 헤더 생성
    CommonHeaderModel.Request header = createCommonHeader("updateDemandDepositAccountTransfer",
        "updateDemandDepositAccountTransfer", null);

    // 요청 객체 생성
    UpdateDemandDepositAccountTransferModel.Request request = UpdateDemandDepositAccountTransferModel.Request.builder()
        .Header(header)
        .depositAccountNo(depositAccountNo)
        .withdrawalAccountNo(withdrawalAccountNo)
        .transactionBalance(transactionBalance)
        .depositTransactionSummary(depositTransactionSummary)
        .withdrawalTransactionSummary(withdrawalTransactionSummary)
        .build();

    // API 요청 보내기
    return sendRequest("/edu/demandDeposit/updateDemandDepositAccountTransfer", HttpMethod.POST, request,
        UpdateDemandDepositAccountTransferModel.Response.class, true);
  }

  /**
   * 계좌 거래 내역 목록을 조회하는 메서드입니다.
   *
   * 이 메서드는 계좌번호, 조회 시작일자, 조회 종료일자 등을 받아 거래 내역 목록을 조회하는 API 요청을 보냅니다.
   *
   * @param accountNo       계좌번호
   * @param startDate       조회 시작일자 (YYYYMMDD)
   * @param endDate         조회 종료일자 (YYYYMMDD)
   * @param transactionType 거래 구분 (M:입금, D:출금, A:전체)
   * @param orderByType     정렬 순서 (ASC:오름차순, DESC:내림차순)
   * @return InquireTransactionHistoryListModel.Response - 거래 내역 목록이 담긴 응답
   */
  public InquireTransactionHistoryListModel.Response inquireTransactionHistoryList(
      String accountNo, String startDate, String endDate, String transactionType, String orderByType) {

    // 공통 헤더 생성
    CommonHeaderModel.Request header = createCommonHeader("inquireTransactionHistoryList",
        "inquireTransactionHistoryList", null);

    // 요청 객체 생성
    InquireTransactionHistoryListModel.Request request = InquireTransactionHistoryListModel.Request.builder()
        .Header(header)
        .accountNo(accountNo)
        .startDate(startDate)
        .endDate(endDate)
        .transactionType(transactionType)
        .orderByType(orderByType)
        .build();

    // API 요청 보내기
    return sendRequest("/edu/demandDeposit/inquireTransactionHistoryList", HttpMethod.POST, request,
        InquireTransactionHistoryListModel.Response.class, true);
  }

  /**
   * 계좌 거래 내역을 단건 조회하는 메서드입니다.
   *
   * 이 메서드는 계좌번호와 거래 고유번호를 받아 거래 내역을 단건 조회하는 API 요청을 보냅니다.
   *
   * @param accountNo           계좌번호
   * @param transactionUniqueNo 거래 고유번호
   * @return InquireTransactionHistoryModel.Response - 거래 내역이 담긴 응답
   */
  public InquireTransactionHistoryModel.Response inquireTransactionHistory(String accountNo,
      Long transactionUniqueNo) {

    // 공통 헤더 생성
    CommonHeaderModel.Request header = createCommonHeader("inquireTransactionHistory", "inquireTransactionHistory",
        null);

    // 요청 객체 생성
    InquireTransactionHistoryModel.Request request = InquireTransactionHistoryModel.Request.builder()
        .Header(header)
        .accountNo(accountNo)
        .transactionUniqueNo(transactionUniqueNo)
        .build();

    // API 요청 보내기
    return sendRequest("/edu/demandDeposit/inquireTransactionHistory", HttpMethod.POST, request,
        InquireTransactionHistoryModel.Response.class, true);
  }

  /*
  InquireDemandDepositAccountListModel 계좌 목록 조회
   */
  public InquireDemandDepositAccountListModel.Response inquireDemandDepositAccountList(String userKey) {

    // 공통 헤더 생성
    CommonHeaderModel.Request header = createCommonHeader("inquireDemandDepositAccountList", "inquireDemandDepositAccountList",
        userKey);

    // 요청 객체 생성
    InquireDemandDepositAccountListModel.Request request = InquireDemandDepositAccountListModel.Request.builder()
        .Header(header)
        .build();

    // API 요청 보내기
    return sendRequest("/edu/demandDeposit/inquireDemandDepositAccountList", HttpMethod.POST, request,
    InquireDemandDepositAccountListModel.Response.class, true);
  }

  
  /*
  InquireDemandDepositAccountModel 계좌 조회 (단건)
   */
  public InquireDemandDepositAccountModel.Response inquireDemandDepositAccount(String userKey, String accountNo) {

    // 공통 헤더 생성
    CommonHeaderModel.Request header = createCommonHeader("inquireDemandDepositAccount", "inquireDemandDepositAccount",
        userKey);

    // 요청 객체 생성
    InquireDemandDepositAccountModel.Request request = InquireDemandDepositAccountModel.Request.builder()
        .Header(header)
        .accountNo(accountNo)
        .build();

    // API 요청 보내기
    return sendRequest("/edu/demandDeposit/inquireDemandDepositAccount", HttpMethod.POST, request,
    InquireDemandDepositAccountModel.Response.class, true);
  }
}
