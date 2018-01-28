<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Welcome!</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/css/bootstrap.min.css"
          integrity="sha384-Zug+QiDoJOrZ5t4lssLdxGhVrurbmBWopoEl+M6BdEfwnCJZtKxi1KgxUyJq13dy" crossorigin="anonymous">
    <script src="//code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/js/bootstrap.min.js"
            integrity="sha384-a5N7Y/aK3qNeh15eJKGWxsqtnX/wWdSZSKp+81YjTmS15nvnvxKHuzaWwXHDli+4"
            crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.17.0/jquery.validate.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.17.0/additional-methods.min.js"></script>
    <script src="/static/script/messages_zh.js"></script>
    <style>
        .required{
            color: red;
        }
        .form-area{
            max-width: 800px;
            margin: 5px auto;
        }
        .error{
            color:red;
        }
    </style>
</head>
<body>
<div class="form-area">
    <form id="form">
    <#list controls as control >
        <div>${control.html}</div>
    </#list>
        <div class="form-group row">
            <div class="col-3"></div>
            <div class="col-7">
                <button class="btn btn-primary" type="submit">提交</button>
            </div>
        </div>

    </form>
</div>

<script>
    $("#form").validate();
</script>
</body>
</html>