package com.landai.form.web;

import com.aliyuncs.dysmsapi.model.v20170525.SendSmsResponse;
import com.aliyuncs.exceptions.ClientException;
import com.landai.form.model.Authority;
import com.landai.form.model.Status;
import com.landai.form.model.SystemRole;
import com.landai.form.model.User;
import com.landai.form.repository.AuthorityRepository;
import com.landai.form.service.UniqueIDService;
import com.landai.form.service.UserService;
import com.landai.form.utils.SmsUtil;
import com.landai.form.utils.VerifyCodeUtils;
import org.apache.commons.lang3.RandomStringUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.encoding.Md5PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@Controller
public class UserController {

    @Autowired
    private UserService userService;
    @Autowired
    private UniqueIDService uniqueIDService;
    @Autowired
    private AuthorityRepository authorityRepository;

    @RequestMapping("/loginError")
    public String loginError(Model model) {
        model.addAttribute("error", "invalidate telephone or password");
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

    @GetMapping("/anon/signUpSuccess")
    public String signUpSuccess() {
        return "signUpSuccess";
    }

    @PostMapping("/anon/checkTelephone")
    @ResponseBody
    public String checkTelephone(@RequestParam("telephone") String telephone) {
        if (userService.getUserByTelephone(telephone) == null)
            return "true";
        else
            return "false";
    }

    @PostMapping("/signUp")
    public String postSignUp(@ModelAttribute User user, HttpSession session) {
        String phoneCode = (String) session.getAttribute("phoneCode");
        String verifyCode = (String) session.getAttribute("verifyCode");
        if (StringUtils.equals(user.getPhoneCode(), phoneCode) && StringUtils.equals(user.getVerifyCode(), verifyCode)) {
            user.setUsername(uniqueIDService.getUniqueStringID());
            user.setPassword(new Md5PasswordEncoder().encodePassword(user.getPassword(), null));
            userService.saveUser(user);
            authorityRepository.save(new Authority(user.getUsername(), SystemRole.ROLE_ADMIN.name()));
            return "redirect:/anon/signUpSuccess";
        } else {
            return "redirect:/signUp?singUpError=true";
        }
    }

    @RequestMapping("/anon/verifyCode")
    public void verifyCode(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", 0);
        response.setContentType("image/jpeg");

        //生成随机字串
        String verifyCode = VerifyCodeUtils.generateVerifyCode(4);
        //存入会话session
        HttpSession session = request.getSession(true);
        //删除以前的
        session.removeAttribute("verifyCode");
        session.setAttribute("verifyCode", verifyCode.toLowerCase());
        //生成图片
        int w = 100, h = 30;
        VerifyCodeUtils.outputImage(w, h, response.getOutputStream(), verifyCode);
    }

    @RequestMapping("/anon/phoneCode")
    @ResponseBody
    public Map<String, String> getPhoneCode(@RequestParam("telephone") String telephone,
                                            @RequestParam("verifyCode") String verifyCode,
                                            HttpSession session) {
        Map<String, String> result = new HashMap<>();
        if (!StringUtils.equals(verifyCode.toLowerCase(), (String) session.getAttribute("verifyCode"))) {
            result.put("success", "false");
            result.put("verifyCode", "error");
            return result;
        }
        if (StringUtils.isNotEmpty(verifyCode) && StringUtils.isNotEmpty(telephone)
                && verifyCode.toLowerCase().equals(session.getAttribute("verifyCode"))) {
            try {
                String phoneCode = RandomStringUtils.randomNumeric(6);
                SendSmsResponse response = SmsUtil.sendSms(telephone, phoneCode);
                result.put("code", response.getCode());
                session.removeAttribute("phoneCode");
                session.setAttribute("phoneCode", phoneCode);
            } catch (ClientException e) {
                e.printStackTrace();
                result.put("success", "false");
            }
        }
        result.put("success", "true");
        return result;
    }

}
