/*
 2.3.14. 계좌 해지

 설명
 계좌를 해지합니다.
 예.적금, 대출의 연결계좌인 경우 해지가 불가능합니다.
 잔액이 0원이 계좌는 금액 반환 계좌번호를 작성하지 않아도 정상 해지됩니다.

 Request
 Header - 공통 - 타입X - 길이X - 필수Y
 accountNo - 계좌번호 - String - 길이16 - 필수Y
 refundAccountNo - 금액반환계좌번호 - String - 길이16 - 필수N - 해지 계좌번호의 잔액이 0일 시 미입력 가능

 Response
 Header - 공통 - 타입X - 길이X - 필수Y
 REC - 해지 계좌정보 - List - 길이X - 필수Y
 status - 상태 - String - 길이20 - 필수Y
 accountNo - 해지 계좌번호 - String - 길이20 - 필수Y
 refundAccountNo - 금액반환계좌번호 - String - 길이16 - 필수Y
 accountBalance - 계좌해지 잔액 - Long - 길이X - 필수Y
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
 * DeleteDemandDepositAccountModel 클래스는 계좌 해지 요청 및 응답 데이터를 담는 모델 클래스입니다.
 */
public class DeleteDemandDepositAccountModel {

  /**
   * 계좌 해지 요청 데이터를 담는 내부 클래스입니다.
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

    @JsonProperty("refundAccountNo")
    private String refundAccountNo;
  }

  /**
   * 계좌 해지 응답 데이터를 담는 내부 클래스입니다.
   */
  @Getter
  @Setter
  @NoArgsConstructor
  @AllArgsConstructor
  public static class Response {

    @JsonProperty("Header")
    private CommonHeaderModel.Response Header;

    @JsonProperty("REC")
    private TerminateAccountInfo REC;

    /**
     * 해지 계좌 정보를 담는 내부 클래스입니다.
     */
    @Getter
    @Setter
    @NoArgsConstructor
    @AllArgsConstructor
    public static class TerminateAccountInfo {
      @JsonProperty("status")
      private String status;

      @JsonProperty("accountNo")
      private String accountNo;

      @JsonProperty("refundAccountNo")
      private String refundAccountNo;

      @JsonProperty("accountBalance")
      private Long accountBalance;
    }
  }
}
