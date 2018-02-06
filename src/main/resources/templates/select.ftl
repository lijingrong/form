<div id="control_area_${id}" class="form-group control-area">
    <label>
        <span class="label">${label}:</span>
    </label>
    <span class="badge badge-light delete" style="display: none;margin-top: 10px">x</span>
    <select class="form-control" id="control_${id}" name="${name}"></select>
    <small class="form-text text-muted">${description!""}</small>

    <script type="text/javascript">
        $(document).ready(function () {
            var rules_${id} = {}, data_${id}= [];
        <#if validateRules??&&validateRules!=''>
            rules_${id} = ${validateRules};
        </#if>
        <#if data??&&data!=''>
            data_${id}=${data};
            $.each(data_${id}, function (i, v) {
                $('#control_${id}').append('<option value="' + v + '">' + v + '</option>');
            });
        </#if>
            if (rules_${id}.required) {
                $('#control_area_${id} span.label').append('<span class="required">*</span>')
            }
            $("#control_" +${id}).rules("add", rules_${id});
        });
    </script>
</div>