package shinhan.hackathon.ssyrial.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import shinhan.hackathon.ssyrial.model.ApiResponse;
import shinhan.hackathon.ssyrial.model.bank.*;
import shinhan.hackathon.ssyrial.service.BankService;

/**
 * BankController 클래스는 은행 코드 조회 요청을 처리하는 컨트롤러입니다.
 *
 * 이 클래스는 은행 코드 조회 관련 기능에 대한 엔드포인트를 제공합니다.
 * - /api/bank/inquireBankCodes: 은행 코드 조회 요청을 처리합니다.
 *
 */
@RestController
@RequestMapping("/api/bank")
public class BankController extends BaseController {

  private final BankService bankService;

  /**
   * BankController 생성자.
   * 
   * @param bankService 은행 코드 조회 관련 비즈니스 로직을 처리하는 서비스 클래스
   */
  public BankController(BankService bankService) {
    this.bankService = bankService;
  }

  /**
   * /inquireBankCodes 엔드포인트로 들어오는 은행 코드 조회 요청을 처리합니다.
   * 
   * 이 메서드는 클라이언트로부터 은행 코드 조회 요청을 받아서 처리한 후,
   * 조회된 은행 코드 정보를 반환합니다.
   *
   * @return ResponseEntity<ApiResponse<InquireBankCodes.Response>> - 은행 코드 조회 정보가
   *         담긴 응답
   */
  @PostMapping("/inquireBankCodes")
  public ResponseEntity<ApiResponse<InquireBankCodes.Response>> inquireBankCodes() {
    InquireBankCodes.Response response = bankService.inquireBankCodes();
    return successResponse(response);
  }
}
