package shinhan.hackathon.ssyrial.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import shinhan.hackathon.ssyrial.model.ApiResponse;
import shinhan.hackathon.ssyrial.model.deposit.*;
import shinhan.hackathon.ssyrial.service.DepositService;


@RestController
@RequestMapping("/api/deposit")
public class DepositController extends BaseController {

  private final DepositService depositService;

  public DepositController(DepositService depositService) {
    this.depositService = depositService;
  }

  /*
   * createDepositAccount (예금 계좌 생성)
   */
  @PostMapping("/createDepositAccount")
  public ResponseEntity<ApiResponse<CreateDepositAccountModel.Response>> createDepositAccount(
      @RequestBody CreateDepositAccountModel.Request request) {
    CreateDepositAccountModel.Response response = depositService.createDepositAccount(
        request.getUserKey(),request.getWithdrawalAccountNo(), request.getAccountTypeUniqueNo(), request.getDepositBalance());
    return successResponse(response);
  }


  /*
   * createDeposit (예금 상품 등록)
   */
  @PostMapping("/createDeposit")
  public ResponseEntity<ApiResponse<CreateDepositModel.Response>> createDeposit(
      @RequestBody CreateDepositModel.Request request) {
    CreateDepositModel.Response response = depositService.createDeposit(
        request.getBankCode(),request.getAccountName(),request.getAccountDescription(),request.getSubscriptionPeriod(),request.getMinSubscriptionBalance(),request.getMaxSubscriptionBalance(),request.getInterestRate(),request.getRateDescription());
    return successResponse(response);
  }

  /*
   * inquireDepositPayment (예금 납입 상세 조회)
   */
  @PostMapping("/inquireDepositPayment")
  public ResponseEntity<ApiResponse<InquireDepositPaymentModel.Response>> inquireDepositPayment(
      @RequestBody InquireDepositPaymentModel.Request request) {
    InquireDepositPaymentModel.Response response = depositService.inquireDepositPayment(
        request.getUserKey(),request.getAccountNo());
    return successResponse(response);
  }

  /*
   * InquireDepositProducts (예금 상품 조회)
   */
  @PostMapping("/inquireDepositProducts")
  public ResponseEntity<ApiResponse<InquireDepositProductsModel.Response>> inquireDepositProducts(
      @RequestBody InquireDepositProductsModel.Request request) {
    InquireDepositProductsModel.Response response = depositService.inquireDepositProducts();
    return successResponse(response);
  }
}