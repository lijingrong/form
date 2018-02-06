package com.landai.form.service;

import com.landai.form.model.Control;
import com.landai.form.repository.ControlRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ControlService {

    @Autowired
    private ControlRepository controlRepository;

    public void save(List<Control> controlList) {
        controlRepository.save(controlList);
    }

    public Control getControlByComponentIdAndName(Long componentId, String name) {
        return controlRepository.getControlByComponentIdAndName(componentId, name);
    }

    public List<Control> getControlsByFormId(String formId) {
        return controlRepository.getControlsByFormId(formId);
    }
}
