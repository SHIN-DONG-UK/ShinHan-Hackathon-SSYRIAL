package shinhan.hackathon.ssyrial.model;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Getter
@Setter
public class IsAccountOpenableModel {
    private String userKey;
    private LocalDate dateReceived; // userKey 입력을 받은 날짜
}