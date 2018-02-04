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
</div>
<script type="text/javascript">
    $(document).ready(function () {
        $.ajax({
            method:'get',
            url:'/static/script/region.json'
        }).done(function (data) {
            var $province = $('#province_${id}'),$city = $('#city_${id}'),
                    $area=$('#area_${id}'),provinceData={};
            $.each(data,function (name,value) {
                $province.append("<option value='"+value.name+"'>"+value.name+"</option>");
            });
            $province.change(function () {
                var $this = $(this);
                $.each(data,function (name,value) {
                    if(value.name===$this.val()){
                        provinceData = value;
                        $city.empty().append("<option value=''>请选择市</option>");
                        $area.empty().append("<option value=''>请选择区</option>");
                        $.each(value.city,function (name,value) {
                            $city.append("<option value='"+value.name+"'>"+value.name+"</option>");
                        });
                    }
                });
            });
            $city.change(function () {
                var $this = $(this);
                $.each(provinceData.city,function (name,value) {
                    if(value.name===$this.val()){
                        $area.empty().append("<option value=''>请选择区</option>");
                        $.each(value.area,function (name,value) {
                            $area.append("<option value='"+value+"'>"+value+"</option>");
                        })
                    }
                })
            })
        });

        var rules ={};
        <#if rules??&&rules!=''>
            rules = ${rules};
        </#if>
        console.log(rules);
        $("#province_${id}").rules("add", rules);
        $("#city_${id}").rules("add", rules);
        $("#area_${id}").rules("add", rules);
    });
</script>