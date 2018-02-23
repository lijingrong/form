<#include "bHeader.ftl">
<div class="container" style="margin-top: 70px">
    <div id="formQrCodeContainer">

    </div>
    <form>
        <button type="submit" class="btn btn-primary">发布</button>
    </form>
</div>
<script type="text/javascript">
    $(function () {
        $.ajax({
            method:'get',
            url:'/form/qrcode/${form.id}'
        }).done(function (data) {
            $('#formQrCodeContainer').append($('<img>').attr('src','http://img.dan-ye.com/'+data.ossName));
        })
    })
</script>
<#include "footer.ftl">