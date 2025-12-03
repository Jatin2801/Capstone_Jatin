package com.micro.user.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.micro.user.entity.User;

public interface UserRepository extends JpaRepository<User, Integer> {
    User findByUsername(String username);
    void deleteById(Integer id);
}
