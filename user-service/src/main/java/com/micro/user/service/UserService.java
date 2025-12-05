package com.micro.user.service;
import com.micro.user.entity.User;
import com.micro.user.repository.UserRepository;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;

@Service
public class UserService {

    private final UserRepository repo;
    private final RestTemplate restTemplate;
    private final String mailServiceUrl;


    public UserService(UserRepository repo, RestTemplate restTemplate, @Value("${MAIL_SERVICE_URL:http://localhost:8084}") String mailServiceUrl) {
        this.repo = repo;
        this.restTemplate = restTemplate;
        this.mailServiceUrl = mailServiceUrl;
    }

    public User addUser(User user) {
        User saved = repo.save(user);
        sendUserCreatedMail(saved);
        return saved;
    }

    public void deleteUser(Integer id) {
        repo.deleteById(id);
    }

    public User getUserById(Integer id) {
        return repo.findById(id).orElse(null);
    }

    public User login(String username, String password) {
        User user = repo.findByUsername(username);
        if (user != null && user.getPassword().equals(password)) {
            return user;
        }
        return null;
    }

    public User updateUser(Integer id, User newData) {
        return repo.findById(id).map(existing -> {
            existing.setFirstName(newData.getFirstName());
            existing.setLastName(newData.getLastName());
            existing.setUsername(newData.getUsername());
            existing.setPassword(newData.getPassword());
            existing.setEmail(newData.getEmail());
            existing.setMobile(newData.getMobile());
            existing.setCity(newData.getCity());
            existing.setState(newData.getState());
            existing.setCountry(newData.getCountry());
            return repo.save(existing);
        }).orElse(null);
    }

    public List<User> listUsers() {
        return repo.findAll();
    }

    private void sendUserCreatedMail(User user) {
        try {
            if (user.getEmail() == null || user.getEmail().isEmpty()) return;

            String email = user.getEmail();              
            String username = user.getUsername() == null ? "" : user.getUsername();
            String encodedUsername = username.replace(" ", "%20"); 

            String url = mailServiceUrl
                    + "/mail/user/account-created?email=" + email
                    + "&username=" + encodedUsername;

            restTemplate.postForEntity(url, null, String.class);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }


}
