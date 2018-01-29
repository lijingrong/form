package com.landai.form.model;

import lombok.Data;
import lombok.ToString;

import javax.persistence.*;
import java.util.List;

@Data
@Entity
@Table(name = "t_validate_rule_group")
@ToString(exclude = {"validateRules"})
public class ValidateRuleGroup {

    @Id
    private Long id;

    private String groupName;

    private String groupLabel;

    @ManyToMany
    @JoinTable(name = "t_validate_rule_group_rule",
            joinColumns = @JoinColumn(name = "rule_group_id", referencedColumnName = "id"),
            inverseJoinColumns = @JoinColumn(name = "rule_id", referencedColumnName = "id"))
    private List<ValidateRule> validateRules;

}
