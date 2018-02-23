<#include "bHeader.ftl">
<div class="bg-light">
    <div class="container p-4" style="margin-top: 58px">
        <div>表单二维码：</div>
        <div id="formQrCodeContainer">

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
    editor.create();
    $('#formPublishForm').validate({
        submitHandler: function (form) {
            var afterPostDesc = editor.txt.html().replace('<p><br></p>','');
            $.ajax({
                method: 'post',
                url: '/form/'+'${form.id}'+'/publish',
                data: {afterPostDesc: afterPostDesc}
            }).done(function (status) {
                location.href="/form/list";
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