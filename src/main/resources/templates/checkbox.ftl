<div id="control_area_${id}" class="form-group control-area">
    <div id="control_${id}_label">
        <span class="label">${label}:</span>
        <span class="badge badge-light delete" style="display: none;margin-top: 10px">x</span>
    </div>
    <div>
        <label for="${name}" class="error"></label>
    </div>
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
                $('#control_${id}_label').after($('<div class="form-check form-check-inline">\n' +
                        '        <input class="form-check-input" type="checkbox" name="${name}" value="' + v + '">\n' +
                        '        <label class="form-check-label">' + v + '</label>\n' +
                        '    </div>'));
            });
        </#if>
            if (rules_${id}.required) {
                $('#control_area_${id} span.label').append('<span class="required">*</span>')
            }
            $("input[name='${name}']").rules("add", rules_${id});
        });
    </script>
</div>
