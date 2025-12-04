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
        if(updated == null)
            return ResponseEntity.status(404).body("User not found");
        return ResponseEntity.ok(updated);
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