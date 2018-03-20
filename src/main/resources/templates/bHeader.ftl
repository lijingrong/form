<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="author" content="">
    <meta name="baidu-site-verification" content="tcScOAfJRu"/>
    <title>在线表单设计工具</title>
    <meta name="keywords" content="表单,单页表单,表单设计,在线表单,数据分析,调查问卷,满意度调查,客户关系管理,反馈表,登记表">
    <meta name="description"
          content="单页表单一款在线表单设计工具,帮助用户轻松完成表单设计和数据收集工作">
    <link rel="shortcut icon" href="/static/images/favicon.ico"/>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link href="/static/css/index.css" rel="stylesheet">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css">
    <link rel="stylesheet" href="/static/css/builder.css">
    <script src="//code.jquery.com/jquery-1.12.4.js"></script>
    <script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="https://cdn.bootcss.com/jquery-validate/1.17.0/jquery.validate.min.js"></script>
    <script src="https://cdn.bootcss.com/jquery-validate/1.17.0/additional-methods.min.js"></script>
    <script src="/static/js/messages_zh.js"></script>
    <script src="https://cdn.bootcss.com/device.js/0.2.7/device.min.js"></script>
    <script src="/static/laydate/laydate.js"></script>
    <script src="//unpkg.com/wangeditor/release/wangEditor.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/lazyload@2.0.0-beta.2/lazyload.js"></script>
    <script>
        var _hmt = _hmt || [];
        (function() {
            var hm = document.createElement("script");
            hm.src = "https://hm.baidu.com/hm.js?53ab1dc142267ed6eddcda3a5c898044";
            var s = document.getElementsByTagName("script")[0];
            s.parentNode.insertBefore(hm, s);
        })();
    </script>

</head>

<body>
<header>
    <div class="navbar navbar-white fixed-top bg-white border-bottom box-shadow">
        <div class="d-flex justify-content-between" style="width: 100%">
            <a href="/" class="navbar-brand d-flex align-items-center">
                <img src="/static/images/logo.png" style="width: 30px">
                <strong>单页表单</strong>
            </a>
            <div id="formEditSteps">
                <a class="btn" href="/builder/${form.id}">编辑</a>
                >
                <a class="btn" href="/form/${form.id}/publish">发布</a>
            </div>

            <#if currentUser??>
                <a class="btn btn-outline-primary" href="/form/list">我的表单</a>
            <#else >
                <a href="/login" class="btn btn-secondary">登录</a>
            </#if>
        </div>
    </div>
</header>
<script type="text/javascript">
    $(document).ready(function () {
        var pathName = window.location.pathname;
        $("#formEditSteps").find("a.btn").each(function () {
            var $this = $(this);
            if(pathName === $this.attr("href")){
                $this.addClass("btn-outline-primary")
            }else{
                $this.addClass("btn-outline-secondary");
            }
        });

    })
</script>

