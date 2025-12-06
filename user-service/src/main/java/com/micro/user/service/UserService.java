package com.micro.user.service;

import com.micro.user.entity.User;
import com.micro.user.repository.UserRepository;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class UserService {

    private final UserRepository repo;
    private final RestTemplate restTemplate;
    private final PasswordEncoder passwordEncoder;
    private final String mailServiceUrl;

    public UserService(UserRepository repo,
                       RestTemplate restTemplate,
                       PasswordEncoder passwordEncoder,
                       @Value("${MAIL_SERVICE_URL:http://localhost:8084}") String mailServiceUrl) {
        this.repo = repo;
        this.restTemplate = restTemplate;
        this.passwordEncoder = passwordEncoder;
        this.mailServiceUrl = mailServiceUrl;
    }

    public User addUser(User user) {
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        User saved = repo.save(user);
        sendUserCreatedMail(saved);
        return saved;
    }

    public List<User> listUsers() {
        return repo.findAll();
    }

    public User getUserById(Integer id) {
        return repo.findById(id).orElse(null);
    }

    public void deleteUser(Integer id) {
        repo.deleteById(id);
    }

    public User updateUser(Integer id, User newData) {
        return repo.findById(id).map(old -> {
            old.setFirstName(newData.getFirstName());
            old.setLastName(newData.getLastName());
            old.setUsername(newData.getUsername());
            if (newData.getPassword() != null && !newData.getPassword().isBlank()) {
                old.setPassword(passwordEncoder.encode(newData.getPassword()));
            }
            old.setEmail(newData.getEmail());
            old.setMobile(newData.getMobile());
            old.setCity(newData.getCity());
            old.setState(newData.getState());
            old.setCountry(newData.getCountry());
            return repo.save(old);
        }).orElse(null);
    }

    public User login(String username, String password) {
        User u = repo.findByUsername(username);
        if (u == null) {
            return null;
        }
        return passwordEncoder.matches(password, u.getPassword()) ? u : null;
    }

    private void sendUserCreatedMail(User u) {
        try {
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);

            Map<String, String> body = new HashMap<>();
            body.put("email", u.getEmail());
            body.put("username", u.getUsername());

            HttpEntity<Map<String, String>> entity = new HttpEntity<>(body, headers);

            restTemplate.postForEntity(
                    mailServiceUrl + "/mail/user/account-created",
                    entity,
                    String.class
            );

            System.out.println("MAIL SENT → USER CREATED → " + u.getEmail());
        } catch (Exception e) {
            System.out.println("MAIL FAILED");
            e.printStackTrace();
        }
    }
}
