<#include "header.ftl"/>
<main role="main">
    <div class="container text-center pt-5" style="min-height: 600px">
        <div class="alert alert-success w-50 mx-auto" role="alert">
            表单<span class="font-weight-bold">${form.title}</span>发布成功，请分享表单二维码或链接给用户用于提交数据
        </div>
        <p><span id="counter">10</span>s后自动跳转到我的表单列表页</p>
    </div>
</main>
<script type="text/javascript">
    $(document).ready(function () {
        var counter =10;
        var $counter = $("#counter");
        setInterval(function () {
            if(counter===1){
                location.href='/form/list';
            }else {
                counter--;
                $counter.text(counter);
            }

        },1000)
    });
</script>
<#include "footer.ftl"/>

