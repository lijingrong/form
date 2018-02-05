package com.landai.form.repository;

import com.landai.form.model.Control;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ControlRepository extends JpaRepository<Control, Long> {

    Control getControlByComponentIdAndName(final Long componentId,final String name);

    void deleteControlByComponentId(final Long componentId);

}
