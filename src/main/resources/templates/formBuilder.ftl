<#include "bHeader.ftl"/>
<div class="bg-light">
    <div class="container">
        <div class="row">
            <div class="col">
                <div id="controlArea">
                    <div class="container">
                        <div class="row border p-2  bg-light text-dark"><h6>常用控件</h6></div>
                        <div class="row">
                            <#list commonComponents>
                                <#items as component>
                                    <div class="col-4 text-center control <#if component_index%3==0>border border-top-0 <#else>border-bottom border-right</#if>"
                                         componentName="${component.name}"
                                         common="true"><span>${component.label}</span></div>
                                </#items>
                            </#list>
                            <#assign commonSize=3-commonComponents?size%3>
                            <#switch commonSize>
                                <#case 1>
                                    <div class="col-4 border-bottom border-right"></div>
                                    <#break>
                                <#case 2>
                                    <div class="col-4 border-bottom border-right"></div>
                                    <div class="col-4 border-bottom border-right"></div>
                                    <#break>
                            </#switch>
                        </div>
                    </div>
                    <div class="container mt-3">
                        <div class="row border p-2  bg-light text-dark"><h6>自定义控件</h6></div>
                        <div class="row">
                            <#list customComponents>
                                <#items as component>
                                      <div class="col-4 text-center control <#if component_index%3==0>border border-top-0 <#else>border-bottom border-right</#if>"
                                           componentName="${component.name}"><span>${component.label}</span></div>
                                </#items>
                            </#list>
                            <#assign customSize=3-customComponents?size%3>
                            <#switch customSize>
                                <#case 1>
                                    <div class="col-4 border-bottom border-right"></div>
                                    <#break>
                                <#case 2>
                                    <div class="col-4 border-bottom border-right"></div>
                                    <div class="col-4 border-bottom border-right"></div>
                                    <#break>
                            </#switch>
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
        <div class="row" style="height: 1px;"></div>
    </div>
</div>

<div id="formEditContainer"></div>

<script>
    var formId = window.location.pathname.split('/')[2];

    $(document).ready(function () {
        $(".control").draggable({cursor: "move",revert: "invalid", helper: "clone"});
        $("#formControlsArea").droppable({
            accept: '.control',
            drop: function (event, ui) {
                var $this = $(this);
                $.ajax({
                    method: "get",
                    url: "/form/" + formId + "/getComponent",
                    data: {componentName: ui.helper.attr("componentName")}
                }).done(function (html) {
                    $this.find("div.componentDropArea").remove();
                    $this.append(html);
                    initForm();
                });
            },
            over:function (event,ui) {
                console.log("over");
                var $this = $(this);
                $this.append($('<div>').addClass("componentDropArea"));
            },
            out:function (event,ui) {
                console.log("out");
                var $this = $(this);
                $this.find("div.componentDropArea").remove();
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
        var $controlArea = $("#formControlsArea div.control-area");
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
                    subtractControlsHeight($this.height() + 16);
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
        addControlsHeight(90);
    }

    // 增加 formControlsArea 区域高度
    function addControlsHeight($h) {
        var $height = 0;

        $("#formControlsArea div.control-area").each(function () {
            $height = $height + $(this).height() + 16;  // 两个控件之间的高度
        });

        if ($height >= 460) {
            $("#formControlsArea").height($height + $h);
        }
    }

    // 减少 formControlsArea 区域高度
    function subtractControlsHeight($h) {
        var $height = $("#formControlsArea").height();

        if ($height <= 600) {
            $("#formControlsArea").height(600);
        } else {
            $("#formControlsArea").height($height - $h);
        }
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