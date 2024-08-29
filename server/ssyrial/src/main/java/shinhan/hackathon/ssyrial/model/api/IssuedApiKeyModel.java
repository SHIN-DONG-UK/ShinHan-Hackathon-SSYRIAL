package shinhan.hackathon.ssyrial.model.api;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;
import lombok.Setter;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

/**
 * IssuedApiKeyModel 클래스는 API 키 발급 요청 및 응답 데이터를 담는 모델 클래스입니다.
 */
public class IssuedApiKeyModel {

  /**
   * API 키 발급 요청 데이터를 담는 내부 클래스입니다.
   */
  @Getter
  @Setter
  @NoArgsConstructor
  @AllArgsConstructor
  public static class Request {

    @Schema(description = "관리자 이메일", example = "manager@example.com", required = true)
    @NotBlank(message = "managerId는 필수 입력 항목입니다.")
    @Email(message = "managerId는 유효한 이메일 형식이어야 합니다.")
    @Size(max = 30, message = "managerId는 최대 30글자 이내여야 합니다.")
    private String managerId;
  }

  /**
   * API 키 발급 응답 데이터를 담는 내부 클래스입니다.
   */
  @Getter
  @Setter
  @NoArgsConstructor
  @AllArgsConstructor
  public static class Response {

    @Schema(description = "관리자 이메일", example = "manager@example.com")
    private String managerId;

    @Schema(description = "발급된 API 키", example = "ABCD-1234-EFGH-5678")
    private String apiKey;

    @Schema(description = "API 키 발급 날짜", example = "2024-08-29")
    private String createDate;

    @Schema(description = "API 키 만료 날짜", example = "2025-08-29")
    private String expirationDate;
  }
}
