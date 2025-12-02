package com.micro.admin.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import com.micro.admin.entity.Admin;
import com.micro.admin.service.AdminService;

@RestController
@RequestMapping("/admin")
public class AdminController {

    private final AdminService service;

    public AdminController(AdminService service) {
        this.service = service;
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
        return admin == null
                ? ResponseEntity.status(404).body("Admin not found")
                : ResponseEntity.ok(admin);
    }

    
    @PutMapping("/update/{id}")
    public ResponseEntity<?> updateAdmin(@PathVariable Integer id, @RequestBody Admin req) {
        Admin updated = service.updateAdmin(id, req);
        if(updated == null)
            return ResponseEntity.status(404).body("Admin not found");
        return ResponseEntity.ok(updated);
    }


    
    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody Admin req){
        Admin a = service.login(req.getUsername(), req.getPassword());
        return a == null ? ResponseEntity.status(401).body("Invalid Admin Login") : ResponseEntity.ok(a);
    }
}
