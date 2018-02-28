package com.landai.form.service;

import com.landai.form.model.*;
import com.landai.form.repository.FormRepository;
import com.landai.form.repository.FormValueRepository;
import com.landai.form.repository.UserRepository;
import com.landai.form.utils.CurrentUserUtil;
import org.apache.commons.lang3.RandomStringUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
public class FormService {

    @Autowired
    RenderControlService renderControlService;
    @Autowired
    FormRepository formRepository;
    @Autowired
    FormValueRepository formValueRepository;
    @Autowired
    ComponentService componentService;
    @Autowired
    UserRepository userRepository;
    @Autowired
    ControlService controlService;

    public Form getForm(final String formId) {
        return formRepository.getOne(formId);
    }

    public List<Form> getFormsByCreator(String creator) {
        return formRepository.getFormsByUserOrderByCreateTimeDesc(userRepository.getOne(creator));
    }

    public List<Form> getFormsByCreatorAndStatus(String creator, FormStatus formStatus) {
        return formRepository.getFormsByUserAndStatusOrderByCreateTimeDesc(userRepository.getOne(creator), formStatus);
    }

    public List<Form> getTemplateForms() {
        return formRepository.getFormsByTemplate(true);
    }

    public void saveForm(Form form) {
        formRepository.save(form);
    }

    public void saveFormValue(FormValue formValue) {
        formValueRepository.save(formValue);
    }

    public List<FormValue> getAllFormValue(String formId) {
        return formValueRepository.getFormValuesByForm(formRepository.getOne(formId));
    }

    @Transactional
    public Form copyForm(String formId) {
        Form form = getForm(formId);
        Form newForm = new Form();
        newForm.setId(RandomStringUtils.randomAlphanumeric(6));
        newForm.setTitle(form.getTitle() + "_copy");
        newForm.setStatus(FormStatus.DRAFT);
        newForm.setAfterPostDesc(form.getAfterPostDesc());
        newForm.setDescription(form.getDescription());
        newForm.setUser(CurrentUserUtil.getUser());
        newForm.setCreateTime(new Date());
        newForm.setTemplate(false);
        newForm.setTemplateId(formId);
        saveForm(newForm);
        List<Component> components = componentService.getComponents(formId);
        for (Component component : components) {
            Component nComponent = new Component();
            nComponent.setForm(newForm);
            nComponent.setLabel(component.getLabel());
            nComponent.setName(RandomStringUtils.randomAlphabetic(6));
            nComponent.setData(component.getData());
            nComponent.setValidateRules(component.getValidateRules());
            nComponent.setViewPage(component.getViewPage());
            nComponent.setEditPage(component.getEditPage());
            nComponent.setType(component.getType());
            componentService.saveComponent(nComponent);
            List<Control> controls = controlService.getControlsByFormIdAndAndComponentId(formId, component.getId());
            List<Control> cControls = new ArrayList<>();
            for (Control control : controls) {
                Control nControl = new Control();
                nControl.setComponentId(nComponent.getId());
                nControl.setFormId(newForm.getId());
                nControl.setLabel(control.getLabel());
                if (control.getName().contains("_")) {
                    nControl.setName(StringUtils.split(control.getName(), "_")[0] + "_" + nComponent.getId());
                } else {
                    nControl.setName(nComponent.getName());
                }
                cControls.add(nControl);
            }
            controlService.save(cControls);
        }
        return newForm;
    }
}
