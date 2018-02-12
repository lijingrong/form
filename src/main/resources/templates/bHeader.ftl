<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>在线表单设计工具</title>
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
</head>

<body>
<header>
    <div class="navbar navbar-white fixed-top bg-white border-bottom box-shadow">
        <div class="d-flex justify-content-between" style="width: 100%">
            <a href="/" class="navbar-brand d-flex align-items-center">
                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none"
                     stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="mr-2">
                    <path d="M23 19a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h4l2-3h6l2 3h4a2 2 0 0 1 2 2z"></path>
                    <circle cx="12" cy="13" r="4"></circle>
                </svg>
                <strong>Form</strong>
            </a>
            <div id="formEditSteps">
                <a class="btn" href="/builder/${form.id}">编辑</a>
                >
                <a class="btn" href="/form/${form.id}/skin">皮肤</a>
                >
                <a class="btn" href="/form/list">发布</a>
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
