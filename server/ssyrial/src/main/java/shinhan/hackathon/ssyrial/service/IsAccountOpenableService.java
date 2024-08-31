package shinhan.hackathon.ssyrial.service;


import org.springframework.stereotype.Service;

import shinhan.hackathon.ssyrial.model.IsAccountOpenableModel;

import java.time.LocalDate;

@Service
public class IsAccountOpenableService {

    public boolean isAccountOpenable(IsAccountOpenableModel model) {
        LocalDate DB = LocalDate.parse("1990-01-01");
        LocalDate today = LocalDate.now();

        // userKey 입력을 받은 날짜 + 30일이 오늘 날짜보다 크거나 같은지 확인
        return DB.plusDays(30).isBefore(today);
    }
}