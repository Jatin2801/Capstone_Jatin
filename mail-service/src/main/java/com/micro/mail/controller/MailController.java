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
    public ResponseEntity<String> userAccountCreated(@RequestParam String email, @RequestParam String username) {
        service.sendUserAccountCreated(email, username);
        return ResponseEntity.ok("User account mail sent");
    }

    @PostMapping("/admin/account-created")
    public ResponseEntity<String> adminAccountCreated(@RequestParam String email, @RequestParam String adminName) {
        service.sendAdminAccountCreated(email, adminName);
        return ResponseEntity.ok("Admin account mail sent");
    }

    @PostMapping("/song/added")
    public ResponseEntity<String> songAdded(@RequestParam String email, @RequestParam String songTitle) {
        service.sendSongAdded(email, songTitle);
        return ResponseEntity.ok("Song added mail sent");
    }
}
