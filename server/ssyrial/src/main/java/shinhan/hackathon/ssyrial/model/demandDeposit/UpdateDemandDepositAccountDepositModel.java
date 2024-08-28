/*
2.4.9 계좌 입금 (p.52)

설명
이용기관이 사용자의 계좌로부터 대금을 입금합니다.

Request
Header - 공통 - 타입X - 길이X - 필수Y
accountNo - 계좌번호 - String - 길이16 - 필수Y
transactionBalance - 거래금액 - String - 길이X - 필수Y - 출금할 금액 입력
transactionSummary - 입금계좌요약 - String - 길이255 - 필수N

Response
Header - 공통 - 타입X - 길이X - 필수Y
REC - 거래 정보 - List - 길이X - 필수Y
transactionUniqueNo - 거래고유번호 - String - 길이X - 필수Y
transactionDate - 거래일자 - String - 길이8 - 필수Y - YYYYMMDD
*/

package shinhan.hackathon.ssyrial.model.demandDeposit;

import lombok.Getter;
import lombok.Setter;
import shinhan.hackathon.ssyrial.model.CommonHeaderModel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;
import jakarta.validation.constraints.NotBlank;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * DepositToAccountModel 클래스는 계좌 입금 요청 및 응답 데이터를 담는 모델 클래스입니다.
 */
public class UpdateDemandDepositAccountDepositModel {

  /**
   * 계좌 입금 요청 데이터를 담는 내부 클래스입니다.
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
    
    @JsonProperty("accountNo")
    private String accountNo;

    @JsonProperty("transactionBalance")
    private String transactionBalance;

    @JsonProperty("transactionSummary")
    private String transactionSummary;
  }

  /**
   * 계좌 입금 응답 데이터를 담는 내부 클래스입니다.
   */
  @Getter
  @Setter
  @NoArgsConstructor
  @AllArgsConstructor
  public static class Response {

    @JsonProperty("Header")
    private CommonHeaderModel.Response Header;

    @JsonProperty("REC")
    private TransactionRecord REC;

    /**
     * 거래 정보 데이터를 담는 내부 클래스입니다.
     */
    @Getter
    @Setter
    @NoArgsConstructor
    @AllArgsConstructor
    public static class TransactionRecord {
      @JsonProperty("transactionUniqueNo")
      private String transactionUniqueNo;

      @JsonProperty("transactionDate")
      private String transactionDate;
    }
  }
}
