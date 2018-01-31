package com.landai.form.service;

import com.landai.form.model.*;
import com.landai.form.repository.FormValueRepository;
import com.landai.form.repository.ValidateRuleRepository;
import com.landai.form.repository.FormRepository;
import com.landai.form.repository.RuleValueRepository;
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
    ValidateRuleRepository validateRepository;
    @Autowired
    RuleValueRepository ruleValueRepository;
    @Autowired
    FormValueRepository formValueRepository;

    public List<SimpleFormControl> getFormControls(final String formId) {
        Form form = getForm(formId);
        List<SimpleFormControl> formControls = form.getControlList();
        for (SimpleFormControl control : formControls) {
            ValidateRuleGroup validateRuleGroup = control.getValidateRuleGroup();
            if (validateRuleGroup != null) {
                for (ValidateRule validateRule : validateRuleGroup.getValidateRules()) {
                    validateRule.setRuleValue(ruleValueRepository.
                            getRuleValueByFormIdAndControlIdAndValidateRule(formId, control.getId(), validateRule));
                }
            }
            control.setRuleValues(ruleValueRepository.getRuleValuesByFormIdAndControlId(formId, control.getId()));
            control.setHtml(renderControlService.getRenderHtml(control.getViewName(), control));
        }
        return formControls;
    }

    public Form getForm(final String formId) {
        return formRepository.getOne(formId);
    }

    public void saveForm(Form form) {
        formRepository.save(form);
    }

    public void saveFormValue(FormValue formValue) {
        formValueRepository.save(formValue);
    }
}
