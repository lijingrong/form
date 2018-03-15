package com.landai.form.repository;

import com.landai.form.model.Form;
import com.landai.form.model.FormStatus;
import com.landai.form.model.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FormRepository extends JpaRepository<Form, String> {

    Page<Form> getFormsByUserAndStatusOrderByCreateTimeDesc(User user, FormStatus formStatus, Pageable pageable);

    Page<Form> getFormsByUserOrderByCreateTimeDesc(User user, Pageable pageable);

    List<Form> getFormsByTemplate(Boolean isTemplate);

    Form getByIdAndUser(String formId,User user);

}
