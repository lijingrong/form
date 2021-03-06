<#include "header.ftl"/>
<div class="album py-5 bg-light">
    <div class="container mb-3">
        <nav class="navbar navbar-light bg-light p-0">
            <div class="btn-group">
                <a class="btn <#if status??>btn-outline-secondary<#else>btn-outline-primary</#if>" href="/form/list">全部</a>
                <a class="btn <#if status??&&status=='PUBLISHED'>btn-outline-primary<#else>btn-outline-secondary</#if>" href="/form/list?formStatus=PUBLISHED">已发布</a>
                <a class="btn <#if status??&&status=='DRAFT'>btn-outline-primary<#else>btn-outline-secondary</#if>" href="/form/list?formStatus=DRAFT">草稿</a>
                <a class="btn <#if status??&&status=='DISABLED'>btn-outline-primary<#else>btn-outline-secondary</#if>" href="/form/list?formStatus=DISABLED">已停用</a>
            </div>
            <a class="btn btn-primary" href="/form/new">创建表单</a>
        </nav>

    </div>
    <div class="container">
        <#if status??>
        <#else>
            <#if (formPage.content?size==0)>
            <div class="row">
                <div class="col-12 m-2">
                    您还没创建过表单，<span class="text-primary">不会创建？</span>请看下面的演示教程
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <video src="http://img.dan-ye.com/video/buildFormVideo.mp4" controls="true" width="800px" height="500px"></video>
                </div>
            </div>
            </#if>
        </#if>

        <div class="row">
            <#list formPage.content as form>
                <div class="col-md-4">
                    <div class="card mb-4 box-shadow">
                        <img class="card-img-top"
                             data-src="holder.js/100px225?theme=thumb&bg=55595c&fg=eceeef&text=${form.title}"
                             alt="Card image cap">
                        <div class="card-body">
                            <div class="card-text d-inline-block text-truncate" style="max-width: 300px;height: 30px">
                                ${form.description}
                            </div>
                            <div class="d-flex justify-content-between align-items-center">
                                <div class="btn-group">
                                    <button onclick="location='/f/${form.id}'" type="button"
                                            class="btn btn-sm btn-outline-secondary">预览
                                    </button>
                                    <button onclick="location='/builder/${form.id}'" type="button"
                                            class="btn btn-sm btn-outline-secondary">编辑
                                    </button>
                                    <#if form.status !='DRAFT'>
                                        <button onclick="location='/form/${form.id}/data'" type="button"
                                                class="btn btn-sm btn-outline-secondary">数据
                                        </button>
                                    </#if>
                                </div>
                                <small class="text-muted">
                                    <#switch form.status>
                                        <#case "DRAFT">
                                            草稿
                                            <#break>
                                        <#case "PUBLISHED">
                                            <span class="text-success">已发布</span>
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
        <#if (formPage.content?size>0)>
            <nav aria-label="Page navigation example">
                <ul class="pagination">
                    <li class="page-item <#if formPage.number == 0>disabled</#if>"><a class="page-link" href="/form/list?page=${formPage.number-1}&size=${formPage.size}">上一页</a></li>
                    <#list 1..formPage.totalPages as n>
                        <li class="page-item <#if formPage.number == (n-1)>active</#if>"><a class="page-link " href="/form/list?page=${n-1}&size=${formPage.size}">${n}</a></li>
                    </#list>
                    <li class="page-item <#if formPage.number == (formPage.totalPages-1)>disabled</#if>"><a class="page-link" href="/form/list?page=${formPage.number+1}&size=${formPage.size}">下一页</a></li>
                </ul>
            </nav>
        </#if>

    </div>
</div>

<#include "footer.ftl"/>