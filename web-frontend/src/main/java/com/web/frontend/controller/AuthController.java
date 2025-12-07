package com.web.frontend.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.springframework.ui.Model;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.http.HttpStatus;
import jakarta.servlet.http.HttpSession;
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

    @PostMapping("/admin/login")
    public String adminLogin(@RequestParam String username,
                             @RequestParam String password,
                             Model model, HttpSession session) {

        Map<String, String> body = new HashMap<>();
        body.put("username", username);
        body.put("password", password);

        try {
            Map<?, ?> admin = restTemplate.postForObject(adminUrl + "/admin/login", body, Map.class);
            if (admin == null) {
                model.addAttribute("error", "Check username or password");
                return "login";
            }
            session.setAttribute("admin", admin);
            return "admin-dashboard";
        } catch (HttpClientErrorException e) {
            model.addAttribute("error", "Check username or password");
            return "login";
        } catch (Exception e) {
            model.addAttribute("error", "Check username or password");
            return "login";
        }
    }

    @GetMapping("/user-dashboard")
    public String userDashboard(HttpSession session, Model model) {
        Object user = session.getAttribute("user");
        if (user == null) {
            return "login";
        }
        model.addAttribute("user", user);
        return "user-dashboard";
    }

    @PostMapping("/user/login")
    public String userLogin(@RequestParam String username,
                            @RequestParam String password,
                            Model model, HttpSession session) {

        Map<String, String> body = new HashMap<>();
        body.put("username", username);
        body.put("password", password);

        try {
            Map<?, ?> user = restTemplate.postForObject(userUrl + "/users/login", body, Map.class);
            if (user == null) {
                model.addAttribute("error", "Check username or password");
                return "login";
            }
            session.setAttribute("user", user);
            return "user-dashboard";
        } catch (HttpClientErrorException e) {
            model.addAttribute("error", "Check username or password");
            return "login";
        } catch (Exception e) {
            model.addAttribute("error", "Check username or password");
            return "login";
        }
    }

    @PostMapping("/admin/add")
    public String addAdmin(@RequestParam Map<String, String> params, Model model) {
        try {
            restTemplate.postForObject(adminUrl + "/admin/add", params, Object.class);
            model.addAttribute("msg", "Admin Added Successfully");
            return "login";
        } catch (Exception e) {
            model.addAttribute("error", "Admin Not Added");
            return "register";
        }
    }

    @GetMapping("/admin/update-page")
    public String loadAdminUpdatePage(@RequestParam Integer id, Model model) {
        Object admin = restTemplate.getForObject(adminUrl + "/admin/" + id, Object.class);
        model.addAttribute("admin", admin);
        return "update-admin";
    }

    @PostMapping("/admin/update")
    public String updateAdmin(@RequestParam Map<String, String> params) {
        Integer id = Integer.parseInt(params.get("adminId"));
        restTemplate.put(adminUrl + "/admin/update/" + id, params);
        return "admin-dashboard";
    }

    @PostMapping("/admin/deleteAccount")
    public String deleteAdmin(@RequestParam Integer adminId, Model model) {
        try {
            restTemplate.delete(adminUrl + "/admin/delete/" + adminId);
            model.addAttribute("msg", "Admin account deleted");
            return "login";
        } catch (Exception e) {
            model.addAttribute("error", "Could not delete admin");
            return "admin-dashboard";
        }
    }

    @PostMapping("/user/add")
    public String addUser(@RequestParam Map<String, String> params, Model model) {
        try {
            restTemplate.postForObject(userUrl + "/users/add", params, Object.class);
            model.addAttribute("msg", "User Added Successfully");
            return "login";
        } catch (Exception e) {
            model.addAttribute("error", "User Not Added");
            return "register";
        }
    }

    @GetMapping("/user/update-page")
    public String loadUserUpdatePage(@RequestParam Integer id, Model model) {
        Object user = restTemplate.getForObject(userUrl + "/users/" + id, Object.class);
        model.addAttribute("user", user);
        return "update-user";
    }

    @PostMapping("/user/update")
    public String updateUser(@RequestParam Map<String, String> params) {
        Integer id = Integer.parseInt(params.get("userId"));
        restTemplate.put(userUrl + "/users/update/" + id, params);
        return "user-dashboard";
    }

    @PostMapping("/user/deleteAccount")
    public String deleteUser(@RequestParam Integer userId, Model model) {
        try {
            restTemplate.delete(userUrl + "/users/delete/" + userId);
            model.addAttribute("msg", "User account deleted");
            return "login";
        } catch (Exception e) {
            model.addAttribute("error", "Could not delete user");
            return "user-dashboard";
        }
    }
}
