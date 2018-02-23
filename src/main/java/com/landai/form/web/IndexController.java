package com.landai.form.web;

import com.landai.form.service.FormService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class IndexController {

    @Autowired
    private FormService formService;

    @RequestMapping("/")
    public String index(Model model) {
        model.addAttribute("forms", formService.getTemplateForms());
        return "index";
    }
}
