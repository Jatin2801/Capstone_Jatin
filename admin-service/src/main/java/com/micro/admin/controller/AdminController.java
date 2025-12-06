package com.micro.admin.controller;

import com.micro.admin.entity.Admin;
import com.micro.admin.security.JwtUtil;
import com.micro.admin.service.AdminService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

import jakarta.servlet.http.HttpServletRequest;

@RestController
@RequestMapping("/admin")
public class AdminController {

    private final AdminService service;
    private final JwtUtil jwtUtil;
    private final HttpServletRequest request;

    public AdminController(AdminService service, JwtUtil jwtUtil, HttpServletRequest request) {
        this.service = service;
        this.jwtUtil = jwtUtil;
        this.request = request;
    }

    @PostMapping("/add")
    public Admin addAdmin(@RequestBody Admin admin) {
        return service.addAdmin(admin);
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity<String> deleteAdmin(@PathVariable Integer id) {
        service.deleteAdmin(id);
        return ResponseEntity.ok("Admin deleted");
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getAdminById(@PathVariable Integer id) {
        Admin admin = service.getAdminById(id);
        return admin == null ?
                ResponseEntity.status(404).body("Admin not found") :
                ResponseEntity.ok(admin);
    }

    @PutMapping("/update/{id}")
    public ResponseEntity<?> updateAdmin(@PathVariable Integer id, @RequestBody Admin req) {
        Admin updated = service.updateAdmin(id, req);
        if (updated == null) return ResponseEntity.status(404).body("Admin not found");
        return ResponseEntity.ok(updated);
    }

    // JSON Login
    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody Admin req) {
        Admin a = service.login(req.getUsername(), req.getPassword());
        if (a == null) return ResponseEntity.status(401).body("Invalid Login");
        String token = jwtUtil.generateToken(a.getUsername(), Map.of("adminId", a.getAdminId()));
        return ResponseEntity.ok().header("Authorization","Bearer "+token).body(a);
    }

    // 🟢 JSP FORM LOGIN ENDPOINT
    @PostMapping(value="/form-login", consumes="application/x-www-form-urlencoded")
    public ResponseEntity<?> loginForm(@RequestParam String username, @RequestParam String password){
        Admin a = service.login(username,password);
        if(a==null) return ResponseEntity.status(401).body("Invalid Admin Login");
        String token = jwtUtil.generateToken(a.getUsername(),Map.of("adminId", a.getAdminId()));
        request.getSession().setAttribute("AuthToken",token);
        return ResponseEntity.status(302).header("Location","/admin/home").build();
    }
}
