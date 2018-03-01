<form id="formEditForm">
    <div class="modal fade" id="formAttributeModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle"
         aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLongTitle">表单属性</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label>表单名称：<span class="required">*</span></label>
                        <input type="text" class="form-control" id="formTitleInput" autofocus autocomplete="off" required value="${title}">
                    </div>
                    <div>
                        <label>表单描述：</label>
                        <div id="formDescriptionEdit">${description}</div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
                    <button type="submit" class="btn btn-primary">保存</button>
                </div>
            </div>
        </div>
    </div>
</form>

<script type="text/javascript">
    var E = window.wangEditor;
    var editor = new E('#formDescriptionEdit');
    editor.create();
    $('#formAttributeModal').modal('show');
    $('#formEditForm').validate({
        submitHandler: function (form) {
            var formTitle = $("#formTitleInput").val();
            var formDescription = editor.txt.html().replace('<p><br></p>','');
            $.ajax({
                method: 'post',
                url: '/form/'+'${id}'+'/edit',
                data: {title: formTitle, description: formDescription}
            }).done(function (status) {
                $('#formAttributeModal').modal('hide');
                $("#formTitle").empty().append($("<h4>").text(formTitle));
                $("#formDescription").empty().append(formDescription);
            })
        }
    });
</script>