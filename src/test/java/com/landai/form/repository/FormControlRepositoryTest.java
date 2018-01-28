package com.landai.form.repository;

import com.landai.form.FormApplicationTests;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

public class FormControlRepositoryTest extends FormApplicationTests {

    @Autowired
    FormControlRepository controlRepository;

    @Test
    public void loadControls(){
        controlRepository.findAll();
    }
}
