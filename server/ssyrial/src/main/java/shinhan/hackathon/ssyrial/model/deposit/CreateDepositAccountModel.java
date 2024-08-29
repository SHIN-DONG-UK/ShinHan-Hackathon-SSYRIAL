/*
2.5.3 예금 계좌 생성 (p.79)

설명
예금 계좌를 생성합니다.
사용자는 상품 고유번호를 통해 예금 계좌를 생성할 수 있습니다.

Request
Header - 공통 - 타입X - 길이X - 필수Y - userKey 제외
withdrawalAccountNo - 출금계좌번호 - String - 길이20 - 필수Y - 출금할 수시입출금 계좌번호 가입
accountTypeUniqueNo - 상품고유번호 - String - 길이20 - 필수Y - 가입할 예금 상품고유번호 기입
depositBalance - 가입금액 - String - 길이X - 필수Y - 가입할 예금의 가입 가능금액 범위 내 기입

Response
Header - 공통 - 타입X - 길이X - 필수Y
REC - 예금계좌정보 - 타입X - 길이X - 필수Y
bankCode - 은행코드 - String - 길이3 - 필수Y
bankName - 은행명 - String - 길이20 - 필수Y
accountNo - 계좌번호 - String - 길이16 - 필수Y
accountName - 상품명 - String - 길이20 - 필수Y
withdrawalBankCode - 출금은행코드 - String - 길이3 - 필수Y
withdrawalAccountNo - 출금은행계좌 - String - 길이16 - 필수Y
subscriptionPeriod - 가입기간 - String - 길이20 - 필수Y
depositBalance - 가입금액 - String - 길이X - 필수Y
interestRate - 가입적용금리 - double - 길이X - 필수Y
accountCreateDate - 계좌 개설일 - String - 길이8 - 필수Y
accountExpiryDate - 계좌 만기일 - String - 길이8 - 필수Y
*/

package shinhan.hackathon.ssyrial.model.deposit;

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
 * CreateDepositAccountModel 클래스는 예금 계좌 생성 요청 및 응답 데이터를 담는 모델 클래스입니다.
 */
public class CreateDepositAccountModel {

  /**
   * 예금 계좌 생성 요청 데이터를 담는 내부 클래스입니다.
   */
  @Getter
  @Setter
  @NoArgsConstructor
  @AllArgsConstructor
  @Builder
  public static class Request {
    @JsonProperty("Header")
    private CommonHeaderModel.Request Header;

    @JsonProperty("withdrawalAccountNo")
    private String withdrawalAccountNo;

    @JsonProperty("accountTypeUniqueNo")
    private String accountTypeUniqueNo;

    @JsonProperty("depositBalance")
    private String depositBalance;
  }

  /**
   * 예금 계좌 생성 응답 데이터를 담는 내부 클래스입니다.
   */
  @Getter
  @Setter
  @NoArgsConstructor
  @AllArgsConstructor
  public static class Response {

    @JsonProperty("Header")
    private CommonHeaderModel.Response Header;

    @JsonProperty("REC")
    private DepositAccountInfo REC;

    /**
     * 예금 계좌 정보를 담는 내부 클래스입니다.
     */
    @Getter
    @Setter
    @NoArgsConstructor
    @AllArgsConstructor
    public static class DepositAccountInfo {
      @JsonProperty("bankCode")
      private String bankCode;

      @JsonProperty("bankName")
      private String bankName;

      @JsonProperty("accountNo")
      private String accountNo;

      @JsonProperty("accountName")
      private String accountName;

      @JsonProperty("withdrawalBankCode")
      private String withdrawalBankCode;

      @JsonProperty("withdrawalAccountNo")
      private String withdrawalAccountNo;

      @JsonProperty("subscriptionPeriod")
      private String subscriptionPeriod;

      @JsonProperty("depositBalance")
      private String depositBalance;

      @JsonProperty("interestRate")
      private double interestRate;

      @JsonProperty("accountCreateDate")
      private String accountCreateDate;

      @JsonProperty("accountExpiryDate")
      private String accountExpiryDate;
    }
  }
}
