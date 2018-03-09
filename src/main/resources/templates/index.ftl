<#include "header.ftl"/>

    <main role="main">

        <section class="jumbotron text-center">
            <div class="container">
                <h1 class="jumbotron-heading">简单，易用</h1>
                <p class="lead text-muted">拖拽式表单设计器，帮您高效收集各类数据</p>
                <p>
                    <#if currentUser??>

                    <#else>
                        <a href="/signUp" class="btn btn-primary my-2">立即注册</a>
                    </#if>
                </p>
            </div>
        </section>
        <div class="container">
            <hr class="featurette-divider">
            <div class="row featurette mb-5">
                <div class="col-md-12">
                    <h2 class="featurette-heading text-center">拖拽式表单设计器，<span class="text-muted">一目了然。</span></h2>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <img  data-src="/static/images/formBuilder.jpg" class="lazyload featurette-image img-fluid mx-auto img-thumbnail"  alt="在线表单，表单设计器">
                </div>
            </div>
            <hr class="featurette-divider">

            <div class="row featurette">
                <div class="col-md-7 order-md-2">
                    <h2 class="featurette-heading">一次设计， <span class="text-muted">多终端适配。</span></h2>
                    <p class="lead">用户可在电脑、平板、手机端查看表单，填报数据。</p>
                    <div class="mt-5">
                        <img data-src="/static/images/pcFormView.png" class="lazyload featurette-image img-fluid mx-auto img-thumbnail"  alt="在表单，多终端适配">
                    </div>
                </div>
                <div class="col-md-5 order-md-1">
                    <img data-src="/static/images/phoneFormView.jpeg" class="lazyload featurette-image img-fluid mx-auto img-thumbnail"  alt="在表单，多终端适配">
                </div>
            </div>
            <hr class="featurette-divider">
            <div class="row featurette mb-5">
                <div class="col-md-12">
                    <h2 class="featurette-heading text-center">一键导出数据</h2>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <img  data-src="/static/images/exportdata.jpg" class="lazyload featurette-image img-fluid mx-auto img-thumbnail"  alt="在线表单，表单设计器">
                </div>
            </div>
        </div>

        <div class="album py-5 bg-light mt-5">
            <div class="container">
                <div><h1 class="lead">表单模板</h1></div>
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
                                            <button type="button" onclick="location='/form/${form.id}/copy'" class="btn btn-sm btn-outline-secondary">使用</button>
                                        </div>
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

