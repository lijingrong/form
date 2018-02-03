package com.landai.form.service;

import com.landai.form.model.Component;
import com.landai.form.repository.ComponentRepository;
import com.landai.form.repository.FormRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ComponentService {

    @Autowired
    private ComponentRepository componentRepository;
    @Autowired
    private FormRepository formRepository;
    @Autowired
    RenderControlService renderControlService;

    public void saveComponent(Component component) {
        componentRepository.save(component);
    }

    public Component getComponent(Long componentId) {
        return componentRepository.getOne(componentId);
    }

    public List<Component> getComponents(String formId) {
        List<Component> components = componentRepository.getComponentsByForm(formRepository.getOne(formId));
        for (Component component : components) {
            component.setHtml(renderControlService.getRenderHtml(component.getViewPage(), component));
        }
        return components;
    }

    public void deleteComponent(Long componentId) {
        componentRepository.delete(componentId);
    }
}
