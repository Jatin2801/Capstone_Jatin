package com.micro.admin.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.micro.admin.entity.Admin;

public interface AdminRepository extends JpaRepository<Admin, Integer> {
    Admin findByUsername(String username);
    
    void deleteById(Integer adminId);

}
