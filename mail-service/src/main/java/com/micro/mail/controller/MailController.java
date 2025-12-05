package com.micro.mail.controller;

import com.micro.mail.service.MailService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/mail")
public class MailController {

    private final MailService service;

    public MailController(MailService service) {
        this.service = service;
    }

    @PostMapping("/user/account-created")
    public ResponseEntity<String> userAccountCreated(@RequestBody MailRequest req) {
        service.sendUserAccountCreated(req.email, req.username);
        return ResponseEntity.ok("User account mail sent");
    }

    @PostMapping("/admin/account-created")
    public ResponseEntity<String> adminAccountCreated(@RequestBody MailRequest req) {
        service.sendAdminAccountCreated(req.email, req.adminName);
        return ResponseEntity.ok("Admin account mail sent");
    }

    @PostMapping("/song/added")
    public ResponseEntity<String> songAdded(@RequestBody MailRequest req) {
        service.sendSongAdded(req.email, req.songTitle);
        return ResponseEntity.ok("Song added mail sent");
    }

    public static class MailRequest {
        public String email;
        public String username;
        public String adminName;
        public String songTitle;
    }
}

