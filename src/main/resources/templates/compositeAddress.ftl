<div id="control_area_${id}" class="form-group control-area">
    <label>
        <span class="label">${label}:</span>
        <span class="badge badge-light delete" style="display: none; padding: .5em .8em;">x</span>
    </label>
    <div class="row">
        <div class="col">
            <select id="province_${id}" name="province${id}" class="form-control">
                <option value="">请选择省</option>
            </select>
        </div>
        <div class="col">
            <select id="city_${id}" name="city${id}" class="form-control">
                <option value="">请选择市</option>
            </select>
        </div>
        <div class="col">
            <select id="area_${id}" name="area${id}" class="form-control">
                <option value="">请选择区</option>
            </select>
        </div>
    </div>
    <div class="row" style="margin-top: 5px">
        <div class="col-12">
            <input type="text" name="address${id}" class="form-control" placeholder="请输入详细地址">
        </div>
    </div>
    <small class="form-text text-muted">${description!""}</small>

    <script type="text/javascript">
        $(document).ready(function () {
            $.ajax({
                method: 'get',
                url: '/static/js/region.json'
            }).done(function (data) {
                var $province = $('#province_${id}'), $city = $('#city_${id}'),
                        $area = $('#area_${id}'), provinceData = {};
                $.each(data, function (name, value) {
                    $province.append("<option value='" + value.name + "'>" + value.name + "</option>");
                });
                $province.change(function () {
                    var $this = $(this);
                    $.each(data, function (name, value) {
                        if (value.name === $this.val()) {
                            provinceData = value;
                            $city.empty().append("<option value=''>请选择市</option>");
                            $area.empty().append("<option value=''>请选择区</option>");
                            $.each(value.city, function (name, value) {
                                $city.append("<option value='" + value.name + "'>" + value.name + "</option>");
                            });
                        }
                    });
                });
                $city.change(function () {
                    var $this = $(this);
                    $.each(provinceData.city, function (name, value) {
                        if (value.name === $this.val()) {
                            $area.empty().append("<option value=''>请选择区</option>");
                            $.each(value.area, function (name, value) {
                                $area.append("<option value='" + value + "'>" + value + "</option>");
                            })
                        }
                    })
                })
            });

            var rules_${id} = {};
        <#if validateRules??&&validateRules!=''>
            rules_${id} = ${validateRules};
        </#if>
            if (rules_${id}.required) {
                $('#control_area_${id} span.label').append('<span class="required">*</span>')
            }
            $("#province_${id}").rules("add", rules_${id});
            $("#city_${id}").rules("add", rules_${id});
            $("#area_${id}").rules("add", rules_${id});
        });
    </script>
</div>