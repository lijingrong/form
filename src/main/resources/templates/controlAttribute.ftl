<ul class="nav nav-tabs" id="myTab" role="tablist">
        <#if !control.common>
             <li class="nav-item">
                 <a class="nav-link active" id="home-tab" data-toggle="tab" href="#home" role="tab" aria-controls="home"
                    aria-selected="true">属性</a>
             </li>
        </#if>
    <li class="nav-item">
        <a class="nav-link <#if control.common>active</#if>" id="profile-tab" data-toggle="tab" href="#controlRule"
           role="tab" aria-controls="profile" aria-selected="false">验证</a>
    </li>
        <#if !control.common>
            <li class="nav-item">
                <a class="nav-link" id="contact-tab" data-toggle="tab" href="#contact" role="tab"
                   aria-controls="contact" aria-selected="false">数据</a>
            </li>
        </#if>
</ul>
<div class="tab-content" id="myTabContent">
        <#if !control.common>
            <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
                <label for="control_label">名称：</label><input id="control_label" type="text" class="form-control"
                                                             value="${control.label}">
                <div>
                    <#if control.ruleGroups??>
                        <label for="control_type">类型：</label>
                        <select id="control_type" name="control_type" class="form-control">
                            <#list control.ruleGroups as ruleGroup>
                                <option value="${ruleGroup.id}" <#if control.validateRuleGroup??&&control.validateRuleGroup.id==ruleGroup.id>selected="selected"</#if>>${ruleGroup.groupLabel}</option>
                            </#list>
                        </select>
                    </#if>
                </div>
            </div>
        </#if>
    <div class="tab-pane fade <#if control.common>show active</#if>" id="controlRule" role="tabpanel"
         aria-labelledby="profile-tab">
        <#if control.validateRuleGroup??>
            <#list control.validateRuleGroup.validateRules as rule>
                <#if rule.type =='checkbox'>
                <div class="form-group row">
                    <div class="col">${rule.label}:</div>
                    <div class="col">
                        <div class="form-check">
                            <input ruleId="${rule.id}" name="${rule.name}" type="checkbox" class="form-check-input"
                            <#if control.ruleValues??>
                                <#list control.ruleValues as ruleValue>
                                    <#if ruleValue.validateRule.id == rule.id> ruleValueId="${ruleValue.id}"</#if>
                                   <#if ruleValue.validateRule.id == rule.id&&ruleValue.ruleValue=='1'>checked="checked"</#if>
                                </#list>
                            </#if>
                            >
                            <label class="form-check-label" for="control_require"></label>
                        </div>
                    </div>
                </div>
                <#elseif rule.type =='text'>
                <div class="form-group row">
                    <label  class="col col-form-label">${rule.label}:</label>
                    <div class="col">
                        <input ruleId="${rule.id}" type="text" class="form-control form-control-sm"
                        <#if control.ruleValues??>
                            <#list control.ruleValues as ruleValue>
                                <#if ruleValue.validateRule.id == rule.id> ruleValueId="${ruleValue.id}" value="${ruleValue.ruleValue}" </#if>
                            </#list>
                        </#if>
                        >
                    </div>
                </div>
                </#if>
            </#list>
        </#if>
    </div>
         <#if !control.common>
            <div class="tab-pane fade" id="contact" role="tabpanel" aria-labelledby="contact-tab">
                <div style="margin-top: 5px">
                    <table id="controlDataTable" class="table">
                        <thead>
                        <tr>
                            <th>名称</th>
                            <th>值</th>
                            <th></th>
                        </tr>
                        </thead>
                        <tbody>
                        <#list control.data as d>
                            <tr>
                                <td>${d.name}</td>
                                <td>${d.value}</td>
                            </tr>
                        </#list>
                        <tr>
                            <td><input type="text" class="form-control" id="controlDataName" name="controlDataName">
                            </td>
                            <td><input type="text" class="form-control" id="controlDataValue" name="controlDataValue">
                            </td>
                            <td>
                                <button type="button" class="btn btn-light" id="controlDataButton">保存</button>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
         </#if>
</div>
<script type="text/javascript">
    var formId = window.location.pathname.split('/')[2];
    var controlId =${control.id};
    $(document).ready(function () {

        $('#controlRule input').each(function () {
            var $this = $(this);
            if($this.attr('type') ==='checkbox'){
                $this.click(function () {
                    console.log($(this).is(':checked'));
                    $.ajax({
                        method: 'post',
                        url: '/form/' + formId + '/controlValidate/' + controlId,
                        data: {ruleValue: $this.is(':checked')?1:0,ruleId:$this.attr('ruleId'),ruleValueId:$this.attr('ruleValueId')}
                    }).done(function (status) {
                        refreshForm();
                    })
                });
            }else if($this.attr('type')==='text'){
                $this.blur(function () {
                    $.ajax({
                        method: 'post',
                        url: '/form/' + formId + '/controlValidate/' + controlId,
                        data: {ruleValue: $this.val(),ruleId:$this.attr('ruleId'),ruleValueId:$this.attr('ruleValueId')}
                    }).done(function () {
                        refreshForm();
                    })
                });
            }
        });

        $('#control_type').change(function () {
            var value = $(this).children('option:selected').val();
            $.ajax({
                method:'post',
                url:'/form/'+formId+'/controlAttribute/'+controlId,
                data:{ruleGroupId:value}
            }).done(function () {
                refreshTab();
            });
        });

        function refreshTab() {
            $.ajax({
                method: 'get',
                url: '/form/' + formId + '/controlAttribute/' + controlId
            }).done(function (html) {
                $("#attributeArea").empty().append(html);
            })
        }

        $("#control_label").blur(function () {
            var $this = $(this);
            $.ajax({
                method: 'post',
                url: '/form/' + formId + '/controlAttribute/' + controlId,
                data: {label: $this.val()}
            }).done(function () {
                refreshForm();
            })
        });


        function refreshForm() {
            $.ajax({
                method: 'get',
                url: '/form/' + formId
            }).done(function (html) {
                $("#formArea").empty().append(html);
                initForm();
                $("#control_area_" + controlId).addClass("selected");
            });
        }

        $("#controlDataButton").click(function () {
            var name = $('#controlDataName').val(), value = $('#controlDataValue').val();
            $.ajax({
                method: 'post',
                url: '/form/' + formId + '/controlData/' + controlId,
                data: {name: name, value: value}
            }).done(function (status) {
                var newRow = $('<tr><td>' + name + '</td><td>' + value + '</td></tr>');
                $('#controlDataTable tr:first').after(newRow);
                $('#controlDataValue').val("");
                $('#controlDataName').val("");
                refreshForm();
            });
        });
    });
</script>