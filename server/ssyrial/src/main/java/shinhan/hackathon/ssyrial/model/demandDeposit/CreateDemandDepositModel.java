package shinhan.hackathon.ssyrial.model.demandDeposit;

import lombok.Getter;
import lombok.Setter;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;

import com.fasterxml.jackson.annotation.JsonProperty;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

import shinhan.hackathon.ssyrial.model.CommonHeaderModel;

/**
 * CreateDemandDepositModel 클래스는 정기 입출금 상품 등록 요청 및 응답 데이터를 담는 모델 클래스입니다.
 */
public class CreateDemandDepositModel {

  @Getter
  @Setter
  @NoArgsConstructor
  @AllArgsConstructor
  @Builder
  public static class Request {

    @JsonProperty("Header")
    private CommonHeaderModel.Request header;

    @NotBlank(message = "은행 코드는 필수 입력 항목입니다.")
    @Size(min = 3, max = 3, message = "은행 코드는 3자리여야 합니다.")
    private String bankCode;

    @NotBlank(message = "상품 이름은 필수 입력 항목입니다.")
    @Size(max = 20, message = "상품 이름은 최대 20자까지 허용됩니다.")
    private String accountName;

    @Size(max = 255, message = "상품 설명은 최대 255자까지 허용됩니다.")
    private String accountDescription;
  }

  @Getter
  @Setter
  @NoArgsConstructor
  @AllArgsConstructor
  public static class Response {

    @JsonProperty("Header")
    private CommonHeaderModel.Response header;

    @JsonProperty("REC")
    private ProductInfo rec;

    @Getter
    @Setter
    @NoArgsConstructor
    @AllArgsConstructor
    public static class ProductInfo {
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
