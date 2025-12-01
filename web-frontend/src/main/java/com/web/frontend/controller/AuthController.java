package com.web.frontend.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.springframework.ui.Model;

import java.util.HashMap;
import java.util.Map;

@Controller
public class AuthController {

    private final RestTemplate restTemplate;

    @Value("${ADMIN_SERVICE_URL}")
    private String adminUrl;

    @Value("${USER_SERVICE_URL}")
    private String userUrl;

    public AuthController(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

    // ADMIN LOGIN 
    @PostMapping("/admin/login")
    public String adminLogin(@RequestParam String username, @RequestParam String password, Model model) {

        Map<String, String> body = new HashMap<>();
        body.put("username", username);
        body.put("password", password);

        try {
            var response = restTemplate.postForObject(adminUrl + "/admin/login", body, Object.class);
            model.addAttribute("admin", response);
            return "admin-dashboard";
        } catch (Exception e) {
            model.addAttribute("error", "Invalid Admin Login");
            return "login";
        }
    }

    // USER LOGIN 
    @PostMapping("/user/login")
    public String userLogin(@RequestParam String username, @RequestParam String password, Model model) {

        Map<String, String> body = new HashMap<>();
        body.put("username", username);
        body.put("password", password);

        try {
            var response = restTemplate.postForObject(userUrl + "/users/login", body, Object.class);
            model.addAttribute("user", response);
            return "user-dashboard";
        } catch (Exception e) {
            model.addAttribute("error", "Invalid User Login");
            return "login";
        }
    }

    //  ADD ADMIN 
    @PostMapping("/admin/add")
    public String addAdmin(@RequestParam Map<String, String> params, Model model) {

        try {
            var response = restTemplate.postForObject(adminUrl + "/admin/add", params, Object.class);
            model.addAttribute("msg", "Admin Added Successfully");
            return "register";
        } catch (Exception e) {
            model.addAttribute("error", "Admin Not Added");
            return "register";
        }
    }

    // ADD USER 
    @PostMapping("/user/add")
    public String addUser(@RequestParam Map<String, String> params, Model model) {

        try {
            var response = restTemplate.postForObject(userUrl + "/users/add", params, Object.class);
            model.addAttribute("msg", "User Added Successfully");
            return "register";
        } catch (Exception e) {
            model.addAttribute("error", "User Not Added");
            return "register";
        }
    }
}
