<div id="control_area_${id}" class="form-group row">
    <div class="col-3">${label}:
    <#if validateRuleGroup??>
        <#list validateRuleGroup.validateRules as rule>
            <#if rule.name=='required' && rule.ruleValue??&&rule.ruleValue.ruleValue=='1'>
                    <span class="required">*</span>
            </#if>
        </#list>
    </#if>
    </div>
    <div class="col-7">
        <#list data as d>
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="checkbox" name="${name}" value="${d.value}">
                <label class="form-check-label">
                    ${d.name}
                </label>
            </div>
        </#list>
        <div>
            <label for="${name}" class="error"></label>
        </div>
    </div>
    <div class="col-2">
        <div><span class="badge badge-light delete" style="display: none;margin-top: 10px">x</span></div>
    </div>
</div>
<script type="text/javascript">
    $(document).ready(function () {
        var rules ={};
        <#if rules??&&rules!=''>
            rules = ${rules};
        </#if>
        $("input[name='${name}']").rules("add",rules);
    });
</script>