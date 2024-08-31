package shinhan.hackathon.ssyrial.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

public class CreateAccountModel {

  /**
   * 입출금 계좌 생성 Id
   */
  @Getter
  @Setter
  @NoArgsConstructor
  @AllArgsConstructor
  @Builder
  public static class Request {
    private String userKey;
  }

  /**
   * 계좌 생성가능 여부 조회결과
   */
  @Getter
  @Setter
  @NoArgsConstructor
  @AllArgsConstructor
  @Builder
  public static class Response {
    private boolean createAccountResult;
  }
}