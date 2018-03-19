<#include "header.ftl"/>
<div class="bg-light" style="min-height: 500px">
    <div class="container bg-white pt-5 pb-2">
        <div class="mb-2">
            <h4>${form.title}</h4>
        </div>
        <#if (formValuePage.content?size>0)>
            <nav class="navbar navbar-light mb-1">
                <a class="btn btn-primary" href="/form/${form.id}/data/export">导出数据</a>
            </nav>
        </#if>
        <table id="formDataTable" class="table">
            <thead>
            <tr>
            <#list controls as control>
                <th controlName="${control.name}" controlType="${control.component.type}">${control.label}</th>
            </#list>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
        <#if (formValuePage.content?size>0)>
            <nav aria-label="Page navigation example">
                <ul class="pagination">
                    <li class="page-item <#if formValuePage.number == 0>disabled</#if>">
                        <a class="page-link" href="/form/${form.id}/data?page=0&size=${formValuePage.size}">第一页</a>
                    </li>
                    <li class="page-item <#if formValuePage.number == 0>disabled</#if>">
                        <a class="page-link"
                           href="/form/${form.id}/data?page=${formValuePage.number-1}&size=${formValuePage.size}">上一页</a>
                    </li>
                    <#if (formValuePage.totalPages > 9)>
                        <#if (formValuePage.number < 4)>
                            <#list 1..9 as n>
                                <li class="page-item <#if formValuePage.number == (n-1)>active</#if>">
                                    <a class="page-link "
                                       href="/form/${form.id}/data?page=${n-1}&size=${formValuePage.size}">${n}</a>
                                </li>
                            </#list>
                        </#if>
                        <#if (formValuePage.number > (formValuePage.totalPages - 5))>
                            <#list (formValuePage.totalPages - 8)..formValuePage.totalPages as n>
                                <li class="page-item <#if formValuePage.number == (n-1)>active</#if>">
                                    <a class="page-link "
                                       href="/form/${form.id}/data?page=${n-1}&size=${formValuePage.size}">${n}</a>
                                </li>
                            </#list>
                        </#if>
                        <#if !(formValuePage.number < 4 || formValuePage.number > (formValuePage.totalPages - 5)) >
                            <#list (formValuePage.number - 3)..(formValuePage.number + 5) as n>
                                <li class="page-item <#if formValuePage.number == (n-1)>active</#if>">
                                    <a class="page-link "
                                       href="/form/${form.id}/data?page=${n-1}&size=${formValuePage.size}">${n}</a>
                                </li>
                            </#list>
                        </#if>
                    </#if>
                    <#if (formValuePage.totalPages <= 9)>
                        <#list 1..formValuePage.totalPages as n>
                            <li class="page-item <#if formValuePage.number == (n-1)>active</#if>">
                                <a class="page-link "
                                   href="/form/${form.id}/data?page=${n-1}&size=${formValuePage.size}">${n}</a>
                            </li>
                        </#list>
                    </#if>
                    <li class="page-item <#if formValuePage.number == (formValuePage.totalPages-1)>disabled</#if>">
                        <a class="page-link"
                           href="/form/${form.id}/data?page=${formValuePage.number+1}&size=${formValuePage.size}">下一页</a>
                    </li>
                    <li class="page-item <#if formValuePage.number == (formValuePage.totalPages-1)>disabled</#if>">
                        <a class="page-link"
                           href="/form/${form.id}/data?page=${formValuePage.totalPages - 1}&size=${formValuePage.size}">最后一页</a>
                    </li>
                </ul>
            </nav>
        </#if>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function () {
        var data = [], controlComponents = [];
       <#if data??>
           data =${data};
       </#if>
        $('#formDataTable th').each(function () {
            controlComponents.push({name: $(this).attr("controlName"), type: $(this).attr("controlType")});
        });
        if (data.length === 0) {
            $('#formDataTable').after($('<div class="text-center">').text("暂无数据"));
        }
        $.each(data, function (i, o) {
            var tr = $('<tr>');
            $.each(controlComponents, function (i, d) {
                if (d && d.type !== undefined && d.type === "image") {
                    var _html = o[d.name] !== undefined ? o[d.name] : "";
                    tr.append($('<td>').html('<img src="' + _html + '" style="width: 10rem;">'));
                } else {
                    tr.append($('<td>').text(o[d.name]));
                }
            });
            $('#formDataTable').append(tr);
        })
    });
</script>
<#include "footer.ftl"/>
