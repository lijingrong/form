package com.landai.form.model;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.Data;
import lombok.ToString;

import javax.persistence.*;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Data
@Entity
@Table(name = "t_control")
@ToString(exclude = {"formList", "validateRuleGroup"})
public class SimpleFormControl implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Transient
    private String html;
    private String viewName;

    private String label;
    private String name;
    private String type;
    private boolean isCommon;

    @OneToMany(mappedBy = "control")
    private List<NameValuePair> data = new ArrayList<>();

    @ManyToMany(mappedBy = "controlList")
    private List<Form> formList = new ArrayList<>();

    @ManyToOne
    @JoinColumn(name = "rule_group_id", updatable = false)
    private ValidateRuleGroup validateRuleGroup;

    @Transient
    private List<RuleValue> ruleValues;

    public String getRules() {
        if (ruleValues == null) return "";
        Map<String, Integer> rulesMap = new HashMap<>();
        for (RuleValue ruleValue : ruleValues) {
            rulesMap.put(ruleValue.getValidateRule().getName(), Integer.parseInt(ruleValue.getRuleValue()));
        }
        ObjectMapper objectMapper = new ObjectMapper();
        try {
            return objectMapper.writeValueAsString(rulesMap);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        return "";
    }
}
