package com.landai.form.model;

import lombok.Data;

import javax.persistence.*;

@Data
@Entity
@Table(name = "t_rule_value")
public class RuleValue {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String ruleValue;

    @ManyToOne
    @JoinColumn(name = "rule_id")
    private ValidateRule validateRule;
    private Long controlId;
    private String formId;

}
