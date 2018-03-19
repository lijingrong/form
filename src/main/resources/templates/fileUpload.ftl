<div id="control_area_${id}" class="form-group control-area">
    <label id="control_${id}_label" for="control_${id}">
        <span class="label">${label}:</span>
        <span class="badge badge-light delete" style="display: none; padding: .5em .8em;">x</span>
    </label>

    <small class="form-text text-muted">${description!""}</small>

    <div id="upload_file_control_area_${id}" style="margin-top: .5rem;"></div>

    <link rel="stylesheet" href="/static/webuploader/webuploader.css">

    <script type="text/javascript">
        $(document).ready(function () {
            if (device.mobile() || device.tablet()) {
                $("#upload_file_control_area_${id}").html("上传照片组件目前只支持PC端");
            }
            if (device.desktop()) {
                $("#upload_file_control_area_${id}").html(
                        '<small class="form-text text-muted">支持 jpg, png, jpeg 图片格式；图片需小于5M；目前只支持PC端</small>' +
                        '<div id="upload_control_${id}"></div>' +
                        '<div class="progress progress-striped" id="upload_control_${id}_progress" style="display: none;">' +
                        '    <div class="progress-bar" id="upload_control_${id}_progress_text" role="progressbar"' +
                        '         aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>' +
                        '</div>' +
                        '<img id="preview_control_${id}_img" style="margin-top: .5rem; width: 50%;"/>' +
                        '<input type="hidden" id="control_${id}" name="${name}"/>'
                );

                var uploader = WebUploader.create({
                    auto: true,
                    swf: '/static/webuploader/Uploader.swf',
                    server: "/upload/singleUpload",
                    pick: {
                        id: '#upload_control_${id}',
                        innerHTML: '上传照片',
                        multiple: false
                    },
                    accept: {
                        title: 'Images',
                        extensions: 'jpg,jpeg,png',
                        mimeTypes: 'image/*'
                    }
                });
                uploader.on('uploadProgress', function (file, percentage) {
                    $("#upload_control_${id}_progress").show();
                    $("#upload_control_${id}_progress_text").css("width", percentage * 100 + "%")
                            .text(percentage * 100 + "%");
                });
                uploader.on('uploadSuccess', function (file, data) {
                    $("#control_${id}").val(data["fileUrl"]);
                    $("#preview_control_${id}_img").attr("src", data["fileUrl"]);
                });
                uploader.on('uploadComplete', function () {
                    $("#upload_control_${id}_progress").hide();
                });
            }

            var rules_${id} = {};
        <#if validateRules??&&validateRules!=''>
            rules_${id} = ${validateRules};
        </#if>
            if (rules_${id}.required) {
                $('#control_area_${id} span.label').append('<span class="required">*</span>')
            }
            $("#control_" + ${id}).rules("add", rules_${id});
        });
    </script>
</div>