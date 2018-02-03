package com.landai.form.repository;

import com.landai.form.model.ComponentPrototype;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ComponentPrototypeRepository extends JpaRepository<ComponentPrototype, Long> {

    ComponentPrototype getComponentPrototypeByName(final String name);

}
