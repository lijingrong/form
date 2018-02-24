package com.landai.form.web;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.type.CollectionType;
import com.landai.form.model.*;
import com.landai.form.service.*;
import com.landai.form.utils.CurrentUserUtil;
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
        model.addAttribute("form", formService.getForm(formId));
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
        model.addAttribute("commonComponents", componentPrototypeService.getComponentPrototypesByIsCommon(true));
        model.addAttribute("customComponents", componentPrototypeService.getComponentPrototypesByIsCommon(false));
        model.addAttribute("form", formService.getForm(formId));
        return "formBuilder";
    }

    @GetMapping("/form/{formId}/skin")
    public String formSkin(@PathVariable("formId") String formId, Model model) {
        model.addAttribute("form", formService.getForm(formId));
        return "formSkin";
    }

    @GetMapping("/form/{formId}/publish")
    public String formPublish(@PathVariable("formId") String formId, Model model) {
        model.addAttribute("form", formService.getForm(formId));
        return "formPublish";
    }

    @PostMapping("/form/{formId}/publish")
    @ResponseBody
    public Status postFormPublish(@PathVariable("formId") String formId,
                                  @RequestParam("afterPostDesc") String afterPostDesc) {
        Form form = formService.getForm(formId);
        form.setStatus(FormStatus.PUBLISHED);
        form.setAfterPostDesc(afterPostDesc);
        formService.saveForm(form);
        return Status.SUCCESS;
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

    @GetMapping("/form/{formId}/edit")
    @ResponseBody
    public String formEdit(@PathVariable("formId") String formId) {
        Form form = formService.getForm(formId);
        return renderControlService.getRenderHtml("formEdit.ftl", form);
    }

    @PostMapping("/form/{formId}/edit")
    @ResponseBody
    public Status postFormEdit(@PathVariable("formId") String formId,
                               @RequestParam("title") String title,
                               @RequestParam("description") String description) {
        Form form = formService.getForm(formId);
        form.setTitle(title);
        form.setDescription(description);
        formService.saveForm(form);
        return Status.SUCCESS;
    }

    @PostMapping("/form/{formId}/save")
    @ResponseBody
    public Status postFormSave(@PathVariable("formId") String formId,
                               @RequestParam("components") String components) {
        try {
            CollectionType javaType = objectMapper.getTypeFactory().constructCollectionType(List.class, Component.class);
            List<Component> comps = objectMapper.readValue(components, javaType);
            List<Component> componentList = componentService.getComponents(formId);
            for (Component component : componentList) {
                for (Component comp : comps) {
                    if (comp.getId() == component.getId().longValue()) {
                        component.setOrders(comp.getOrders());
                        break;
                    }
                }
            }
            componentService.batchSaveComponent(componentList);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return Status.SUCCESS;
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

    @RequestMapping("/form/new")
    public String newForm() {
        Form form = new Form();
        form.setId(RandomStringUtils.randomAlphanumeric(6));
        form.setUser(CurrentUserUtil.getUser());
        form.setTitle("表单名称");
        form.setDescription("<p>表单描述</p>");
        formService.saveForm(form);
        return "redirect:/builder/" + form.getId();

    }

    @GetMapping("/form/list")
    public String formList(Model model) {
        model.addAttribute("forms", formService.getFormsByCreator(CurrentUserUtil.getUser().getUsername()));
        return "userForms";
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
        status.put("redirectUrl", "/f/" + formId + "/submitSuccess");
        return status;
    }

    @GetMapping("/f/{formId}/submitSuccess")
    public String submitSuccess(@PathVariable("formId") String formId, Model model) {
        model.addAttribute("form", formService.getForm(formId));
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
