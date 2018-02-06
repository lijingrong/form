package com.landai.form.repository;

import com.landai.form.model.Control;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ControlRepository extends JpaRepository<Control, Long> {

    Control getControlByComponentIdAndName(final Long componentId,final String name);

    void deleteControlByComponentId(final Long componentId);

    List<Control> getControlsByFormId(final String formId);
}
