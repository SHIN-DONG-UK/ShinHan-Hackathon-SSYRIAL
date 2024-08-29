/*
2.4.10 계좌 이체 (p.55)

설명
한 계좌로부터 다른 계좌로 대금을 이체합니다.

Request
Header - 공통 - 타입X - 길이X - 필수Y
depositAccountNo - 입금계좌번호 - String - 길이16 - 필수Y - 원화, 외화 계좌 가능
transactionBalance - 거래금액 - Long - 길이X - 필수Y - 출금할 금액 입력
withdrawalAccountNo - 출금계좌번호 - String - 길이16 - 필수Y - 원화 계좌만 가능
depositTransactionSummary - 거래 요약내용(입금계좌) - String - 길이255 - 필수N
withdrawalTransactionSummary - 거래 요약내용(출금계좌) - String - 길이255 - 필수N

Response
Header - 공통 - 타입X - 길이X - 필수Y
REC - 거래목록 - 길이X - 필수Y
transactionUniqueNo - 거래고유번호 - Long - 길이X - 필수Y
accountNo - 계좌번호 - String - 길이16 - 필수Y
transactionDate - 거래일자 - String - 길이8 - 필수Y - YYYYMMDD
transactionType - 거래유형 - String - 길이1 - 필수Y - 1, 2 ...
transactionTypeName - 거래유형명 - String - 길이8 - 필수Y - 입금이체, 출금이체 ...
transactionAccountNo - 거래 계좌번호 - String - 길이16 - 필수Y - 이체 거래에 대한 계좌번호
*/

package shinhan.hackathon.ssyrial.model.demandDeposit;

import lombok.Getter;
import lombok.Setter;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;

import com.fasterxml.jackson.annotation.JsonProperty;

import jakarta.validation.constraints.NotBlank;

import shinhan.hackathon.ssyrial.model.CommonHeaderModel;

/**
 * UpdateDemandDepositAccountTransferModel 클래스는 계좌 이체 요청 및 응답 데이터를 담는 모델 클래스입니다.
 */
public class UpdateDemandDepositAccountTransferModel {

  /**
   * 계좌 이체 요청 데이터를 담는 내부 클래스입니다.
   */
  @Getter
  @Setter
  @NoArgsConstructor
  @AllArgsConstructor
  @Builder
  public static class Request {
    @JsonProperty("Header")
    private CommonHeaderModel.Request Header;

    @NotBlank(message = "사용자 키는 필수 입력 항목입니다.")
    private String userKey;

    @JsonProperty("depositAccountNo")
    private String depositAccountNo; // 필수: 입금계좌번호, 길이: 16

    @JsonProperty("transactionBalance")
    private String transactionBalance; // 필수: 거래금액

    @JsonProperty("withdrawalAccountNo")
    private String withdrawalAccountNo; // 필수: 출금계좌번호, 길이: 16

    @JsonProperty("depositTransactionSummary")
    private String depositTransactionSummary; // 선택: 거래 요약내용(입금계좌), 길이: 255

    @JsonProperty("withdrawalTransactionSummary")
    private String withdrawalTransactionSummary; // 선택: 거래 요약내용(출금계좌), 길이: 255
  }

  /**
   * 계좌 이체 응답 데이터를 담는 내부 클래스입니다.
   */
  @Getter
  @Setter
  @NoArgsConstructor
  @AllArgsConstructor
  public static class Response {

    @JsonProperty("Header")
    private CommonHeaderModel.Response Header;

    @JsonProperty("REC")
    private TransactionInfo REC; // 거래목록

    /**
     * 거래 정보를 담는 내부 클래스입니다.
     */
    @Getter
    @Setter
    @NoArgsConstructor
    @AllArgsConstructor
    public static class TransactionInfo {
      @JsonProperty("transactionUniqueNo")
      private Long transactionUniqueNo; // 필수: 거래고유번호

      @JsonProperty("accountNo")
      private String accountNo; // 필수: 계좌번호, 길이: 16

      @JsonProperty("transactionDate")
      private String transactionDate; // 필수: 거래일자, 길이: 8, YYYYMMDD

      @JsonProperty("transactionType")
      private String transactionType; // 필수: 거래유형, 길이: 1

      @JsonProperty("transactionTypeName")
      private String transactionTypeName; // 필수: 거래유형명, 길이: 8

      @JsonProperty("transactionAccountNo")
      private String transactionAccountNo; // 필수: 거래 계좌번호, 길이: 16
    }
  }
}
