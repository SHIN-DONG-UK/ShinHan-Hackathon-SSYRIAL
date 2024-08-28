package shinhan.hackathon.ssyrial.exception;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.method.annotation.MethodArgumentTypeMismatchException;
import org.springframework.web.bind.MethodArgumentNotValidException;

import shinhan.hackathon.ssyrial.model.ApiResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.HashMap;
import java.util.Map;

/**
 * GlobalExceptionHandler는 전역적으로 발생하는 예외를 처리하는 클래스입니다.
 * HttpClientErrorException, MethodArgumentTypeMismatchException, MethodArgumentNotValidException 및 일반 예외(Exception)에 대한 처리 로직을 제공합니다.
 */
@ControllerAdvice
public class GlobalExceptionHandler {

  private static final Logger logger = LoggerFactory.getLogger(GlobalExceptionHandler.class);

  /**
   * HttpClientErrorException이 발생했을 때 해당 예외를 처리하는 메서드입니다.
   * 
   * @param e HttpClientErrorException - HTTP 클라이언트 오류 예외
   * @return ResponseEntity<ApiResponse<String>> - 오류 응답
   */
  @ExceptionHandler(HttpClientErrorException.class)
  public ResponseEntity<ApiResponse<String>> handleHttpClientErrorException(HttpClientErrorException e) {
    logger.error("HTTP Client Error: Status Code: {}, Response Body: {}", e.getStatusCode(), e.getResponseBodyAsString());
    return new ResponseEntity<>(ApiResponse.error(e.getResponseBodyAsString()), e.getStatusCode());
  }

  /**
   * MethodArgumentTypeMismatchException이 발생했을 때 해당 예외를 처리하는 메서드입니다.
   * 
   * @param e MethodArgumentTypeMismatchException - 메서드 인자 타입 불일치 예외
   * @return ResponseEntity<ApiResponse<String>> - 오류 응답
   */
  @ExceptionHandler(MethodArgumentTypeMismatchException.class)
  public ResponseEntity<ApiResponse<String>> handleTypeMismatchException(MethodArgumentTypeMismatchException e) {
    String errorMessage = String.format("The parameter '%s' with value '%s' could not be converted to type '%s'",
                                         e.getName(), e.getValue(), e.getRequiredType().getSimpleName());
    logger.error("Method Argument Type Mismatch: {}", errorMessage);
    return new ResponseEntity<>(ApiResponse.error(errorMessage), HttpStatus.BAD_REQUEST);
  }

  /**
   * MethodArgumentNotValidException이 발생했을 때 해당 예외를 처리하는 메서드입니다.
   * 
   * @param e MethodArgumentNotValidException - 메서드 인자가 유효하지 않음
   * @return ResponseEntity<ApiResponse<Map<String, String>>> - 오류 응답
   */
  @ExceptionHandler(MethodArgumentNotValidException.class)
  public ResponseEntity<ApiResponse<Map<String, String>>> handleValidationException(MethodArgumentNotValidException e) {
    Map<String, String> errors = new HashMap<>();
    e.getBindingResult().getFieldErrors().forEach(fieldError ->
      errors.put(fieldError.getField(), fieldError.getDefaultMessage())
    );
    logger.error("Validation Error: {}", errors);
    return new ResponseEntity<>(ApiResponse.error("Validation failed", errors), HttpStatus.BAD_REQUEST);
  }

  /**
   * Exception이 발생했을 때 해당 예외를 처리하는 메서드입니다.
   * 
   * @param e Exception - 일반 예외
   * @return ResponseEntity<ApiResponse<String>> - 오류 응답
   */
  @ExceptionHandler(Exception.class)
  public ResponseEntity<ApiResponse<String>> handleGeneralException(Exception e) {
    logger.error("Unexpected error occurred: {}", e.getMessage(), e);
    return new ResponseEntity<>(ApiResponse.error("An unexpected error occurred. Please try again later."),
                                HttpStatus.INTERNAL_SERVER_ERROR);
  }
}
