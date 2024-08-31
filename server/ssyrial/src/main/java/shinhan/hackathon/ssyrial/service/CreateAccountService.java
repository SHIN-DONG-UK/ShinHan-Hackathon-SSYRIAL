package shinhan.hackathon.ssyrial.service;

import org.springframework.stereotype.Service;

import shinhan.hackathon.ssyrial.model.CreateAccountModel;

import java.time.LocalDate;

@Service
public class CreateAccountService {

  public CreateAccountModel.Response createAccount(String userKey) {
    LocalDate DB = LocalDate.parse("1990-01-01");
    LocalDate today = LocalDate.now();
    boolean result = DB.plusDays(30).isBefore(today); // userKey 입력을 받은 날짜 + 30일이 오늘 날짜보다 크거나 같은지 확인
    CreateAccountModel.Response response = new CreateAccountModel.Response(result);
    return response;
  }
}