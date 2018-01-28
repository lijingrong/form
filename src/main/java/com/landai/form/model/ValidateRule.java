package com.landai.form.model;

import lombok.Data;
import lombok.ToString;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

@Data
@Entity
@Table(name = "t_validate_rule")
@ToString(exclude = {"ruleValue"})
public class ValidateRule {

    @Id
    private Long id;

    private String name;
    private String label;
    private String type;

    @Transient
    private RuleValue ruleValue;
}
