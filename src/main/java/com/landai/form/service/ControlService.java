package com.landai.form.service;

import com.landai.form.model.*;
import com.landai.form.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

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
    @Autowired
    RuleGroupRepository ruleGroupRepository;


    public SimpleFormControl getCommonControlByName(String name) {
        return formControlRepository.getSimpleFormControlByName(name);
    }

    public SimpleFormControl save(SimpleFormControl formControl) {
        return formControlRepository.save(formControl);
    }

    public SimpleFormControl getControlById(String formId, Long id) {
        SimpleFormControl control = formControlRepository.findOne(id);
        control.setRuleValues(ruleValueRepository.getRuleValuesByFormIdAndControlId(formId, id));
        List<ValidateRuleGroup> ruleGroups = control.getRuleGroups();
        if (ruleGroups != null && ruleGroups.size() == 1) {
            control.setValidateRuleGroup(ruleGroups.get(0));
            formControlRepository.save(control);
        }
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

    public ValidateRuleGroup getRuleGroup(Long ruleGroupId) {
        return ruleGroupRepository.getOne(ruleGroupId);
    }

}
