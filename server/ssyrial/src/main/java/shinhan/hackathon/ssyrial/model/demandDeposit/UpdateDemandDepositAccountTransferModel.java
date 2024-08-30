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
import shinhan.hackathon.ssyrial.model.CommonHeaderModel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonProperty;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import jakarta.validation.constraints.NotNull;

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

    @NotBlank(message = "입금 계좌번호는 필수 입력 항목입니다.")
    @Size(max = 16, message = "입금 계좌번호는 최대 16자리여야 합니다.")
    @JsonProperty("depositAccountNo")
    private String depositAccountNo;

    @NotBlank(message = "사용자 키는 필수 입력 항목입니다.")
    private String userKey;

    @NotNull(message = "거래 금액은 필수 입력 항목입니다.")
    @JsonProperty("transactionBalance")
    private Long transactionBalance;

    @NotBlank(message = "출금 계좌번호는 필수 입력 항목입니다.")
    @Size(max = 16, message = "출금 계좌번호는 최대 16자리여야 합니다.")
    @JsonProperty("withdrawalAccountNo")
    private String withdrawalAccountNo;

    @Size(max = 255, message = "입금 거래 요약 내용은 최대 255자리여야 합니다.")
    @JsonProperty("depositTransactionSummary")
    private String depositTransactionSummary;

    @Size(max = 255, message = "출금 거래 요약 내용은 최대 255자리여야 합니다.")
    @JsonProperty("withdrawalTransactionSummary")
    private String withdrawalTransactionSummary;
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
    private List<TransactionRecord> REC;

    /**
     * 거래 정보 데이터를 담는 내부 클래스입니다.
     */
    @Getter
    @Setter
    @NoArgsConstructor
    @AllArgsConstructor
    public static class TransactionRecord {

      @JsonProperty("transactionUniqueNo")
      private Long transactionUniqueNo;

      @NotBlank(message = "계좌번호는 필수 입력 항목입니다.")
      @Size(max = 16, message = "계좌번호는 최대 16자리여야 합니다.")
      @JsonProperty("accountNo")
      private String accountNo;

      @NotBlank(message = "거래일자는 필수 입력 항목입니다.")
      @Size(max = 8, message = "거래일자는 YYYYMMDD 형식이어야 합니다.")
      @JsonProperty("transactionDate")
      private String transactionDate;

      @NotBlank(message = "거래 유형은 필수 입력 항목입니다.")
      @Size(max = 1, message = "거래 유형은 최대 1자리여야 합니다.")
      @JsonProperty("transactionType")
      private String transactionType;

      @NotBlank(message = "거래 유형명은 필수 입력 항목입니다.")
      @Size(max = 8, message = "거래 유형명은 최대 8자리여야 합니다.")
      @JsonProperty("transactionTypeName")
      private String transactionTypeName;

      @NotBlank(message = "거래 계좌번호는 필수 입력 항목입니다.")
      @Size(max = 16, message = "거래 계좌번호는 최대 16자리여야 합니다.")
      @JsonProperty("transactionAccountNo")
      private String transactionAccountNo;
    }
  }
}