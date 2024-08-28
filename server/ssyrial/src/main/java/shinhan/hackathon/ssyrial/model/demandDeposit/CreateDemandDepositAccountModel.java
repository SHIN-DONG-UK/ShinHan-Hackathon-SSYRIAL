package shinhan.hackathon.ssyrial.model.demandDeposit;

import lombok.Getter;
import lombok.Setter;
import shinhan.hackathon.ssyrial.model.CommonHeaderModel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;

import jakarta.validation.constraints.NotBlank;

import com.fasterxml.jackson.annotation.JsonProperty;

public class CreateDemandDepositAccountModel {

  @Getter
  @Setter
  @NoArgsConstructor
  @AllArgsConstructor
  @Builder
  public static class Request {
    @JsonProperty("Header")
    private CommonHeaderModel.Request Header;

    @NotBlank(message = "상품 고유번호는 필수 입력 항목입니다.")
    private String accountTypeUniqueNo;

    @NotBlank(message = "사용자 키는 필수 입력 항목입니다.")
    private String userKey;
  }

  @Getter
  @Setter
  @NoArgsConstructor
  @AllArgsConstructor
  public static class Response {
    @JsonProperty("Header")
    private CommonHeaderModel.Response Header;

    @JsonProperty("REC")
    private AccountInfo REC;

    @Getter
    @Setter
    @NoArgsConstructor
    @AllArgsConstructor
    public static class AccountInfo {
      private String bankCode;
      private String accountNo;
      private CurrencyInfo currency;

      @Getter
      @Setter
      @NoArgsConstructor
      @AllArgsConstructor
      public static class CurrencyInfo {
        private String currency;
        private String currencyName;
      }
    }
  }
}
