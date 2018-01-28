<div id="control_area_${id}" class="form-group row">
    <label class="col-3 col-form-label">${label}:
        <#if validateRuleGroup??>
            <#list validateRuleGroup.validateRules as rule>
                <#if rule.name=='required' && rule.ruleValue??&&rule.ruleValue.ruleValue=='1'>
                    <span class="required">*</span>
                </#if>
            </#list>
        </#if>
    </label>
    <div class="col-7">
        <select class="form-control" id="control_${id}" name="${name}">
            <#list data as d>
                <option value="${d.value}">${d.name}</option>
            </#list>
        </select>
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
        $("#control_${id}").rules("add",rules);
    });
</script>