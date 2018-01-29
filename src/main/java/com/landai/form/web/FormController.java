package com.landai.form.web;

import com.landai.form.model.*;
import com.landai.form.service.ControlService;
import com.landai.form.service.FormService;
import com.landai.form.service.RenderControlService;
import org.apache.commons.lang3.RandomStringUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class FormController {

    @Autowired
    FormService formService;
    @Autowired
    ControlService controlService;
    @Autowired
    RenderControlService renderControlService;

    @GetMapping("/f/{formId}")
    public String formIndex(@PathVariable("formId") String formId, Model model) {
        model.addAttribute("controls", formService.getFormControls(formId));
        return "form";
    }

    @GetMapping("/form/{formId}/getControl")
    @ResponseBody
    public String buildControl(@PathVariable("formId") String formId,
                               @RequestParam(value = "type", required = false) String type,
                               @RequestParam(value = "name", required = false) String name) {
        Form form = formService.getForm(formId);
        if (!StringUtils.isEmpty(name)) {
            SimpleFormControl control = controlService.getCommonControlByName(name);
            form.getControlList().add(control);
            formService.saveForm(form);
            return renderControlService.getRenderHtml(control.getViewName(), control);
        }
        SimpleFormControl control = new SimpleFormControl();
        control.setType(type);
        control.setName(RandomStringUtils.randomAlphabetic(6));
        control.setViewName(type + ".ftl");
        control.setCommon(false);
        control.setLabel("自定义");
        form.getControlList().add(control);
        control = controlService.save(control);
        formService.saveForm(form);
        return renderControlService.getRenderHtml(control.getViewName(), control);
    }

    @PostMapping("/form/{formId}/deleteControl")
    @ResponseBody
    public Status deleteControl(@PathVariable("formId") String formId,
                                @RequestParam("controlId") Long controlId) {
        controlService.delete(formId, controlId);
        return Status.SUCCESS;
    }

    @GetMapping("/builder/{formId}")
    public String formBuilder(@PathVariable("formId") String formId) {
        return "formBuilder";
    }

    @GetMapping("/form/{formId}")
    @ResponseBody
    public String getForm(@PathVariable("formId") String formId) {
        List<SimpleFormControl> controlList = formService.getFormControls(formId);
        StringBuilder fragment = new StringBuilder();
        for (SimpleFormControl control : controlList) {
            fragment.append(control.getHtml());
        }
        return fragment.toString();
    }

    @PostMapping("/form/{formId}/addControl")
    @ResponseBody
    public Status addControl(@PathVariable("formId") String formId,
                             @ModelAttribute SimpleFormControl control) {
        Form form = formService.getForm(formId);
        form.getControlList().add(control);
        return Status.SUCCESS;
    }

    @GetMapping("/form/{formId}/controlAttribute/{controlId}")
    @ResponseBody
    public String controlAttribute(@PathVariable("formId") String formId,
                                   @PathVariable("controlId") Long controlId) {
        SimpleFormControl control = controlService.getControlById(formId, controlId);
        Map root = new HashMap();
        root.put("control", control);
        return renderControlService.getRenderHtml("controlAttribute.ftl", root);
    }

    @PostMapping("/form/{formId}/controlValidate/{controlId}")
    @ResponseBody
    public Status postControlValidate(@PathVariable("formId") String formId,
                                      @PathVariable("controlId") Long controlId,
                                      @RequestParam("ruleId") Long ruleId,
                                      @RequestParam("ruleValue") String ruleValue,
                                      @RequestParam(value = "ruleValueId", required = false) Long ruleValueId) {
        if (ruleValueId != null && StringUtils.isEmpty(ruleValue)) {
            controlService.deleteRuleValue(ruleValueId);
            return Status.SUCCESS;
        }
        RuleValue rv = new RuleValue();
        if (ruleValueId != null) {
            rv.setId(ruleValueId);
        }
        rv.setControlId(controlId);
        rv.setFormId(formId);
        rv.setRuleValue(ruleValue);
        rv.setValidateRule(controlService.getValidateRule(ruleId));
        controlService.saveValidate(rv);
        return Status.SUCCESS;
    }

    @PostMapping("/form/{formId}/controlAttribute/{controlId}")
    @ResponseBody
    public Status saveControlAttribute(@PathVariable("formId") String formId,
                                       @PathVariable("controlId") Long controlId,
                                       @RequestParam(value = "label", required = false) String label,
                                       @RequestParam(value = "ruleGroupId", required = false) Long ruleGroupId) {
        SimpleFormControl control = controlService.getControlById(formId, controlId);
        if (StringUtils.isNotEmpty(label))
            control.setLabel(label);
        if (ruleGroupId != null) {
            control.setValidateRuleGroup(controlService.getRuleGroup(ruleGroupId));
        }
        controlService.save(control);
        return Status.SUCCESS;
    }

    @PostMapping("/form/{formId}/controlData/{controlId}")
    @ResponseBody
    public Status saveControlData(@PathVariable("formId") String formId,
                                  @PathVariable("controlId") Long controlId,
                                  @ModelAttribute NameValuePair nameValuePair) {
        nameValuePair.setControl(controlService.getControlById(formId, controlId));
        controlService.saveControlData(nameValuePair);
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
}
