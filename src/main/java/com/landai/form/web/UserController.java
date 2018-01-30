package com.landai.form.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class UserController {

    @RequestMapping("/signin")
    public String signin(){
        return "signin";
    }
}
