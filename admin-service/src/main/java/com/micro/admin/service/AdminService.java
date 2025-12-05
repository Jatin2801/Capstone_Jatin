package com.micro.admin.service;

import com.micro.admin.entity.Admin;
import com.micro.admin.repository.AdminRepository;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;

@Service
public class AdminService {

    private final AdminRepository repo;
    private final RestTemplate restTemplate;
    private final String mailServiceUrl;

    public AdminService(AdminRepository repo, RestTemplate restTemplate, @Value("${MAIL_SERVICE_URL:http://localhost:8084}") String mailServiceUrl) {
        this.repo = repo;
        this.restTemplate = restTemplate;
        this.mailServiceUrl = mailServiceUrl;
    }

    public Admin login(String username, String password) {
        Admin admin = repo.findByUsername(username);
        if (admin != null && admin.getPassword().equals(password)) {
            return admin;
        }
        return null;
    }

    public Admin addAdmin(Admin admin) {
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
            existing.setPassword(newData.getPassword());
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
            String email = admin.getEmail();
            String name = admin.getAdminName() == null ? "" : admin.getAdminName();
            String encodedName = URLEncoder.encode(name, StandardCharsets.UTF_8);
            String url = mailServiceUrl + "/mail/admin/account-created?email=" + email + "&adminName=" + encodedName;
            restTemplate.postForEntity(url, null, String.class);
        } catch (Exception e) {
        }
    }
}
