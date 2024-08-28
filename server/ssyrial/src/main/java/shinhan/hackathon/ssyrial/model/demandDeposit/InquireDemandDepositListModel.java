package shinhan.hackathon.ssyrial.model.demandDeposit;

import lombok.Getter;
import lombok.Setter;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.List;

import shinhan.hackathon.ssyrial.model.CommonHeaderModel;

/**
 * InquireDemandDepositListModel 클래스는 은행별 계좌 상품 조회 요청 및 응답 데이터를 담는 모델 클래스입니다.
 */
public class InquireDemandDepositListModel {

  /**
   * 은행별 계좌 상품 조회 요청 데이터를 담는 내부 클래스입니다.
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
   * 은행별 계좌 상품 조회 응답 데이터를 담는 내부 클래스입니다.
   */
  @Getter
  @Setter
  @NoArgsConstructor
  @AllArgsConstructor
  public static class Response {

    @JsonProperty("Header")
    private CommonHeaderModel.Response Header;

    @JsonProperty("REC")
    private List<DemandDepositProduct> REC;

    /**
     * 은행별 계좌 상품 데이터를 담는 내부 클래스입니다.
     */
    @Getter
    @Setter
    @NoArgsConstructor
    @AllArgsConstructor
    public static class DemandDepositProduct {
      private String accountTypeUniqueNo;
      private String bankCode;
      private String bankName;
      private String accountTypeCode;
      private String accountTypeName;
      private String accountName;
      private String accountDescription;
      private String accountType;
    }
  }
}
