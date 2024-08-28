package shinhan.hackathon.ssyrial.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import shinhan.hackathon.ssyrial.model.ApiResponse;
import shinhan.hackathon.ssyrial.model.api.*;
import shinhan.hackathon.ssyrial.service.AppService;

/**
 * AppController 클래스는 API 키 발급 및 재발급 요청을 처리하는 컨트롤러입니다.
 *
 * 이 클래스는 API 키 관련 기능에 대한 엔드포인트를 제공합니다.
 * - /api/app/getApiKey: API 키 발급 요청을 처리합니다.
 * - /api/app/getReApiKey: API 키 재발급 요청을 처리합니다.
 *
 */
@RestController
@RequestMapping("/api/app")
public class AppController extends BaseController {

  private final AppService appService;

  /**
   * AppController 생성자.
   * 
   * @param appService API 키 관련 비즈니스 로직을 처리하는 서비스 클래스
   */
  public AppController(AppService appService) {
    this.appService = appService;
  }

  /**
   * /getApiKey 엔드포인트로 들어오는 API 키 발급 요청을 처리합니다.
   * 
   * 이 메서드는 클라이언트로부터 API 키 발급 요청 데이터를 받아서 처리한 후,
   * 발급된 API 키 정보를 반환합니다.
   *
   * @param request IssuedApiKeyModel.Request - API 키 발급 요청 데이터
   * @return ResponseEntity<ApiResponse<IssuedApiKeyModel.Response>> - 발급된 API 키
   *         정보가 담긴 응답
   */
  @PostMapping("/getApiKey")
  public ResponseEntity<ApiResponse<IssuedApiKeyModel.Response>> getApiKey(
      @RequestBody IssuedApiKeyModel.Request request) {
    IssuedApiKeyModel.Response response = appService.getIssuedApiKey(request);
    return successResponse(response);
  }

  /**
   * /getReApiKey 엔드포인트로 들어오는 API 키 재발급 요청을 처리합니다.
   * 
   * 이 메서드는 클라이언트로부터 API 키 재발급 요청 데이터를 받아서 처리한 후,
   * 재발급된 API 키 정보를 반환합니다.
   *
   * @param request ReIssuedApiKeyModel.Request - API 키 재발급 요청 데이터
   * @return ResponseEntity<ApiResponse<ReIssuedApiKeyModel.Response>> - 재발급된 API
   *         키 정보가 담긴 응답
   */
  @PostMapping("/getReApiKey")
  public ResponseEntity<ApiResponse<ReIssuedApiKeyModel.Response>> getReApiKey(
      @RequestBody ReIssuedApiKeyModel.Request request) {
    ReIssuedApiKeyModel.Response response = appService.getReIssuedApiKey(request);
    return successResponse(response);
  }
}
