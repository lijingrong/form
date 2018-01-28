<html>
<head>
    <meta charset="utf-8">
    <title>表单设计器</title>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css">
    <style>
        #controlArea {
            width: 300px;
            height: 700px;
            margin-left: 10px;
            margin-top: 50px;
        }

        #formArea {
            position: absolute;
            left: 400px;
            top: 50px;
            width: 600px;
            height: 700px;
            padding: 15px;
        }

        .control {
            background: #ccc;
        }

        #attributeArea {
            position: absolute;
            right: 10px;
            top: 50px;
            width: 300px;
            height: 700px;
        }

        .delete {
            cursor: pointer;
        }
        .required{
            color: red;
        }
        .selected{
            background-color: #cccccc;
        }
        .mouse_over{
            border:1px dashed #cccccc;
        }
    </style>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/css/bootstrap.min.css"
          integrity="sha384-Zug+QiDoJOrZ5t4lssLdxGhVrurbmBWopoEl+M6BdEfwnCJZtKxi1KgxUyJq13dy" crossorigin="anonymous">
    <script src="//code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/js/bootstrap.min.js"
            integrity="sha384-a5N7Y/aK3qNeh15eJKGWxsqtnX/wWdSZSKp+81YjTmS15nvnvxKHuzaWwXHDli+4"
            crossorigin="anonymous"></script>
    <script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.17.0/jquery.validate.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.17.0/additional-methods.min.js"></script>
    <script src="/static/script/messages_zh.js"></script>
</head>
<body>
<div id="formArea" class="ui-widget-content"></div>

<div id="controlArea">
    <div>
        <div>常用控件</div>
    </div>
    <div>
        <ul class="list-group">
            <li class="list-group-item control" controlName="name" common="true">姓名</li>
            <li class="list-group-item control" controlName="gender" common="true">性别</li>
            <li class="list-group-item control" controlName="telephone" common="true">手机号</li>
            <li class="list-group-item control" controlName="email" common="true">邮箱</li>
            <li class="list-group-item control" controlName="idCard" common="true">身份证</li>
            <li class="list-group-item control" controlName="education" common="true">学历</li>
            <li class="list-group-item control" controlName="hobby" common="true">兴趣</li>
            <li class="list-group-item control" controlName="description" common="true">简介</li>
            <li class="list-group-item control" controlName="url" common="true">网址</li>
        </ul>
    </div>
    <div>
        <div>自定义控件</div>
        <ul class="list-group">
            <li class="list-group-item control" controlType="text" common="false"><span>文本</span></li>
            <li class="list-group-item control" controlType="select" common="false"><span>下拉</span></li>
            <li class="list-group-item control" controlType="radio" common="false"><span>单选</span></li>
            <li class="list-group-item control" controlType="checkbox" common="false"><span>多选</span></li>
            <li class="list-group-item control" controlType="textarea" common="false"><span>多行文本</span></li>
        </ul>
    </div>
</div>
<div id="attributeArea"></div>
<script>
    var formId = window.location.pathname.split('/')[2];
    $(".control").draggable({revert: "invalid", helper: "clone"});
    $("#formArea").droppable({
        drop: function (event, ui) {
            var $this = $(this);
            if (ui.helper.attr("common") === 'true') {
                $.ajax({
                    method: "get",
                    url: "/form/" + formId + "/getControl",
                    data: {name: ui.helper.attr("controlName")}
                }).done(function (html) {
                    console.log(html);
                    $this.append(html);
                    initForm();
                });
            } else {
                $.ajax({
                    method: "get",
                    url: "/form/" + formId + "/getControl",
                    data: {type: ui.helper.attr("controlType")}
                }).done(function (html) {
                    $this.append(html);
                    initForm();
                });
            }

        }
    });
    $(document).ready(function () {
        $.ajax({
            method: 'get',
            url: '/form/' + formId
        }).done(function (html) {
            $("#formArea").append(html);
            initForm();
        });

    });

    function initForm() {
        $("#formArea .form-group").unbind();
        $("#formArea .form-group").mouseover(function () {
            var $this = $(this);
            if(!$this.hasClass("selected")){
                $this.addClass("mouse_over");
            }
            $this.find('.delete').bind("click", function (event) {
                $.ajax({
                    method: 'post',
                    url: '/form/' + formId + '/deleteControl',
                    data: {controlId: $this.attr('id').split('_')[2]}
                }).done(function () {
                    $this.remove();
                });
                event.stopPropagation();
            }).show();
        });
        $("#formArea .form-group").mouseout(function () {
            $(this).removeClass("mouse_over");
            $(this).find('.delete').unbind().hide();
        });
        $("#formArea .form-group").bind("click", function () {
            $("#formArea div.selected").removeClass("selected");
            var $this = $(this);
            $this.addClass("selected");
            $.ajax({
                method: 'get',
                url: '/form/' + formId + '/controlAttribute/' + $this.attr('id').split('_')[2]
            }).done(function (html) {

                $("#attributeArea").empty().append(html);
            })
        });
    }
</script>

</body>
</html>
</html>
