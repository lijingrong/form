package com.landai.form.repository;

import com.landai.form.model.ValidateRuleGroup;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RuleGroupRepository extends JpaRepository<ValidateRuleGroup, Long> {

    List<ValidateRuleGroup> getValidateRuleGroupsByIdIn(List<Long> groupIds);
}
