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
    
    public void deleteUser(Integer id) {
        repo.deleteById(id);
    }

    public User getUserById(Integer id) {
        return repo.findById(id).orElse(null);
    }

    
    public User login(String username, String password){
        User u = repo.findByUsername(username);
        if(u != null && u.getPassword().equals(password))
            return u;

        return null;
    }
    
    public User updateUser(Integer id, User newData) {
        return repo.findById(id).map(existing -> {
            existing.setFirstName(newData.getFirstName());
            existing.setLastName(newData.getLastName());
            existing.setUsername(newData.getUsername());
            existing.setPassword(newData.getPassword());
            existing.setEmail(newData.getEmail());
            existing.setMobile(newData.getMobile());
            existing.setCity(newData.getCity());
            existing.setState(newData.getState());
            existing.setCountry(newData.getCountry());
            return repo.save(existing);
        }).orElse(null);
    }


    public java.util.List<User> listUsers(){
        return repo.findAll();
    }
}