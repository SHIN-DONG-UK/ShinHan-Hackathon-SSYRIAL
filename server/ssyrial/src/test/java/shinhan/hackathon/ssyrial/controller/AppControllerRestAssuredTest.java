// package shinhan.hackathon.ssyrial.controller;

// import io.restassured.RestAssured;
// import org.junit.jupiter.api.BeforeEach;
// import org.junit.jupiter.api.Test;
// import org.springframework.boot.test.context.SpringBootTest;
// import org.springframework.boot.test.web.server.LocalServerPort;

// import static io.restassured.RestAssured.given;
// import static org.hamcrest.Matchers.equalTo;

// @SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
// class AppControllerRestAssuredTest {

//   @LocalServerPort
//   private int port;

//   @BeforeEach
//   void setUp() {
//     RestAssured.port = port;
//   }

//   @Test
//   void testGetApiKeySuccess() {
//     String requestBody = "{\"managerId\":\"example@naver.com\"}";

//     given()
//         .contentType("application/json")
//         .body(requestBody)
//         .when()
//         .post("/api/app/getApiKey")
//         .then()
//         .statusCode(200)
//         .body("success", equalTo(true));
//   }

//   @Test
//   void testGetApiKeyFailure() {
//     String requestBody = "{\"managerId\":\"example@naver.com\"}"; // 빈 managerId로 실패 케이스 확인

//     given()
//         .contentType("application/json")
//         .body(requestBody)
//         .when()
//         .post("/api/app/getApiKey")
//         .then()
//         .statusCode(400) // 잘못된 요청에 대한 상태 코드 확인
//         .body("success", equalTo(false)); // 실패 케이스 확인
//   }
// }
