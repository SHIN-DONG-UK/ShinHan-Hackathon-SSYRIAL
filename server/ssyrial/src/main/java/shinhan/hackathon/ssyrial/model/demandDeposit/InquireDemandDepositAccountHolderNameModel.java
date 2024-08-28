/*
2.4.6 예금주 조회 (p.44)

설명
계좌에 대한 예금주명을 조회합니다.

Request
Header - 공통 - 타입X - 길이X - 필수Y
accountNo - 계좌번호 - String - 길이16 - 필수Y - 외화 계좌 가능

Response
Header - 공통 - 타입X - 길이X - 필수Y
REC - 계좌정보 - List - 길이X - 필수N
bankCode - 은행코드 - String - 길이3 - 필수Y
bankName - 은행명 - String - 길이20 - 필수Y
accountNo - 계좌번호 - String - 길이16 - 필수Y
userName - 예금주명 - String - 길이50 - 필수Y
currency - 통화코드 - String - 길이8 - 필수Y
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
 * InquireDemandDepositAccountHolderNameModel 클래스는 특정 계좌의 예금주명 조회 요청 및 응답 데이터를
 * 담는 모델 클래스입니다.
 */
public class InquireDemandDepositAccountHolderNameModel {

  /**
   * 특정 계좌의 예금주명 조회 요청 데이터를 담는 내부 클래스입니다.
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
    private String accountNo; // 필수: 계좌번호, 길이: 16
  }

  /**
   * 특정 계좌의 예금주명 조회 응답 데이터를 담는 내부 클래스입니다.
   */
  @Getter
  @Setter
  @NoArgsConstructor
  @AllArgsConstructor
  public static class Response {

    @JsonProperty("Header")
    private CommonHeaderModel.Response Header;

    @JsonProperty("REC")
    private AccountOwnerInfo REC; // 계좌 정보 리스트 (필수 아님)

    /**
     * 계좌 정보를 담는 내부 클래스입니다.
     */
    @Getter
    @Setter
    @NoArgsConstructor
    @AllArgsConstructor
    public static class AccountOwnerInfo {
      @JsonProperty("bankCode")
      private String bankCode; // 필수: 은행코드, 길이: 3

      @JsonProperty("bankName")
      private String bankName; // 필수: 은행명, 길이: 20

      @JsonProperty("accountNo")
      private String accountNo; // 필수: 계좌번호, 길이: 16

      @JsonProperty("userName")
      private String userName; // 필수: 예금주명, 길이: 50

      @JsonProperty("currency")
      private String currency; // 필수: 통화코드, 길이: 8
    }
  }
}
