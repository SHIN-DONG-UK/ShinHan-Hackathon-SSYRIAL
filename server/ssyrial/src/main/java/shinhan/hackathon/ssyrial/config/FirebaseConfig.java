package shinhan.hackathon.ssyrial.config;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.Environment;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Base64;

@Configuration
public class FirebaseConfig {

  private static final Logger logger = LoggerFactory.getLogger(FirebaseConfig.class);
  private static final String FIREBASE_CONFIG_ENV = "FIREBASE_CONFIG";

  private final Environment env;

  public FirebaseConfig(Environment env) {
    this.env = env;
  }

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
    String firebaseConfig = env.getProperty(FIREBASE_CONFIG_ENV);
    if (firebaseConfig == null || firebaseConfig.isEmpty()) {
      throw new IllegalArgumentException("Firebase configuration not found in environment variables.");
    }
    byte[] decodedBytes = Base64.getDecoder().decode(firebaseConfig);
    return new ByteArrayInputStream(decodedBytes);
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
