package com.micro.user.controller;

import com.micro.user.entity.User;
import com.micro.user.security.JwtUtil;
import com.micro.user.service.UserService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/users")
public class UserController {

    private final UserService service;
    private final JwtUtil jwtUtil;

    public UserController(UserService service, JwtUtil jwtUtil) {
        this.service = service;
        this.jwtUtil = jwtUtil;
    }

    @PostMapping("/add")
    public User add(@RequestBody User u) {
        return service.addUser(u);
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getUserById(@PathVariable Integer id) {
        User user = service.getUserById(id);
        return user == null ?
                ResponseEntity.status(404).body("User not found") :
                ResponseEntity.ok(user);
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity<String> deleteUser(@PathVariable Integer id) {
        service.deleteUser(id);
        return ResponseEntity.ok("User deleted");
    }

    @PutMapping("/update/{id}")
    public ResponseEntity<?> updateUser(@PathVariable Integer id, @RequestBody User req) {
        User updated = service.updateUser(id, req);
        if (updated == null) {
            return ResponseEntity.status(404).body("User not found");
        }
        return ResponseEntity.ok(updated);
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody User req) {
        User u = service.login(req.getUsername(), req.getPassword());
        if (u == null) {
            return ResponseEntity.status(401).body("Invalid login");
        }
        String token = jwtUtil.generateToken(
                u.getUsername(),
                Map.of("userId", u.getUserId())
        );
        return ResponseEntity
                .ok()
                .header("Authorization", "Bearer " + token)
                .body(u);
    }

    @GetMapping("/all")
    public java.util.List<User> list() {
        return service.listUsers();
    }
}