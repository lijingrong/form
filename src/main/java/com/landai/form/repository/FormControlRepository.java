package com.landai.form.repository;

import com.landai.form.model.SimpleFormControl;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface FormControlRepository extends JpaRepository<SimpleFormControl,Long> {

    SimpleFormControl getSimpleFormControlByName(final String name);
}
