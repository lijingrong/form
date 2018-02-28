<div class="card">
    <div class="card-header">
        控件设置
    </div>
    <div class="card-body">
        <div class="tab-pane fade show active" id="attributes" role="tabpanel" aria-labelledby="attribute-tab">
            <div class="container" id="attributes">
                <div class="form-group">
                    <label for="label_{id}">组件名称：</label>
                    <input class="form-control" type="text" name="label" id="label_${id}" value="${label!''}">
                </div>
                <div class="form-group">
                    <label for="description_${id}">组件提示：</label>
                    <textarea id="description_${id}" name="description" class="form-control">${description!''}</textarea>
                </div>
            </div>
            <div class="container" id="componentRules">
                <div class="form-group">
                    <div class="form-check">
                        <input type="checkbox" id="required_${id}" name="required" class="form-check-input">
                        <label class="form-check-label" for="required_${id}">必填项</label>
                    </div>
                </div>
                <#if type=='string'>
                    <div class="form-group">
                        <label for="minlength_${id}">允许最少输入字符数:</label>
                        <input type="text" id="minlength_${id}" name="minlength" class="form-control form-control-sm">
                    </div>
                    <div class="form-group">
                        <label for="maxlength_${id}">允许最多输入字符数:</label>
                        <input type="text" id="maxlength_${id}" name="maxlength" class="form-control form-control-sm">
                    </div>
                </#if>
            </div>
            <div class="container bg-light" id="componentData">
                <div class="mt-3 pt-1">
                    <label>数据编辑：</label>
                    <table id="controlDataTable" class="table">
                        <thead>
                        <tr>
                            <th>值</th>
                            <th></th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
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
        </div>

    </div>
</div>
<#include "componentEdit.ftl"/>