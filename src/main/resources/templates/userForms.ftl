<#include "header.ftl"/>
<div class="album py-5 bg-light">
    <div class="container">
        <div class="row mb-1">
            <div class="col-12">
                <a class="btn btn-primary" href="/form/new">创建表单</a>
            </div>
        </div>
        <div class="row">
            <#list forms as form>
                <div class="col-md-4">
                    <div class="card mb-4 box-shadow">
                        <img class="card-img-top"
                             data-src="holder.js/100px225?theme=thumb&bg=55595c&fg=eceeef&text=${form.title}"
                             alt="Card image cap">
                        <div class="card-body">
                            <p class="card-text">${form.description}</p>
                            <div class="d-flex justify-content-between align-items-center">
                                <div class="btn-group">
                                    <button onclick="location='/f/${form.id}'" type="button" class="btn btn-sm btn-outline-secondary">预览</button>
                                    <button onclick="location='/builder/${form.id}'" type="button" class="btn btn-sm btn-outline-secondary">编辑</button>
                                </div>
                                <small class="text-muted">
                                    <#switch form.status>
                                        <#case "DRAFT">
                                            草稿
                                            <#break>
                                        <#case "PUBLISHED">
                                            已发布
                                            <#break>
                                        <#case "DISABLED">
                                            已停用
                                            <#break>
                                    </#switch>
                                </small>
                                <small class="text-muted">${form.createTime?string('yyyy-MM-dd')}</small>
                            </div>
                        </div>
                    </div>
                </div>
            </#list>
        </div>
    </div>
</div>

<#include "footer.ftl"/>