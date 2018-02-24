package com.landai.form;

import com.landai.form.model.Component;
import com.landai.form.service.ComponentService;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.ArrayList;
import java.util.List;

/**
 * @author <a href="mailto:huangjiang1026@gmail.com">H.J</a> on 2018/2/9 17:00
 */
public class ComponentServiceTest extends FormApplicationTests {

    @Autowired
    ComponentService componentService;

    @Test
    public void batchUpdateComponent() {
        List<Component> componentList = new ArrayList<>();
        Component component1 = new Component();
        component1.setId(1L);
        component1.setName("hAVnbM");
        component1.setOrders((short) 2);
        componentList.add(component1);

        Component component2 = new Component();
        component2.setId(2L);
        component2.setName("OWCHwz");
        component2.setOrders((short) 3);
        componentList.add(component2);

        Component component3 = new Component();
        component3.setId(3L);
        component3.setName("KWAEEd");
        component3.setOrders((short) 1);
        componentList.add(component3);

        componentService.batchSaveComponent(componentList);
    }
}
