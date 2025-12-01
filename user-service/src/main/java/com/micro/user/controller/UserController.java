package com.micro.user.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import com.micro.user.entity.User;
import com.micro.user.service.UserService;

@RestController
@RequestMapping("/users")
public class UserController {

    private final UserService service;

    public UserController(UserService service){
        this.service = service;
    }

    @PostMapping("/add")
    public User add(@RequestBody User u){
        return service.addUser(u);
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody User req){
        User u = service.login(req.getUsername(), req.getPassword());
        return u == null ? ResponseEntity.status(401).body("Invalid login") : ResponseEntity.ok(u);
    }

    @GetMapping("/all")
    public java.util.List<User> list(){
        return service.listUsers();
    }
}
