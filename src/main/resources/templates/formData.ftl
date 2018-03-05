<#include "header.ftl"/>
<div class="bg-light" style="min-height: 500px">
    <div class="container bg-white pt-5" style="height: 500px">
        <nav class="navbar navbar-light mb-1">
            <a class="btn btn-primary" href="#">导出数据</a>
        </nav>
        <table id="formDataTable" class="table">
            <thead>
            <tr>
            <#list controls as control>
                <th controlName="${control.name}">${control.label}</th>
            </#list>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
        <#if (formValuePage.content?size>0)>
            <nav aria-label="Page navigation example">
                <ul class="pagination">
                    <li class="page-item <#if formValuePage.number == 0>disabled</#if>"><a class="page-link" href="/form/${form.id}/data?page=${formValuePage.number-1}&size=${formValuePage.size}">上一页</a></li>
                    <#list 1..formValuePage.totalPages as n>
                        <li class="page-item <#if formValuePage.number == (n-1)>active</#if>"><a class="page-link " href="/form/${form.id}/data?page=${n-1}&size=${formValuePage.size}">${n}</a></li>
                    </#list>
                    <li class="page-item <#if formValuePage.number == (formValuePage.totalPages-1)>disabled</#if>"><a class="page-link" href="/form/${form.id}/data?page=${formValuePage.number+1}&size=${formValuePage.size}">下一页</a></li>
                </ul>
            </nav>
        </#if>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function () {
       var data = [],controlNames=[];
       <#if data??>
           data=${data};
       </#if>
        $('#formDataTable th').each(function () {
           controlNames.push($(this).attr("controlName"));
        });
        $.each(data,function (i,o) {
            var tr = $('<tr>');
            $.each(controlNames,function (i,n) {
                tr.append($('<td>').text(o[n]))
            });
            $('#formDataTable').append(tr);
        })
    });
</script>
<#include "footer.ftl"/>
