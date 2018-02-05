package com.landai.form.service;

import com.landai.form.model.Form;
import com.landai.form.model.FormValue;
import com.landai.form.repository.FormRepository;
import com.landai.form.repository.FormValueRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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


    public Form getForm(final String formId) {
        return formRepository.getOne(formId);
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
}
