<div id="control_area_${id}" class="form-group control-area">
    <label id="control_${id}_label" for="control_${id}">
        <span class="label">${label}:</span>
        <span class="badge badge-light delete" style="display: none; padding: .5em .8em;">x</span>
    </label>
    <input class="form-control" type="text" id="control_${id}" name="${name}" autocomplete="off">
    <small class="form-text text-muted">${description!""}</small>

    <script type="text/javascript">
        $(document).ready(function () {
            if (device.mobile() || device.tablet()) {
                var $type = {'date': 'date', 'datetime': 'datetime-local', 'time': 'time'};
                if ($type.${type} !== undefined) {
                    $("#control_${id}").attr("type", $type.${type}).attr("style", "height: 38px;");
                }
            } else {
                require.config({
                    paths: {
                        laydate: '/static/laydate/laydate'
                    }
                });

                require(['laydate'], function (laydate) {
                    laydate.render({
                        elem: '#control_${id}',
                        type: '${type}'
                    });
                });
            }

            var rules_${id} = {};
        <#if validateRules??&&validateRules!=''>
            rules_${id} = ${validateRules};
        </#if>
            if (rules_${id}.required) {
                $('#control_area_${id} span.label').append('<span class="required">*</span>')
            }
            $("#control_" + ${id}).rules("add", rules_${id});
        });
    </script>
</div>