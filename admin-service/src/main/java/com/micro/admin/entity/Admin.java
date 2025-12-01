package com.micro.admin.entity;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Data
public class Admin {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer adminId;

    private String adminName;

    @Column(unique = true)
    private String username;

    private String password;
    private String email;
    private String mobileNo;

    @Enumerated(EnumType.STRING)
    private AdminStatus adminStatus;

    public enum AdminStatus { YES, NO }
}
