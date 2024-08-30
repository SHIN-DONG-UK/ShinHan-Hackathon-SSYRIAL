package shinhan.hackathon.ssyrial.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import shinhan.hackathon.ssyrial.model.IsAccountOpenableModel;
import shinhan.hackathon.ssyrial.service.IsAccountOpenableService;

@RestController
@RequestMapping("/api")
public class IsAccountOpenableController {

    @Autowired
    private IsAccountOpenableService isAccountOpenableService;

    @PostMapping("/isAccountOpenable")
    public boolean isAccountOpenable(@RequestBody IsAccountOpenableModel model) {
        return isAccountOpenableService.isAccountOpenable(model);
    }
}