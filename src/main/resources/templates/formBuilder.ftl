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
            min-height: 700px;
            padding: 15px;
            background-image: url("/static/images/2px.png");
        }

        .control {
            background: #ccc;
        }
        .control-area{

        }
        #attributeArea {
            position: absolute;
            right: 10px;
            top: 50px;
            width: 300px;
            height: 700px;
        }

        .delete,.deleteData {
            cursor: pointer;
        }
        .required{
            color: red;
        }
        .selected{
            border:1px dashed #cccccc;
            padding: 3px 3px;
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
    <script src="/static/js/messages_zh.js"></script>
</head>
<body>
<div id="formArea"></div>

<div id="controlArea">

    <ul class="nav nav-tabs" id="controlAreaTab" role="tablist">
        <li class="nav-item">
            <a class="nav-link active" id="common-tab" data-toggle="tab" href="#commonControl" role="tab" aria-controls="home"
               aria-selected="true">常用控件</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" id="custom-tab" data-toggle="tab" href="#customControl"
               role="tab" aria-controls="profile" aria-selected="false">自定义控件</a>
        </li>
    </ul>
    <div class="tab-content" id="controlAreaTabContent">
        <div class="tab-pane fade show active" id="commonControl" role="tabpanel" aria-labelledby="home-tab">
            <ul class="list-group">
                <#list components as component>
                    <#if component.isCommon>
                        <li class="list-group-item control" componentName="${component.name}" common="true">${component.label}</li>
                    </#if>
                </#list>
            </ul>
        </div>
        <div class="tab-pane fade" id="customControl" role="tabpanel" aria-labelledby="home-tab">
            <ul class="list-group">
                <#list components as component>
                    <#if !component.isCommon>
                        <li class="list-group-item control" componentName="${component.name}" common="true">${component.label}</li>
                    </#if>
                </#list>
            </ul>
        </div>
    </div>
</div>
<div id="attributeArea"></div>
<script>
    var formId = window.location.pathname.split('/')[2];
    $(".control").draggable({revert: "invalid", helper: "clone"});
    $("#formArea").droppable({
        drop: function (event, ui) {
            var $this = $(this);
            $.ajax({
                method: "get",
                url: "/form/" + formId + "/getComponent",
                data: {componentName: ui.helper.attr("componentName")}
            }).done(function (html) {
                $this.append(html);
                initForm();
            });
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
        $("#formArea .control-area").unbind();
        $("#formArea .control-area").mouseover(function () {
            var $this = $(this);
            if(!$this.hasClass("selected")){
                $this.addClass("mouse_over");
            }
            $this.find('.delete').bind("click", function (event) {
                $.ajax({
                    method: 'post',
                    url: '/form/' + formId + '/deleteComponent',
                    data: {componentId: $this.attr('id').split('_')[2]}
                }).done(function () {
                    $this.remove();
                });
                event.stopPropagation();
            }).show();
        });
        $("#formArea .control-area").mouseout(function () {
            $(this).removeClass("mouse_over");
            $(this).find('.delete').unbind().hide();
        });
        $("#formArea .control-area").bind("click", function () {
            $("#formArea div.selected").removeClass("selected");
            var $this = $(this);
            $this.addClass("selected");
            $.ajax({
                method: 'get',
                url: '/form/' + formId + '/componentEdit/' + $this.attr('id').split('_')[2]
            }).done(function (html) {
                $("#attributeArea").empty().append(html);
            })
        });
    }
</script>

</body>
</html>
</html>
