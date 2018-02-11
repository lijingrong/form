<#include "header.ftl"/>
<div class="container">
    <div class="row">
        <div class="col">
            <div id="controlArea">
                <ul class="nav nav-tabs" id="controlAreaTab" role="tablist">
                    <li class="nav-item">
                        <a class="nav-link active" id="common-tab" data-toggle="tab" href="#commonControl" role="tab"
                           aria-controls="home"
                           aria-selected="true">常用控件</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" id="custom-tab" data-toggle="tab" href="#customControl"
                           role="tab" aria-controls="profile" aria-selected="false">自定义控件</a>
                    </li>
                </ul>
                <div class="tab-content" id="controlAreaTabContent">
                    <div class="tab-pane fade show active" id="commonControl" role="tabpanel"
                         aria-labelledby="home-tab">
                        <ul class="list-group">
                <#list components as component>
                    <#if component.isCommon>
                        <li class="list-group-item control" componentName="${component.name}"
                            common="true">${component.label}</li>
                    </#if>
                </#list>
                        </ul>
                    </div>
                    <div class="tab-pane fade" id="customControl" role="tabpanel" aria-labelledby="home-tab">
                        <ul class="list-group">
                <#list components as component>
                    <#if !component.isCommon>
                        <li class="list-group-item control" componentName="${component.name}"
                            common="true">${component.label}</li>
                    </#if>
                </#list>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <div class="col">
            <div id="formArea">
                <div id="formTitle"><h4>${form.title}</h4></div>
                <div id="formDescription">${form.description}</div>
                <div id="formControlsArea"></div>
            </div>
        </div>
        <div class="col">
            <div id="attributeArea"></div>
        </div>
    </div>
    <div class="row" style="margin: 15px;">
        <div class="col-5"></div>
        <div class="col-7">
            <button class="btn btn-primary" type="button" id="formSubmitButton">提交</button>
        </div>
    </div>
</div>
<div id="formEditContainer"></div>

<script>
    var formId = window.location.pathname.split('/')[2];

    $(document).ready(function () {
        $(".control").draggable({revert: "invalid", helper: "clone"});
        $("#formControlsArea").droppable({
            accept: '.control',
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
        $.ajax({
            method: 'get',
            url: '/form/' + formId
        }).done(function (html) {
            $("#formControlsArea").append(html);
            initForm();
        });

        $("#formSubmitButton").bind("click", function () {
            var $array = [];
            $("#formControlsArea div.control-area").each(function () {
                var index = $("#formControlsArea div.control-area").index($(this));
                var _json = {id: $(this).attr('id').split('_')[2], orders: index + 1};
                $array.push(_json);
            });

            if ($array.length > 0) {
                $("#formSubmitButton").attr("disabled", "disabled").text("提交中...");
                $.ajax({
                    method: "post",
                    url: "/form/" + formId + "/save",
                    data: {components: JSON.stringify($array)}
                }).done(function () {
                    $("#formSubmitButton").attr("disabled", false).text("提交");
                    window.location.href = "/form/list";
                });
            } else {
                window.location.href = "/form/list";
            }
        });
    });

    function initForm() {
        $("#formControlsArea").sortable().disableSelection();
        var $controlArea = $("#formControlsArea .control-area");
        $controlArea.unbind();
        $controlArea.mouseover(function () {
            var $this = $(this);
            if (!$this.hasClass("selected")) {
                $this.addClass("mouse_over");
            }
            $this.find('.delete').bind("click", function () {
                $.ajax({
                    method: 'post',
                    url: '/form/' + formId + '/deleteComponent',
                    data: {componentId: $this.attr('id').split('_')[2]}
                }).done(function () {
                    $this.remove();
                    $("#attributeArea").empty();
                });
                return false;
            }).show();
        });
        $controlArea.mouseout(function () {
            $(this).removeClass("mouse_over");
            $(this).find('.delete').unbind().hide();
        });
        $controlArea.bind("click", function () {
            $("#formControlsArea div.selected").removeClass("selected");
            var $this = $(this);
            $this.addClass("selected");
            $.ajax({
                method: 'get',
                url: '/form/' + formId + '/componentEdit/' + $this.attr('id').split('_')[2]
            }).done(function (html) {
                $("#attributeArea").empty().append(html);
            })
        });
        $("#formTitle,#formDescription").unbind().bind('click', function () {
            $.ajax({
                method: 'get',
                url: '/form/' + formId + '/edit'
            }).done(function (html) {
                $('#formEditContainer').empty().append(html);
            })
        });
    }

    function refreshForm() {
        $.ajax({
            method: 'get',
            url: '/form/' + formId
        }).done(function (html) {
            $("#formControlsArea").empty().append(html);
            initForm();
            $("#control_area_" + componentId).addClass("selected");
        });
    }
</script>
<#include "footer.ftl"/>