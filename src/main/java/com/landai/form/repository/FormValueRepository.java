package com.landai.form.repository;

import com.landai.form.model.Form;
import com.landai.form.model.FormValue;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FormValueRepository extends JpaRepository<FormValue, Long> {

    List<FormValue> getFormValuesByForm(Form form);
}
