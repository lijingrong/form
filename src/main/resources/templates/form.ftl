<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>${form.title}</title>
    <link rel="shortcut icon" href="/static/images/favicon.ico"/>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="//code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
            integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
            crossorigin="anonymous"></script>
    <script src="https://cdn.bootcss.com/jquery-validate/1.17.0/jquery.validate.min.js"></script>
    <script src="https://cdn.bootcss.com/jquery-validate/1.17.0/additional-methods.min.js"></script>
    <script src="/static/js/messages_zh.js"></script>
    <script src="/static/js/jquery.form.min.js"></script>
    <script src="https://cdn.bootcss.com/device.js/0.2.7/device.min.js"></script>
    <script src="/static/js/require.js"></script>
    <script src="/static/js/validate-card-num.js"></script>
    <style>
        .required {
            color: red;
        }

        .form-area {
            padding-top: 10px;
            padding-bottom: 10px;
            max-width: 600px;
            box-shadow: 0 .25rem .75rem rgba(0, 0, 0, .05);
        }

        .error {
            color: red;
        }
        .qr_code_pc {
            position: absolute;
            right: 140px;
            top: 0;
            width: 140px;
            padding: 16px;
            border: 1px solid #d9dadc;
            background-color: #fff;
            word-wrap: break-word;
            word-break: break-all;
            text-align: center;
        }
        .qr_code_pc img{
            width: 102px;
        }
    </style>
</head>
<body class="bg-light">
<div class="container form-area">
    <#if form.status =='DRAFT'>
        <div class="alert alert-warning" role="alert">
            表单为草稿状态，无法提交数据！
        </div
    </#if>
    <form id="form" method="post">
        <div>${form.description}</div>
    <#list components as component >
        <div>${component.html}</div>
    </#list>
        <div class="text-center">
            <button class="btn btn-primary" type="submit">提交</button>
        </div>
        <div class="text-center mt-5">
           <span>由</span><a href="https://www.dan-ye.com">单页表单</a><span>提供技术支持</span>
        </div>
    </form>
</div>
<div id="formQrCode" class="qr_code_pc" style="display:none">
    <p>手机扫一扫<br>微信分享</p>
</div>
<script>
    (function ($) {
        $.fn.serializeFormJSON = function () {

            var o = {};
            var a = this.serializeArray();
            $.each(a, function () {
                if (o[this.name]) {
                    if (!o[this.name].push) {
                        o[this.name] = [o[this.name]];
                    }
                    o[this.name].push(this.value || '');
                } else {
                    o[this.name] = this.value || '';
                }
            });
            return o;
        };
        if(device.desktop()){
            $.ajax({
                method:'get',
                url:'/f/qrcode/${form.id}'
            }).done(function (data) {
                $('#formQrCode p').before($('<img>').attr('src','http://img.dan-ye.com/'+data.ossName));
                $('#formQrCode').show();
            })
        }

    })(jQuery);
    jQuery.validator.addMethod("telephone", function(value, element) {
        return this.optional(element) || /^(13[0-9]|14[579]|15[0-9]|17[0135678]|18[0-9])[0-9]{8}$|^09[0-9]{8}$|^[5|6|9][0-9]{7}$/.test(value);
    }, "请输入合法的手机号");
    jQuery.validator.addMethod("idCard",function (value,element) {
        return this.optional(element) || new IdCardValidate(value).CheckValid(value);
    },"请输入合法的身份证号");
    $("#form").validate({
        submitHandler: function (form) {
            var data = $(form).serializeFormJSON();
            $.ajax({
                method: 'post',
                url: window.location.pathname,
                data: {formValue: JSON.stringify(data)}
            }).done(function (status) {
                window.location.href = status.redirectUrl;
            });
        }
    });
</script>
</body>
</html>