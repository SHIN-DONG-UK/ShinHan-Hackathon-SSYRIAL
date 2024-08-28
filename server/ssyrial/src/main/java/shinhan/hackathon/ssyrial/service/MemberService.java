package shinhan.hackathon.ssyrial.service;

import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import shinhan.hackathon.ssyrial.model.member.*;

/**
 * MemberService 클래스는 회원 등록 및 검색과 관련된 비즈니스 로직을 처리하는 서비스 클래스입니다.
 */
@Service
public class MemberService extends ShinhanApiService {

  /**
   * MemberService 생성자.
   * 
   * @param restTemplate 외부 API와의 통신을 위한 RestTemplate 객체
   * @param apiKey       API 요청 시 사용할 API 키
   */
  public MemberService(RestTemplate restTemplate, String apiKey) {
    super(restTemplate, apiKey);
  }

  /**
   * 회원 등록 요청을 처리하는 메서드입니다.
   * 
   * 클라이언트로부터 회원 등록 요청 데이터를 받아서 처리하고,
   * 등록된 회원 정보를 반환합니다.
   * 
   * @param request MemberModel.Request - 회원 등록 요청 데이터
   * @return MemberModel.Response - 등록된 회원 정보 응답
   */
  public MemberModel.Response createMember(MemberModel.Request request) {
    return sendRequest("/member/", HttpMethod.POST, request, MemberModel.Response.class, true);
  }

  /**
   * 회원 검색 요청을 처리하는 메서드입니다.
   * 
   * 클라이언트로부터 회원 검색 요청 데이터를 받아서 처리하고,
   * 검색된 회원 정보를 반환합니다.
   * 
   * @param request MemberSearchModel.Request - 회원 검색 요청 데이터
   * @return MemberSearchModel.Response - 검색된 회원 정보 응답
   */
  public MemberSearchModel.Response searchMember(MemberSearchModel.Request request) {
    return sendRequest("/member/search", HttpMethod.POST, request, MemberSearchModel.Response.class, true);
  }
}
