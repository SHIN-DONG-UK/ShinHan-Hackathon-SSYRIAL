package shinhan.hackathon.ssyrial.config.exception;

import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.Builder;
import lombok.Getter;
import shinhan.hackathon.ssyrial.common.codes.ErrorCode;

/**
 * 에러를 사용하기 위한 구현체
 */
public class BusinessExceptionHandler extends RuntimeException {

  @Getter
  private final ErrorCode errorCode;

  @Builder
  public BusinessExceptionHandler(String message, ErrorCode errorCode) {
    super(formatMessage(message));
    this.errorCode = errorCode;
  }

  @Builder
  public BusinessExceptionHandler(ErrorCode errorCode) {
    super(errorCode.getMessage());
    this.errorCode = errorCode;
  }

  private static String formatMessage(String message) {
    try {
      // JSON 메시지를 포맷팅
      ObjectMapper objectMapper = new ObjectMapper();
      Object json = objectMapper.readValue(message, Object.class);
      return objectMapper.writerWithDefaultPrettyPrinter().writeValueAsString(json);
    } catch (Exception e) {
      // JSON 파싱에 실패하면 원본 메시지를 반환
      return message;
    }
  }
}
