package shinhan.hackathon.ssyrial;

import java.util.TimeZone;

import javax.annotation.PostConstruct;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class SsyrialApplication {

    @PostConstruct
    public void started() {
      TimeZone.setDefault(TimeZone.getTimeZone("Asia/Seoul"));
    }
    
    public static void main(String[] args) {
    SpringApplication.run(SsyrialApplication.class, args);
  }

}
