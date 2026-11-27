package com.example.CookingDaddy.User;

import java.util.Optional;

public interface UserRepository {
    void store(User user) throws Exception;
    Optional<User> findByUsername(String username);
} 
