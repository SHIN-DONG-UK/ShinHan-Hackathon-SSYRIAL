package shinhan.hackathon.ssyrial.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import shinhan.hackathon.ssyrial.model.ApiResponse;
import shinhan.hackathon.ssyrial.model.CreateAccountModel;
import shinhan.hackathon.ssyrial.service.CreateAccountService;

@RestController
@RequestMapping("/api")
public class CreateAccountController extends BaseController {

  @Autowired
  private CreateAccountService createAccountService;

  public CreateAccountController(CreateAccountService createAccountService) {
    this.createAccountService = createAccountService;
  }

  @PostMapping("/createAccount")
  public ResponseEntity<ApiResponse<CreateAccountModel.Response>> createAccount(
      @RequestBody CreateAccountModel.Request request) {
    CreateAccountModel.Response response = createAccountService.createAccount(request.getUserKey());
    return successResponse(response);
  }

}
