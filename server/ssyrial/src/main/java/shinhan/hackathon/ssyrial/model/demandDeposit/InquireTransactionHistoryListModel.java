/*
2.3.12 계좌 거래 내역 조회 (p.61)

설명
계좌 거래 내역 목록을 조회합니다.

Request
Header - 공통 - 타입X - 길이X - 필수Y
accountNo - 계좌번호 - String - 길이16 - 필수Y
startDate - 조회시작일자 - String - 길이8 - 필수Y - YYYYMMDD
endDate - 조회종료일자 - String - 길이8 - 필수Y - YYYYMMDD
transactionType - 거래구분 - String - 길이1 - 필수Y - M:입금 D:출금 A:전체
orderByType - 정렬순서 - String - 길이4 - 필수N - 거래고유번호 기준 ASC:오름차순(이전거래), DESC:내림차순(최근거래)

Response
Header - 공통 - 타입X - 길이X - 필수Y
REC - 거래내역 - List - 길이X - 필수N
totalCount - 조회총건수 - String - 길이X - 필수N
list - 거래목록 - List - 길이X - 필수N
transactionUniqueNo - 거래고유번호 - Long - 길이X - 필수Y
transactionDate - 거래일자 - String - 길이8 - 필수Y
transactionTime - 거래시각 - String - 길이6 - 필수Y
transactionType - 입금출금구분 - String - 길이1 - 필수Y - 1,2
transactionTypeName - 입금출금구분명 - String - 길이10 - 필수Y - 입금, 출금, 입금(이체), 출금(이체)
transactionAccountNo - 거래계좌번호 - String - 길이16 - 필수N
transactionBalance - 거래금액 - Long - 길이X - 필수Y
transactionAfterBalance - 거래후잔액 - Long - 길이X - 필수Y
transactionSummary - 거래 요약내용 - String - 길이255 - 필수N
transactionMemo - 거래 메모 - String - 길이255 - 필수N
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

/**
 * InquireTransactionHistoryListModel 클래스는 계좌 거래 내역 조회 요청 및 응답 데이터를 담는 모델
 * 클래스입니다.
 */
public class InquireTransactionHistoryListModel {

  /**
   * 계좌 거래 내역 조회 요청 데이터를 담는 내부 클래스입니다.
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

    @JsonProperty("startDate")
    private String startDate; // 필수: 조회시작일자, 길이: 8, YYYYMMDD

    @JsonProperty("endDate")
    private String endDate; // 필수: 조회종료일자, 길이: 8, YYYYMMDD

    @JsonProperty("transactionType")
    private String transactionType; // 필수: 거래구분, 길이: 1 (M:입금, D:출금, A:전체)

    @JsonProperty("orderByType")
    private String orderByType; // 선택: 정렬순서, 길이: 4 (ASC:오름차순, DESC:내림차순)
  }

  /**
   * 계좌 거래 내역 조회 응답 데이터를 담는 내부 클래스입니다.
   */
  @Getter
  @Setter
  @NoArgsConstructor
  @AllArgsConstructor
  public static class Response {

    @JsonProperty("Header")
    private CommonHeaderModel.Response Header;

    @JsonProperty("REC")
    private List<TransactionHistoryInfo> REC; // 거래내역 리스트 (필수 아님)

    @JsonProperty("totalCount")
    private String totalCount; // 선택: 조회총건수

    @JsonProperty("list")
    private List<TransactionHistoryInfo> list; // 선택: 거래목록 리스트

    /**
     * 거래내역 정보를 담는 내부 클래스입니다.
     */
    @Getter
    @Setter
    @NoArgsConstructor
    @AllArgsConstructor
    public static class TransactionHistoryInfo {
      @JsonProperty("transactionUniqueNo")
      private Long transactionUniqueNo; // 필수: 거래고유번호

      @JsonProperty("transactionDate")
      private String transactionDate; // 필수: 거래일자, 길이: 8

      @JsonProperty("transactionTime")
      private String transactionTime; // 필수: 거래시각, 길이: 6

      @JsonProperty("transactionType")
      private String transactionType; // 필수: 입금출금구분, 길이: 1

      @JsonProperty("transactionTypeName")
      private String transactionTypeName; // 필수: 입금출금구분명, 길이: 10

      @JsonProperty("transactionAccountNo")
      private String transactionAccountNo; // 선택: 거래계좌번호, 길이: 16

      @JsonProperty("transactionBalance")
      private Long transactionBalance; // 필수: 거래금액

      @JsonProperty("transactionAfterBalance")
      private Long transactionAfterBalance; // 필수: 거래후잔액

      @JsonProperty("transactionSummary")
      private String transactionSummary; // 선택: 거래 요약내용, 길이: 255

      @JsonProperty("transactionMemo")
      private String transactionMemo; // 선택: 거래 메모, 길이: 255
    }
  }
}
