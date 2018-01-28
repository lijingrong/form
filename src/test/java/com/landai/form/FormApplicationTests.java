package com.landai.form;

import com.landai.form.service.RenderControlService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.HashMap;
import java.util.Map;

@RunWith(SpringRunner.class)
@SpringBootTest
public class FormApplicationTests {

    @Test
    public void contextLoads() {
        RenderControlService renderControlTemplate = new RenderControlService();
        Map data = new HashMap();
        data.put("name", "telephone");
        data.put("label", "姓名");
        System.out.println(renderControlTemplate.getRenderHtml("text.ftlh", data));
    }

}
