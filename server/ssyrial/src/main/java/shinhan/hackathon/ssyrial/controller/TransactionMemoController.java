package shinhan.hackathon.ssyrial.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import shinhan.hackathon.ssyrial.model.ApiResponse;
import shinhan.hackathon.ssyrial.model.transactionMemo.*;
import shinhan.hackathon.ssyrial.service.TransactionMemoService;


@RestController
@RequestMapping("/api/transactionMemo")
public class TransactionMemoController extends BaseController {

  private final TransactionMemoService TransactionMemoService;

  public TransactionMemoController(TransactionMemoService TransactionMemoService) {
    this.TransactionMemoService = TransactionMemoService;
  }


  @PostMapping("")
  public ResponseEntity<ApiResponse<TransactionMemoModel.Response>> transactionMemo(
    @RequestBody TransactionMemoModel.Request request
  ) {
    TransactionMemoModel.Response response = TransactionMemoService.transactionMemo(
       request.getUserKey(), request.getAccountNo(), request.getTransactionUniqueNo(), request.getTransactionMemo()
    );
    return successResponse(response);
  }
}
