/*
2.5.6 예금 납입 상세 조회 (p.89)

설명
가입한 예금 계좌의 납입 내역을 상세 조회합니다.

Request
Header - 공통 - 타입X - 길이X - 필수Y
accountNo - 계좌번호 - String - 길이16 - 필수Y

Response
Header - 공통 - 타입X - 길이X - 필수Y
REC - 예금납입내역 - 타입X - 길이X - 필수Y
paymentUniqueNo - 납입 고유번호 - String - 길이X - 필수Y
paymentDate - 납입일자 - String - 길이8 - 필수Y
paymentTime - 납입시각 - String - 길이6 - 필수Y
paymentBalance - 납입금액 - Long - 길이X - 필수Y
*/

package shinhan.hackathon.ssyrial.model.deposit;

import lombok.Getter;
import lombok.Setter;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;

import com.fasterxml.jackson.annotation.JsonProperty;

import shinhan.hackathon.ssyrial.model.CommonHeaderModel;

/**
 * InquireDepositPaymentModel 클래스는 예금 납입 내역 상세 조회 요청 및 응답 데이터를 담는 모델 클래스입니다.
 */
public class InquireDepositPaymentModel {

  /**
   * 예금 납입 내역 상세 조회 요청 데이터를 담는 내부 클래스입니다.
   */
  @Getter
  @Setter
  @NoArgsConstructor
  @AllArgsConstructor
  @Builder
  public static class Request {
    @JsonProperty("Header")
    private CommonHeaderModel.Request Header;

    @JsonProperty("accountNo")
    private String accountNo; // 필수: 계좌번호, 길이: 16
  }

  /**
   * 예금 납입 내역 상세 조회 응답 데이터를 담는 내부 클래스입니다.
   */
  @Getter
  @Setter
  @NoArgsConstructor
  @AllArgsConstructor
  public static class Response {

    @JsonProperty("Header")
    private CommonHeaderModel.Response Header;

    @JsonProperty("REC")
    private DepositPaymentDetail REC; // 예금 납입 내역

    /**
     * 예금 납입 내역 데이터를 담는 내부 클래스입니다.
     */
    @Getter
    @Setter
    @NoArgsConstructor
    @AllArgsConstructor
    public static class DepositPaymentDetail {
      @JsonProperty("paymentUniqueNo")
      private String paymentUniqueNo; // 필수: 납입 고유번호

      @JsonProperty("paymentDate")
      private String paymentDate; // 필수: 납입일자, 길이: 8

      @JsonProperty("paymentTime")
      private String paymentTime; // 필수: 납입시각, 길이: 6

      @JsonProperty("paymentBalance")
      private Long paymentBalance; // 필수: 납입금액
    }
  }
}
