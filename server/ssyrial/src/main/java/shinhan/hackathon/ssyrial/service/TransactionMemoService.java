/*
/transactionMemo
거래내역 메모
*/
package shinhan.hackathon.ssyrial.service;

import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import shinhan.hackathon.ssyrial.model.CommonHeaderModel;
import shinhan.hackathon.ssyrial.model.transactionMemo.*;

@Service
public class TransactionMemoService extends ShinhanApiService {

  public TransactionMemoService(RestTemplate restTemplate, String apiKey) {
    super(restTemplate, apiKey);
  }

  public TransactionMemoModel.Response transactionMemo(String userKey, String accountNo, String transactionUniqueNo,
      String transactionMemo) {
    // 공통 헤더 생성, userKey는 필요하지 않음
    CommonHeaderModel.Request header = createCommonHeader("transactionMemo", "transactionMemo", userKey);

    // 은행 코드 조회 요청 데이터 생성
    TransactionMemoModel.Request request = TransactionMemoModel.Request.builder()
        .Header(header)
        .accountNo(accountNo)
        .transactionUniqueNo(transactionUniqueNo)
        .transactionMemo(transactionMemo)
        .build();

    // API 호출 및 응답 반환
    return sendRequest("/edu/transactionMemo", HttpMethod.POST, request, TransactionMemoModel.Response.class, true);
  }
}