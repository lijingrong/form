<div id="control_area_${id}" class="form-group control-area">
    <label>${label}:
        <#if validateRuleGroup??>
            <#list validateRuleGroup.validateRules as rule>
                <#if rule.name=='required' && rule.ruleValue??&&rule.ruleValue.ruleValue=='1'>
                    <span class="required">*</span>
                </#if>
            </#list>
        </#if>
        <span class="badge badge-light delete" style="display: none;margin-top: 10px">x</span>
    </label>
    <input class="form-control" type="text" id="control_${id}" name="${name}" autocomplete="off">
</div>
<script type="text/javascript">
    $(document).ready(function () {
        var rules ={};
        <#if rules??&&rules!=''>
            rules = ${rules};
        </#if>
        console.log(rules);
        $("#control_" +${id}).rules("add", rules);
    });
</script>