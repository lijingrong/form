package com.landai.form.repository;

import com.landai.form.model.Form;
import com.landai.form.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FormRepository extends JpaRepository<Form, String> {

    List<Form> getFormsByUserOrderByCreateTimeDesc(User user);

    List<Form> getFormsByTemplate(Boolean isTemplate);

}
