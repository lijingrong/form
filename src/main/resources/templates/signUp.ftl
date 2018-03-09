<#include "header.ftl"/>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.17.0/jquery.validate.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.17.0/additional-methods.min.js"></script>
<script src="/static/js/messages_zh.js"></script>
<div class="bg-light">
    <div class="container" style="max-width: 400px;padding: 50px 0">
        <form id="signUp" method="post" action="/signUp" autocomplete="off">
            <div class="form-group">
                <label for="telephone">手机号：</label>
                <input id="telephone" type="text" class="form-control" name="telephone" autofocus>
            </div>
            <div class="form-group">
                <label for="verifyCode">验证码：</label>
                <div class="row">
                    <div class="col-4"><input id="verifyCode" type="text" class="form-control" name="verifyCode"></div>
                    <div class="col-4"><img id="verifyCodeImg" src="/anon/verifyCode"></div>
                    <div class="col-4"><a href='#' onclick="javascript:changeImg()">看不清？换一个</a></div>
                </div>
            </div>
            <div class="form-group">
                <label for="phoneCode">短信验证码：</label>
                <div class="row">
                    <div class="col-8"><input id="phoneCode" type="text" class="form-control" name="phoneCode"></div>
                    <div class="col-4"><button type="button" id="phoneCodeBtn" class="btn btn-outline-primary">获取验证码</button></div>
                </div>
            </div>
            <div class="form-group">
                <label for="password">密码：</label>
                <input id="password" type="password" class="form-control" name="password">
            </div>
            <div class="form-group">
                <label for="confirmPassword">确认密码：</label>
                <input id="confirmPassword" type="password" class="form-control" name="confirmPassword">
            </div>
            <#--<div class="form-group">
                <label for="nickname">昵称：</label>
                <input type="text" class="form-control" name="nickname" id="nickname">
            </div>
            <div class="form-group">
                <label for="organization">单位/组织：</label>
                <input type="text" class="form-control" name="organization" id="organization">
            </div>-->
            <button class="btn btn-lg btn-primary btn-block" type="submit">注册账号</button>
        </form>
    </div>
</div>

<script type="text/javascript">

    $('#phoneCodeBtn').click(function () {
        var $this = $(this);
        var telephone = $('#telephone');
        var verifyCode = $('#verifyCode');
        telephone.validate();
        verifyCode.validate();
        if(telephone.valid() && verifyCode.valid()){
            var countdown=60;
            function settime() {
                if (countdown === 0) {
                    $this.removeAttr("disabled");
                    $this.text("获取验证码");
                    countdown = 60;
                    return;
                } else {
                    $this.attr("disabled",true);
                    $this.text("重新发送(" + countdown + ")");
                    countdown--;
                }
                setTimeout(function() { settime() },1000);
            }
            settime();
            $.ajax({
                method:'get',
                url:'/anon/phoneCode',
                data:{telephone:telephone.val(),verifyCode:verifyCode.val()}
            }).done(function (data) {
                if(data.success ==='true'){
                    $("#phoneCode").val(data.phoneCode);
                }else if(data.success==='false' && data.verifyCode==='error'){
                    console.log("verifyCode error");
                    verifyCode.after('<label id="verifyCode-error" class="error" for="verifyCode">验证码输入错误</label>')
                }
            });
        }
    });
    function changeImg() {
        $('#verifyCodeImg').attr("src", "/anon/verifyCode?date=" + new Date());
    }

    jQuery.validator.addMethod("telephone", function (value, element) {
        return this.optional(element) || /^(13[0-9]|14[579]|15[0-9]|17[0135678]|18[0-9])[0-9]{8}$|^09[0-9]{8}$|^[5|6|9][0-9]{7}$/.test(value);
    }, "请输入合法的手机号");

    $('#signUp').validate({
        rules: {
            telephone: {
                required: true,
                telephone: true,
                remote:{
                    url:'/anon/checkTelephone',
                    method:'post'
                }
            },
            password: {
                required: true,
                minlength: 6
            },
            confirmPassword:{
              equalTo:'#password'
            },
            /*nickname: {
                required: true
            },
            organization: {
                required: true
            },*/
            phoneCode:{
                required:true
            },
            verifyCode:{
                required:true
            }
        },
        messages: {
            organization: '没有组织请填写自己的名字哦',
            confirmPassword:"两次输入的密码不一致哦",
            telephone:{
                remote:'手机号已注册，请换个手机号'
            }
        }
    });
</script>
<#include "footer.ftl"/>