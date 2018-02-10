<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>${form.title}</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/css/bootstrap.min.css"
          integrity="sha384-Zug+QiDoJOrZ5t4lssLdxGhVrurbmBWopoEl+M6BdEfwnCJZtKxi1KgxUyJq13dy" crossorigin="anonymous">
    <script src="//code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
            integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
            crossorigin="anonymous"></script>
    <script src="https://cdn.bootcss.com/jquery-validate/1.17.0/jquery.validate.min.js"></script>
    <script src="https://cdn.bootcss.com/jquery-validate/1.17.0/additional-methods.min.js"></script>
    <script src="/static/js/messages_zh.js"></script>
    <script src="/static/js/jquery.form.min.js"></script>
    <script src="https://cdn.bootcss.com/device.js/0.2.7/device.min.js"></script>
    <style>
        .required {
            color: red;
        }

        .form-area {
            max-width: 800px;
            margin: 5px auto;
            padding: 5px 10px;
        }

        .error {
            color: red;
        }
    </style>
</head>
<body>
<div class="form-area">
    <form id="form" method="post">
    <#list components as component >
        <div>${component.html}</div>
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
    })(jQuery);

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