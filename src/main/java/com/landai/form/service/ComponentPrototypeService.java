package com.landai.form.service;

import com.landai.form.model.ComponentPrototype;
import com.landai.form.repository.ComponentPrototypeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ComponentPrototypeService {

    @Autowired
    private ComponentPrototypeRepository componentPrototypeRepository;

    public List<ComponentPrototype> getAllComponentPrototypes() {
        return componentPrototypeRepository.findAll();
    }

    public ComponentPrototype getComponentPrototype(String name) {
        return componentPrototypeRepository.getComponentPrototypeByName(name);
    }

    public List<ComponentPrototype> getComponentPrototypesByIsCommon(final Boolean isCommon){
        return componentPrototypeRepository.getComponentPrototypesByIsCommon(isCommon);
    }
}
