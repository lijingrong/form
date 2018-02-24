<#include "header.ftl"/>

    <main role="main">

        <section class="jumbotron text-center">
            <div class="container">
                <h1 class="jumbotron-heading">简单，也不简单</h1>
                <p class="lead text-muted">拖拽式表单设计器，帮您高效处理各类数据</p>
                <p>
                    <#if currentUser??>

                    <#else>
                        <a href="/signUp" class="btn btn-primary my-2">立即注册</a>
                    </#if>
                </p>
            </div>
        </section>

        <div class="album py-5 bg-light">
            <div class="container">

                <div class="row">
                    <#if forms??>
                        <#list forms as form>
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
                                            <button type="button" onclick="location='/f/${form.id}'" class="btn btn-sm btn-outline-secondary">预览</button>
                                            <button type="button" class="btn btn-sm btn-outline-secondary">使用</button>
                                        </div>
                                        <small class="text-muted">使用人数：x</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                        </#list>
                    </#if>

                </div>
            </div>
        </div>

    </main>

<#include "footer.ftl"/>

