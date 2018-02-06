<#include "header.ftl"/>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.17.0/jquery.validate.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.17.0/additional-methods.min.js"></script>
<script src="/static/js/messages_zh.js"></script>
<div class="container" style="max-width: 400px;margin-top: 50px">
    <form id="signUp" method="post" action="/signUp" autocomplete="off">
        <div class="form-group">
            <label for="telephone">手机号：</label>
            <input id="telephone" type="text" class="form-control" name="telephone">
        </div>
        <div class="form-group">
            <label for="password">密码：</label>
            <input id="password" type="password" class="form-control" name="password">
        </div>
        <div class="form-group">
            <label for="organization">组织：</label>
            <input type="text" class="form-control" name="organization" id="organization">
        </div>
        <div class="form-group">
            <label for="nickname">昵称：</label>
            <input type="text" class="form-control" name="nickname" id="nickname">
        </div>
        <button class="btn btn-lg btn-primary btn-block" type="submit">注册账号</button>
    </form>
</div>
<script type="text/javascript">
    jQuery.validator.addMethod("telephone", function(value, element) {
        return this.optional(element) || /^(13[0-9]|14[579]|15[0-9]|17[0135678]|18[0-9])[0-9]{8}$|^09[0-9]{8}$|^[5|6|9][0-9]{7}$/.test(value);
    }, "请输入合法的手机号");

    $('#signUp').validate({
        rules:{
            telephone:{
                required:true,
                telephone:true
            },
            password:{
                required:true,
                minlength:6
            },
            nickname:{
                required:true
            },
            organization:{
                required:true
            }
        },
        messages:{
            organization:'没有组织请填写自己的名字哦'
        }
    });
</script>
<#include "footer.ftl"/>