<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="baidu-site-verification" content="tcScOAfJRu"/>
    <meta name="author" content="单页表单">
    <title>单页表单-登录</title>
    <meta name="keywords" content="表单,单页表单,表单设计,在线表单,数据分析,调查问卷,满意度调查,客户关系管理,反馈表,登记表">
    <meta name="description"
          content="单页表单一款在线表单设计工具,帮助用户轻松完成表单设计和数据收集工作">
    <link rel="shortcut icon" href="/static/images/favicon.ico"/>
    <!-- Bootstrap core CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

    <!-- Custom styles for this template -->
    <link href="/static/css/signin.css" rel="stylesheet">
</head>

<body class="text-center">
<form class="form-signin" method="post" action="/login">
    <img class="mb-4" src="/static/images/logo-l.png" alt="" width="72" height="72">
    <h1 class="h3 mb-3 font-weight-normal">请登录</h1>
    <label for="inputEmail" class="sr-only">Email address</label>
    <input id="inputEmail" name="username" class="form-control"  placeholder="手机" required autofocus>
    <label for="inputPassword" class="sr-only">Password</label>
    <input type="password" name="password" id="inputPassword" class="form-control" placeholder="密码" required>
    <div class="checkbox mb-3">
        <label>
            <input type="checkbox" value="remember-me"> 记住密码
        </label>
        <a href="/signUp">注册账号</a>
    </div>
    <#if error??>
        <div class="alert alert-danger" role="alert">
            手机或密码错误
        </div>
    </#if>
    <button class="btn btn-lg btn-primary btn-block" type="submit">登录</button>
    <p class="mt-5 mb-3 text-muted">&copy; 2018-2019</p>
</form>
</body>
</html>
