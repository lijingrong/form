<#include "header.ftl"/>
<div class="bg-light" style="min-height: 500px">
    <div class="container pt-5">
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
