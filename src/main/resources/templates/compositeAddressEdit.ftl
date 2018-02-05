<ul class="nav nav-tabs" id="myTab" role="tablist">
    <li class="nav-item">
        <a class="nav-link active" id="attribute-tab" data-toggle="tab" href="#attributes" role="tab" aria-controls="home"
           aria-selected="true">属性</a>
    </li>
    <li class="nav-item">
        <a class="nav-link" id="validate-tab" data-toggle="tab" href="#componentRules"
           role="tab" aria-controls="profile" aria-selected="false">验证</a>
    </li>
</ul>
<div class="tab-content" id="myTabContent">
    <div class="tab-pane fade show active" id="attributes" role="tabpanel" aria-labelledby="attribute-tab">
        <div class="form-group">
            <label for="label_{id}">组件名称：</label>
            <input class="form-control" type="text" name="label" id="label_${id}" value="${label!''}">
        </div>
        <div class="form-group">
            <label for="description_${id}">组件提示：</label>
            <textarea id="description_${id}" name="description" class="form-control">${description!''}</textarea>
        </div>
    </div>
    <div class="tab-pane fade" id="componentRules" role="tabpanel"
         aria-labelledby="validate-tab">
        <div class="form-group">
            <div class="form-check">
                <input type="checkbox" id="required_${id}" name="required" class="form-check-input">
                <label class="form-check-label" for="required_${id}">必填项</label>
            </div>
        </div>
    </div>
</div>
<#include "componentEdit.ftl"/>