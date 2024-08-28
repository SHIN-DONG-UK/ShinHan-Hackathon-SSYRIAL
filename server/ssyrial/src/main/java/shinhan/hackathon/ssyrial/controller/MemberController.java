package shinhan.hackathon.ssyrial.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import shinhan.hackathon.ssyrial.model.ApiResponse;
import shinhan.hackathon.ssyrial.model.member.*;
import shinhan.hackathon.ssyrial.service.MemberService;

/**
 * MemberController 클래스는 회원 관련 요청을 처리하는 컨트롤러입니다.
 *
 * 이 클래스는 회원 등록 및 회원 검색 관련 기능에 대한 엔드포인트를 제공합니다.
 * - /api/member: 회원 등록 요청을 처리합니다.
 * - /api/member/search: 회원 검색 요청을 처리합니다.
 *
 */
@RestController
@RequestMapping("/api/member")
public class MemberController extends BaseController {

  private final MemberService memberService;

  /**
   * MemberController 생성자.
   * 
   * @param memberService 회원 관련 비즈니스 로직을 처리하는 서비스 클래스
   */
  public MemberController(MemberService memberService) {
    this.memberService = memberService;
  }

  /**
   * / 엔드포인트로 들어오는 회원 등록(회원가입) 요청을 처리합니다.
   * 
   * 이 메서드는 클라이언트로부터 회원 등록 요청 데이터를 받아서 처리한 후,
   * 등록된 회원 정보를 반환합니다.
   *
   * @param request MemberModel.Request - 회원 등록 요청 데이터
   * @return ResponseEntity<ApiResponse<MemberModel.Response>> - 등록된 회원 정보가 담긴 응답
   */
  @PostMapping("/")
  public ResponseEntity<ApiResponse<MemberModel.Response>> createMember(
      @RequestBody MemberModel.Request request) {
    MemberModel.Response response = memberService.createMember(request);
    return successResponse(response);
  }

  /**
   * /search 엔드포인트로 들어오는 회원 검색 요청을 처리합니다.
   * 
   * 이 메서드는 클라이언트로부터 회원 검색 요청 데이터를 받아서 처리한 후,
   * 검색된 회원 정보를 반환합니다.
   *
   * @param request MemberSearchModel.Request - 회원 검색 요청 데이터
   * @return ResponseEntity<ApiResponse<MemberSearchModel.Response>> - 검색된 회원 정보가
   *         담긴 응답
   */
  @PostMapping("/search")
  public ResponseEntity<ApiResponse<MemberSearchModel.Response>> searchMember(
      @RequestBody MemberSearchModel.Request request) {
    MemberSearchModel.Response response = memberService.searchMember(request);
    return successResponse(response);
  }
}
