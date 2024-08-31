package shinhan.hackathon.ssyrial.service;


import org.springframework.stereotype.Service;

import shinhan.hackathon.ssyrial.model.IsAccountOpenableModel;

import java.time.LocalDate;

@Service
public class IsAccountOpenableService {

    public boolean isAccountOpenable(IsAccountOpenableModel model) {
        LocalDate db = LocalDate.parse("2024-08-29");
        LocalDate today = LocalDate.now();

        // DB날짜 + 30일이 오늘 날짜보다 크거나 같은지 확인
        return db.plusDays(30).isBefore(today);
    }
}