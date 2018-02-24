package com.landai.form.service;

import com.landai.form.model.Component;
import com.landai.form.model.Control;
import com.landai.form.repository.ComponentRepository;
import com.landai.form.repository.ControlRepository;
import com.landai.form.repository.FormRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class ComponentService {

    @Autowired
    private ComponentRepository componentRepository;
    @Autowired
    private FormRepository formRepository;
    @Autowired
    private RenderControlService renderControlService;
    @Autowired
    private ControlRepository controlRepository;

    public void saveComponent(Component component) {
        Control control = controlRepository.getControlByComponentIdAndName(component.getId(), component.getName());
        if (control != null) {
            control.setLabel(component.getLabel());
            controlRepository.save(control);
        }
        componentRepository.save(component);
    }

    public Component getComponent(Long componentId) {
        return componentRepository.getOne(componentId);
    }

    public List<Component> getComponents(String formId) {
        List<Component> components = componentRepository.getComponentsByFormOrderByOrdersAscIdAsc(formRepository.getOne(formId));
        for (Component component : components) {
            component.setHtml(renderControlService.getRenderHtml(component.getViewPage(), component));
        }
        return components;
    }

    @Transactional
    public void deleteComponent(Long componentId) {
        controlRepository.deleteControlByComponentId(componentId);
        componentRepository.delete(componentId);
    }

    @Transactional
    public void batchSaveComponent(List<Component> components) {
        componentRepository.save(components);
    }
}
