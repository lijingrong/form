<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>${form.title}</title>
    <meta name="keywords" content="表单,单页表单,表单设计,在线表单,数据分析,调查问卷,满意度调查,客户关系管理,反馈表,登记表">
    <meta name="description"
          content="单页表单一款在线表单设计工具,帮助用户轻松完成表单设计和数据收集工作">
    <link rel="shortcut icon" href="/static/images/favicon.ico"/>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="//code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
            integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
            crossorigin="anonymous"></script>
    <style>

    </style>
</head>
<body class="bg-light">
<header>
    <div class="navbar navbar-white bg-white border-bottom box-shadow">
        <div class="container d-flex justify-content-between">
            <a href="/" class="navbar-brand d-flex align-items-center">
                <img src="/static/images/logo.png" style="width: 30px">
                <strong>单页表单</strong>
            </a>
        </div>
    </div>
</header>
<div class="container form-area">
    <div class="text-center mt-5">
        <#if form.afterPostDesc??>
            <#if form.afterPostDesc==''>
                <h4 class="text-success">感谢您的参与，数据提交成功！</h4>
                <#else >
                ${form.afterPostDesc}
            </#if>
            <#else >
            <h4 class="text-success">感谢您的参与，数据提交成功！</h4>
        </#if>
    </div>
</div>
</body>
</html>