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
                    <div class="tab-pane fade show active" id="commonControl" role="tabpanel" aria-labelledby="home-tab">
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
            <div id="formArea"></div>
        </div>
        <div class="col">
            <div id="attributeArea"></div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        var formId = window.location.pathname.split('/')[2];
        $(".control").draggable({revert: "invalid", helper: "clone"});
        $("#formArea").droppable({
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
        $(document).ready(function () {
            $.ajax({
                method: 'get',
                url: '/form/' + formId
            }).done(function (html) {
                $("#formArea").append(html);
                initForm();
            });

            $("#formArea").sortable().disableSelection();
        });

        function initForm() {
            var $controlArea = $("#formArea .control-area");
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
    });

</script>
<#include "footer.ftl"/>