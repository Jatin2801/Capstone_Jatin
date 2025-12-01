package com.micro.user.entity;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "users")
@Data
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer userId;

    private String firstName;
    private String lastName;

    @Column(unique = true)
    private String username;

    private String password;
    private String email;
    private String mobile;

 
    private String city;
    private String state;
    private String country;
  
}
