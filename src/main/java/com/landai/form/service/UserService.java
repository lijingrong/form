package com.landai.form.service;

import com.landai.form.model.User;
import com.landai.form.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    public void saveUser(User user) {
        userRepository.save(user);
    }

    public User getUser(String username) {
        return userRepository.getOne(username);
    }
}
