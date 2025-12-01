package com.micro.user.service;

import org.springframework.stereotype.Service;
import com.micro.user.entity.User;
import com.micro.user.repository.UserRepository;

@Service
public class UserService {

    private final UserRepository repo;

    public UserService(UserRepository repo) {
        this.repo = repo;
    }

    public User addUser(User u){ return repo.save(u); }

    public User login(String username, String password){
        User u = repo.findByUsername(username);
        if(u != null && u.getPassword().equals(password))
            return u;

        return null;
    }

    public java.util.List<User> listUsers(){
        return repo.findAll();
    }
}
