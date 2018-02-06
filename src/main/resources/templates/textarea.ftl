<div id="control_area_${id}" class="form-group control-area">
    <label id="control_${id}_label" for="control_${id}">
        <span class="label">${label}:</span>
    </label>
    <span class="badge badge-light delete" style="display: none;margin-top: 10px">x</span>
    <textarea class="form-control" id="control_${id}" name="${name}"></textarea>
    <small class="form-text text-muted">${description!""}</small>

    <script type="text/javascript">
        $(document).ready(function () {
            var rules_${id} = {};
        <#if validateRules??&&validateRules!=''>
            rules_${id} = ${validateRules};
        </#if>
            if (rules_${id}.required) {
                $('#control_area_${id} span.label').append('<span class="required">*</span>')
            }
            $("#control_" +${id}).rules("add", rules_${id});
        });
    </script>
</div>