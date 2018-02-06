package com.landai.form.web;

import com.landai.form.model.User;
import com.landai.form.service.UniqueIDService;
import com.landai.form.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.encoding.Md5PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class UserController {

    @Autowired
    private UserService userService;
    @Autowired
    private UniqueIDService uniqueIDService;

    @RequestMapping("/loginError")
    public String loginError(Model model){
        model.addAttribute("error","invalidate telephone or password");
        return "signIn";
    }

    @RequestMapping("/login")
    public String signIn() {
        return "signIn";
    }

    @GetMapping("/signUp")
    public String signUp() {
        return "signUp";
    }

    @PostMapping("/signUp")
    public String postSignUp(@ModelAttribute User user) {
        user.setUsername(uniqueIDService.getUniqueStringID());
        user.setPassword(new Md5PasswordEncoder().encodePassword(user.getPassword(), null));
        userService.saveUser(user);
        return "redirect:/login";
    }

}
