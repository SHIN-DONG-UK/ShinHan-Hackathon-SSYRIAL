// package shinhan.hackathon.ssyrial.controller;

// import org.junit.jupiter.api.Test;
// import org.springframework.boot.test.context.SpringBootTest;
// import org.springframework.beans.factory.annotation.Autowired;
// import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
// import org.springframework.test.web.servlet.MockMvc;

// import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
// import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
// import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;

// @SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
// @AutoConfigureMockMvc
// class AppControllerTest {

//   @Autowired
//   private MockMvc mockMvc;

//   @Test
//   void testGetApiKeySuccess() throws Exception {
//     String requestBody = "{\"managerId\":\"testManager\"}";

//     mockMvc.perform(post("/api/app/getApiKey")
//         .contentType("application/json")
//         .content(requestBody))
//         .andExpect(status().isOk()) // 성공 상태 코드 확인
//         .andExpect(jsonPath("$.success").value(true)); // 성공 케이스 확인
//   }

//   @Test
//   void testGetApiKeyFailure() throws Exception {
//     String requestBody = "{\"managerId\":\"\"}"; // 빈 managerId로 실패 케이스 확인

//     mockMvc.perform(post("/api/app/getApiKey")
//         .contentType("application/json")
//         .content(requestBody))
//         .andExpect(status().isBadRequest()) // 실패 상태 코드 확인
//         .andExpect(jsonPath("$.success").value(false)); // 실패 케이스 확인
//   }
// }
