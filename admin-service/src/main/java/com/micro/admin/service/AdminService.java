package com.micro.admin.service;

import com.micro.admin.entity.Admin;
import com.micro.admin.repository.AdminRepository;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class AdminService {

    private final AdminRepository repo;
    private final RestTemplate restTemplate;
    private final PasswordEncoder passwordEncoder;
    private final String mailServiceUrl;

    public AdminService(AdminRepository repo,
                        RestTemplate restTemplate,
                        PasswordEncoder passwordEncoder,
                        @Value("${MAIL_SERVICE_URL:http://localhost:8084}") String mailServiceUrl) {
        this.repo = repo;
        this.restTemplate = restTemplate;
        this.passwordEncoder = passwordEncoder;
        this.mailServiceUrl = mailServiceUrl;
    }

    public Admin login(String username, String password) {
        Admin admin = repo.findByUsername(username);
        if (admin == null) {
            return null;
        }
        return passwordEncoder.matches(password, admin.getPassword()) ? admin : null;
    }

    public Admin addAdmin(Admin admin) {
        admin.setPassword(passwordEncoder.encode(admin.getPassword()));
        Admin saved = repo.save(admin);
        sendAdminCreatedMail(saved);
        return saved;
    }

    public Admin getAdminById(Integer id) {
        return repo.findById(id).orElse(null);
    }

    public List<Admin> getAllAdmins() {
        return repo.findAll();
    }

    public Admin updateAdmin(Integer id, Admin newData) {
        return repo.findById(id).map(existing -> {
            existing.setAdminName(newData.getAdminName());
            existing.setUsername(newData.getUsername());
            existing.setEmail(newData.getEmail());
            existing.setMobileNo(newData.getMobileNo());
            return repo.save(existing);
        }).orElse(null);
    }

    public void deleteAdmin(Integer id) {
        repo.deleteById(id);
    }

    private void sendAdminCreatedMail(Admin admin) {
        try {
            if (admin.getEmail() == null || admin.getEmail().isEmpty()) {
                return;
            }

            Map<String, String> body = new HashMap<>();
            body.put("email", admin.getEmail());
            body.put("adminName", admin.getAdminName());

            restTemplate.postForEntity(
                    mailServiceUrl + "/mail/admin/account-created",
                    body,
                    String.class
            );

            System.out.println("ADMIN MAIL SENT → " + admin.getEmail());
        } catch (Exception e) {
            System.err.println("ADMIN MAIL ERROR: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
