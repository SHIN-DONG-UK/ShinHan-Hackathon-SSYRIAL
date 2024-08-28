package shinhan.hackathon.ssyrial.config;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;

@Configuration
public class FirebaseConfig {

  private static final Logger logger = LoggerFactory.getLogger(FirebaseConfig.class);

  // .env 파일 또는 application.properties 파일에서 firebase.adminsdk 값을 가져옴
  @Value("${firebase.adminsdk}")
  private String firebaseConfig;

  @Bean
  public FirebaseApp firebaseApp() {
    try {
      InputStream serviceAccount = loadServiceAccount();
      FirebaseOptions options = buildFirebaseOptions(serviceAccount);
      return initializeFirebaseApp(options);
    } catch (Exception e) {
      logger.error("Firebase connection failed: {}", e.getMessage());
      logger.warn("Server will continue to run without Firebase integration.");
      return null; // Firebase integration is optional; continue without it.
    }
  }

  private InputStream loadServiceAccount() throws IOException {
    if (firebaseConfig == null || firebaseConfig.isEmpty()) {
      throw new IllegalArgumentException("Firebase configuration not found.");
    }

    // JSON 형식의 환경 변수를 InputStream으로 변환
    return new ByteArrayInputStream(firebaseConfig.getBytes());
  }

  private FirebaseOptions buildFirebaseOptions(InputStream serviceAccount) throws IOException {
    return FirebaseOptions.builder()
        .setCredentials(GoogleCredentials.fromStream(serviceAccount))
        .build();
  }

  private FirebaseApp initializeFirebaseApp(FirebaseOptions options) {
    if (FirebaseApp.getApps().isEmpty()) {
      FirebaseApp.initializeApp(options);
      logger.info("FirebaseApp initialized successfully.");
    }
    return FirebaseApp.getInstance();
  }
}
