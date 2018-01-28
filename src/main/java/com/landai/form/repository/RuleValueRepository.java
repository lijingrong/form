package com.landai.form.repository;

import com.landai.form.model.RuleValue;
import com.landai.form.model.ValidateRule;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RuleValueRepository extends JpaRepository<RuleValue, Long> {

    RuleValue getRuleValueByFormIdAndControlIdAndValidateRule(final String formId, final Long controlId, final ValidateRule rule);

    List<RuleValue> getRuleValuesByFormIdAndControlId(final String formId, final Long controlId);
}
