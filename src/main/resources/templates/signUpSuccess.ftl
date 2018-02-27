<#include "header.ftl"/>
<main role="main">
    <div class="container text-center pt-5" style="min-height: 600px">
        <p><h3 class="text-success">恭喜您注册成功！</h3></p>
        <p><span id="counter">5</span>s后自动跳转到登录页</p>
    </div>
</main>
<script type="text/javascript">
    $(document).ready(function () {
        var counter =5;
        var $counter = $("#counter");
        setInterval(function () {
            if(counter===1){
                location.href='/login';
            }else {
                counter--;
                $counter.text(counter);
            }

        },1000)
    });
</script>
<#include "footer.ftl"/>

