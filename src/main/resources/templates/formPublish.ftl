<#include "bHeader.ftl">
<div class="bg-light">
    <div class="container p-4" style="margin-top: 58px;width: 600px">
        <div class="row">
            <div class="col-6">
                <div>表单二维码：</div>
                <div id="formQrCodeContainer"></div>
            </div>
            <div class="col-6">
                <div>表单链接：</div>
                <div><a target="_blank" href="https://www.dan-ye.com/f/${form.id}">https://www.dan-ye.com/f/${form.id}</a></div>
            </div>
        </div>

        <form id="formPublishForm" method="post">
            <div class="form-group">
                <label>表单提交后的说明：</label>
                <div id="afterPostDesc">${form.afterPostDesc!''}</div>
            </div>
            <button type="submit" class="btn btn-primary">发布</button>
        </form>
    </div>
</div>
<script type="text/javascript">
    var E = window.wangEditor;
    var editor = new E('#afterPostDesc');
    // 自定义菜单配置
    editor.customConfig.menus = [
        'head',  // 标题
        'bold',  // 粗体
        'italic',  // 斜体
        'underline',  // 下划线
        'strikeThrough',  // 删除线
        'foreColor',  // 文字颜色
        'backColor',  // 背景颜色
        'link',  // 插入链接
        'list',  // 列表
        'justify',  // 对齐方式
        'quote',  // 引用
        'table',  // 表格
        'undo',  // 撤销
        'redo'  // 重复
    ];
    editor.create();

    $('#formPublishForm').validate({
        submitHandler: function (form) {
            var afterPostDesc = editor.txt.html().replace('<p><br></p>','');
            $.ajax({
                method: 'post',
                url: '/form/'+'${form.id}'+'/publish',
                data: {afterPostDesc: afterPostDesc}
            }).done(function (status) {
                location.href="/form/${form.id}/publishSuccess";
            })
        }
    });
    $(function () {
        $.ajax({
            method:'get',
            url:'/f/qrcode/${form.id}'
        }).done(function (data) {
            $('#formQrCodeContainer').append($('<img>').attr('src','http://img.dan-ye.com/'+data.ossName));
        })
    })
</script>
<#include "footer.ftl">