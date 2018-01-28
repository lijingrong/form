package com.landai.form.repository;

import com.landai.form.model.ValidateRule;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ValidateRuleRepository extends JpaRepository<ValidateRule, Long> {

}
