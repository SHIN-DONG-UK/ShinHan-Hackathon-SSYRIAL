/*
2.5.2 예금 상품 조회 (p.75)

설명
예금 상품 목록을 조회합니다.

Request
Header - 공통 - 타입X - 길이X - 필수Y - userKey 제외

Response
Header - 공통 - 타입X - 길이X - 필수Y
REC - 예금상품목록 - List - 길이X - 필수N
accountTypeUniqueNo - 상품 고유번호 - String - 길이20 - 필수Y
bankCode - 은행코드 - String - 길이3 - 필수Y
bankName - 은행명 - String - 길이20 - 필수Y
accountTypeCode - 상품구분코드 - String - 길이3 - 필수Y - 1:수시입출금, 2:정기예금, 3:정기적금, 4:대출
accountTypeName - 상품구분명 - String - 길이20 - 필수Y
accountName - 상품명 - String - 길이20 - 필수Y
accountDescription - 상품설명 - String - 길이255 - 필수N
subscriptionPeriod - 가입기간 - String - 길이20 - 필수Y
minSubscriptionBalance - 최소 가입 가능금액 - Long - 길이X - 필수Y
maxSubscriptionBalance - 최대 가입 가능금액 - Long - 길이X - 필수Y
interestRate - 이자율 - double - 길이X - 필수Y
rateDescription - 이자율 설명 - String - 길이255 - 필수N
*/

package shinhan.hackathon.ssyrial.model.deposit;

import lombok.Getter;
import lombok.Setter;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;
import jakarta.validation.constraints.NotBlank;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.List;

import shinhan.hackathon.ssyrial.model.CommonHeaderModel;

/**
 * InquireDepositProductsModel 클래스는 예금 상품 목록 조회 요청 및 응답 데이터를 담는 모델 클래스입니다.
 */
public class InquireDepositProductsModel {

  /**
   * 예금 상품 목록 조회 요청 데이터를 담는 내부 클래스입니다.
   */
  @Getter
  @Setter
  @NoArgsConstructor
  @AllArgsConstructor
  @Builder
  public static class Request {
    @JsonProperty("Header")
    private CommonHeaderModel.Request Header;
  }

  /**
   * 예금 상품 목록 조회 응답 데이터를 담는 내부 클래스입니다.
   */
  @Getter
  @Setter
  @NoArgsConstructor
  @AllArgsConstructor
  public static class Response {

    @JsonProperty("Header")
    private CommonHeaderModel.Response Header;

    @JsonProperty("REC")
    private List<DepositProduct> REC; // 예금 상품 목록

    /**
     * 예금 상품 데이터를 담는 내부 클래스입니다.
     */
    @Getter
    @Setter
    @NoArgsConstructor
    @AllArgsConstructor
    public static class DepositProduct {
      @JsonProperty("accountTypeUniqueNo")
      private String accountTypeUniqueNo; // 필수: 상품 고유번호, 길이: 20

      @JsonProperty("bankCode")
      private String bankCode; // 필수: 은행코드, 길이: 3

      @JsonProperty("bankName")
      private String bankName; // 필수: 은행명, 길이: 20

      @JsonProperty("accountTypeCode")
      private String accountTypeCode; // 필수: 상품구분코드, 길이: 3

      @JsonProperty("accountTypeName")
      private String accountTypeName; // 필수: 상품구분명, 길이: 20

      @JsonProperty("accountName")
      private String accountName; // 필수: 상품명, 길이: 20

      @JsonProperty("accountDescription")
      private String accountDescription; // 선택: 상품설명, 길이: 255

      @JsonProperty("subscriptionPeriod")
      private String subscriptionPeriod; // 필수: 가입기간, 길이: 20

      @JsonProperty("minSubscriptionBalance")
      private Long minSubscriptionBalance; // 필수: 최소 가입 가능금액

      @JsonProperty("maxSubscriptionBalance")
      private Long maxSubscriptionBalance; // 필수: 최대 가입 가능금액

      @JsonProperty("interestRate")
      private Double interestRate; // 필수: 이자율

      @JsonProperty("rateDescription")
      private String rateDescription; // 선택: 이자율 설명, 길이: 255
    }
  }
}
