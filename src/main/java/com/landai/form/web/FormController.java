package com.landai.form.web;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.landai.form.model.*;
import com.landai.form.service.*;
import org.apache.commons.lang3.RandomStringUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class FormController {

    @Autowired
    FormService formService;
    @Autowired
    RenderControlService renderControlService;
    @Autowired
    ComponentPrototypeService componentPrototypeService;
    @Autowired
    ComponentService componentService;
    @Autowired
    ControlService controlService;

    private ObjectMapper objectMapper = new ObjectMapper();

    @GetMapping("/f/{formId}")
    public String formIndex(@PathVariable("formId") String formId, Model model) {
        model.addAttribute("components", componentService.getComponents(formId));
        return "form";
    }

    @GetMapping("/form/{formId}/getComponent")
    @ResponseBody
    public String buildControl(@PathVariable("formId") String formId,
                               @RequestParam("componentName") String componentName) {
        Form form = formService.getForm(formId);
        ComponentPrototype cp = componentPrototypeService.getComponentPrototype(componentName);
        Component component = new Component();
        component.setForm(form);
        component.setLabel(cp.getLabel());
        component.setName(RandomStringUtils.randomAlphabetic(6));
        component.setData(cp.getData());
        component.setValidateRules(cp.getValidateRules());
        component.setViewPage(cp.getViewPage());
        component.setEditPage(cp.getEditPage());
        component.setType(cp.getType());
        componentService.saveComponent(component);
        List<ComponentControl> componentControls = cp.getControls();
        List<Control> controls = new ArrayList<>();
        if (componentControls != null && !componentControls.isEmpty()) {
            for (ComponentControl componentControl : componentControls) {
                Control control = new Control();
                control.setComponentId(component.getId());
                control.setFormId(formId);
                control.setLabel(componentControl.getControlLabel());
                control.setName(componentControl.getControlName() + component.getId());
                controls.add(control);
            }
        } else {
            Control control = new Control();
            control.setComponentId(component.getId());
            control.setFormId(formId);
            control.setLabel(component.getLabel());
            control.setName(component.getName());
            controls.add(control);
        }
        controlService.save(controls);
        return renderControlService.getRenderHtml(component.getViewPage(), component);
    }

    @PostMapping("/form/{formId}/deleteComponent")
    @ResponseBody
    public Status deleteControl(@RequestParam("componentId") Long componentId) {
        componentService.deleteComponent(componentId);
        return Status.SUCCESS;
    }

    @GetMapping("/builder/{formId}")
    public String formBuilder(@PathVariable("formId") String formId, Model model) {
        model.addAttribute("components", componentPrototypeService.getAllComponentPrototypes());
        return "formBuilder";
    }

    @GetMapping("/form/{formId}")
    @ResponseBody
    public String getForm(@PathVariable("formId") String formId) {
        List<Component> components = componentService.getComponents(formId);
        StringBuilder fragment = new StringBuilder();
        for (Component component : components) {
            fragment.append(component.getHtml());
        }
        return fragment.toString();
    }

    @RequestMapping("/form/{formId}/componentEdit/{componentId}")
    @ResponseBody
    public String componentEdit(@PathVariable("formId") String formId,
                                @PathVariable("componentId") Long componentId) {
        Component component = componentService.getComponent(componentId);
        return renderControlService.getRenderHtml(component.getEditPage(), component);
    }

    @PostMapping("/form/{formId}/component/{componentId}")
    @ResponseBody
    public Status postComponent(@PathVariable("componentId") Long componentId,
                                @RequestParam(value = "label", required = false) String label,
                                @RequestParam(value = "description", required = false) String description) {
        Component component = componentService.getComponent(componentId);
        if (StringUtils.isNotEmpty(label))
            component.setLabel(label);
        if (description != null)
            component.setDescription(description);
        componentService.saveComponent(component);
        return Status.SUCCESS;
    }

    @PostMapping("/form/{formId}/component/{componentId}/rules")
    @ResponseBody
    public Status postRules(@PathVariable("componentId") Long componentId,
                            @RequestParam("rules") String rules) {
        Component component = componentService.getComponent(componentId);
        component.setValidateRules(rules);
        componentService.saveComponent(component);
        return Status.SUCCESS;
    }

    @PostMapping("/form/{formId}/componentData/{componentId}")
    @ResponseBody
    public Status saveControlData(@PathVariable("formId") String formId,
                                  @PathVariable("componentId") Long componentId,
                                  @RequestParam("value") String value) {
        Component component = componentService.getComponent(componentId);
        String data = component.getData();
        List<String> dataList = new ArrayList<>();
        try {
            if (StringUtils.isEmpty(data)) {
                dataList.add(value);
                component.setData(objectMapper.writeValueAsString(dataList));
            } else {
                dataList = objectMapper.readValue(data, List.class);
                dataList.add(value);
            }
            component.setData(objectMapper.writeValueAsString(dataList));
        } catch (IOException e) {
            e.printStackTrace();
        }
        componentService.saveComponent(component);
        return Status.SUCCESS;
    }

    @PostMapping("/form/{formId}/delComponentData/{componentId}")
    @ResponseBody
    public Status deleteComponentData(@PathVariable("formId") String formId,
                                      @PathVariable("componentId") Long componentId,
                                      @RequestParam("value") String value) {
        Component component = componentService.getComponent(componentId);
        String data = component.getData();
        List<String> dataList = new ArrayList<>();
        try {
            dataList = objectMapper.readValue(data, List.class);
            dataList.remove(value);
            component.setData(objectMapper.writeValueAsString(dataList));
        } catch (IOException e) {
            e.printStackTrace();
        }
        componentService.saveComponent(component);
        return Status.SUCCESS;
    }

    @GetMapping("/form/new")
    public String newForm() {
        return "newForm";
    }

    @PostMapping("/form/new")
    public String postForm(@ModelAttribute Form form) {
        if (StringUtils.isEmpty(form.getId())) {
            form.setId(RandomStringUtils.randomAlphanumeric(6));
        }
        formService.saveForm(form);
        return "redirect:/builder/" + form.getId();
    }

    @PostMapping("/f/{formId}")
    @ResponseBody
    public Map<String, String> formSubmit(@PathVariable("formId") String formId,
                                          @RequestParam("formValue") String formValue) {
        Form form = formService.getForm(formId);
        FormValue fv = new FormValue();
        fv.setForm(form);
        fv.setFormValue(formValue);
        formService.saveFormValue(fv);
        Map<String, String> status = new HashMap<>();
        status.put("redirectUrl", "/f/submitSuccess");
        return status;
    }

    @GetMapping("/f/submitSuccess")
    public String submitSuccess() {
        return "submitSuccess";
    }

    @GetMapping("/form/{formId}/data")
    public String formData(@PathVariable("formId") String formId, Model model) {
        model.addAttribute("controls", controlService.getControlsByFormId(formId));
        List<FormValue> formValues = formService.getAllFormValue(formId);
        List<Map> values = new ArrayList<>();
        try {
            for (FormValue fv : formValues) {
                values.add(objectMapper.readValue(fv.getFormValue(), Map.class));
            }
            model.addAttribute("data", objectMapper.writeValueAsString(values));
        } catch (IOException e) {
            e.printStackTrace();
        }
        return "formData";
    }
}
