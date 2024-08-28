/*
/transactionMemo
거래내역 메모
*/
package shinhan.hackathon.ssyrial.service;

import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import shinhan.hackathon.ssyrial.model.CommonHeaderModel;
import shinhan.hackathon.ssyrial.model.transactionMemo.TransactionMemoModel;

@Service
public class TransactionMemo extends ShinhanApiService {

  public TransactionMemo(RestTemplate restTemplate, String apiKey) {
    super(restTemplate, apiKey);
  }

  public TransactionMemo.Response transactionMemo(String accountNo, String transactionUniqueNo, String transactionMemo) {
    // 공통 헤더 생성, userKey는 필요하지 않음
    CommonHeaderModel.Request header = createCommonHeader("transactionMemo", "transactionMemo", null);

    // 은행 코드 조회 요청 데이터 생성
    TransactionMemo.Request request = TransactionMemo.Request.builder()
        .Header(header)
        .accountNo(accountNo)
        .transactionUniqueNo(transactionUniqueNo)
        .transactionMemo(transactionMemo)
        .build();

    // API 호출 및 응답 반환
    return sendRequest("/edu/transactionMemo", HttpMethod.POST, request, TransactionMemo.Response.class, true);
  }
}
