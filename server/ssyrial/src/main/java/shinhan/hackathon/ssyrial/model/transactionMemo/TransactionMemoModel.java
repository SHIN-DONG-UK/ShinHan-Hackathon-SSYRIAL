/*
2.12.1 거래내역 메모 (p.223)

설명
원화, 외화 수시입출금의 거래내역에 대한 메모를 작성하고 수정합니다.

Request
Header - 공통 - 타입X - 길이X - 필수Y - userKey 제외
accountNo - 계좌번호 - String - 길이16 - 필수Y
transactionUniqueNo - 거래고유번호 - Long - 길이X - 필수Y
transactionMemo - 메모 - String - 길이255 - 필수N

Response
Header - 공통 - 타입X - 길이X - 필수Y
REC - 설명X - List - 길이 - 필수Y
memoUniqueNo - 메모 고유번호 - Long - 길이X
accountNo - 계좌번호 - String - 길이16 - 필수Y
transactionUniqueNo - 거래 고유번호 - Long - 길이X - 필수Y
transactionMemo - 메모 - String - 길이255 - 필수N
created - 생성일 - String - 길이10 - 필수Y
*/

package shinhan.hackathon.ssyrial.model.transactionMemo;

import lombok.Getter;
import lombok.Setter;
import shinhan.hackathon.ssyrial.model.CommonHeaderModel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;

import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * TransactionMemoModel 클래스는 거래내역 메모 작성 및 수정 요청 및 응답 데이터를 담는 모델 클래스입니다.
 */
public class TransactionMemoModel {

  /**
   * 거래내역 메모 작성 및 수정 요청 데이터를 담는 내부 클래스입니다.
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

    @JsonProperty("transactionUniqueNo")
    private Long transactionUniqueNo; // 필수: 거래고유번호

    @JsonProperty("transactionMemo")
    private String transactionMemo; // 선택: 메모, 길이: 255
  }

  /**
   * 거래내역 메모 작성 및 수정 응답 데이터를 담는 내부 클래스입니다.
   */
  @Getter
  @Setter
  @NoArgsConstructor
  @AllArgsConstructor
  public static class Response {

    @JsonProperty("Header")
    private CommonHeaderModel.Response Header;

    @JsonProperty("REC")
    private MemoDetails REC; // 메모 상세 정보

    /**
     * 메모 상세 정보를 담는 내부 클래스입니다.
     */
    @Getter
    @Setter
    @NoArgsConstructor
    @AllArgsConstructor
    public static class MemoDetails {
      @JsonProperty("memoUniqueNo")
      private Long memoUniqueNo; // 선택: 메모 고유번호

      @JsonProperty("accountNo")
      private String accountNo; // 필수: 계좌번호, 길이: 16

      @JsonProperty("transactionUniqueNo")
      private Long transactionUniqueNo; // 필수: 거래 고유번호

      @JsonProperty("transactionMemo")
      private String transactionMemo; // 선택: 메모, 길이: 255

      @JsonProperty("created")
      private String created; // 필수: 생성일, 길이: 10
    }
  }
}
