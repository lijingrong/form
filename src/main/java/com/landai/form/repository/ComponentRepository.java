package com.landai.form.repository;

import com.landai.form.model.Component;
import com.landai.form.model.Form;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ComponentRepository extends JpaRepository<Component, Long> {

    List<Component> getComponentsByFormOrderByOrdersAscIdAsc(final Form form);
}
