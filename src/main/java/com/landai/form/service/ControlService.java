package com.landai.form.service;

import com.landai.form.model.*;
import com.landai.form.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ControlService {

    @Autowired
    FormControlRepository formControlRepository;
    @Autowired
    FormRepository formRepository;
    @Autowired
    ValidateRuleRepository validateRuleRepository;
    @Autowired
    ControlDataRepository controlDataRepository;
    @Autowired
    RuleValueRepository ruleValueRepository;


    public SimpleFormControl getCommonControlByName(String name) {
        return formControlRepository.getSimpleFormControlByName(name);
    }

    public void save(SimpleFormControl formControl) {
        formControlRepository.save(formControl);
    }

    public SimpleFormControl getControlById(String formId, Long id) {
        SimpleFormControl control = formControlRepository.findOne(id);
        control.setRuleValues(ruleValueRepository.getRuleValuesByFormIdAndControlId(formId, id));
        return control;
    }

    public void delete(String formId, Long controlId) {
        Form form = formRepository.findOne(formId);
        SimpleFormControl control = formControlRepository.findOne(controlId);
        form.getControlList().remove(control);
        if (!control.isCommon())
            formControlRepository.delete(control);
        formRepository.save(form);
    }

    public void saveValidate(RuleValue ruleValue) {
        ruleValueRepository.save(ruleValue);
    }

    public void deleteRuleValue(Long ruleValueId) {
        ruleValueRepository.delete(ruleValueId);
    }

    public ValidateRule getValidateRule(Long validateRuleId) {
        return validateRuleRepository.findOne(validateRuleId);
    }

    public void saveControlData(NameValuePair nameValuePair) {
        controlDataRepository.save(nameValuePair);
    }
}
