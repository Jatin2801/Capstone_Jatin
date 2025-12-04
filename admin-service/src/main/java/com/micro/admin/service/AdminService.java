package com.micro.admin.service;

import org.springframework.stereotype.Service;
import com.micro.admin.entity.Admin;
import com.micro.admin.repository.AdminRepository;

@Service
public class AdminService {

    private final AdminRepository repo;

    public AdminService(AdminRepository repo) {
        this.repo = repo;
    }

    public Admin login(String username, String password){
        Admin admin = repo.findByUsername(username);
        if(admin != null && admin.getPassword().equals(password))
            return admin;

        return null;
    }
    
    public Admin addAdmin(Admin admin) {
        return repo.save(admin);
    }
    
    public Admin getAdminById(Integer id) {
        return repo.findById(id).orElse(null);
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

    
    public void deleteAdmin(Integer adminId) {
        repo.deleteById(adminId);
    }
}