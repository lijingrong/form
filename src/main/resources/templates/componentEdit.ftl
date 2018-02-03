<script type="text/javascript">
    var formId = window.location.pathname.split('/')[2];
    var componentId =${id};
    var rules = {};
    <#if validateRules!=''>
        rules = ${validateRules};
    </#if>
    $(document).ready(function () {
        $.each(rules,function (k,v) {
            var $el = $('input[name='+k+']');
            if($el.attr('type') === 'checkbox'){
                $el.attr('checked','checked');
            }else{
                $el.val(v);
            }
        });
        $('#componentRules input').each(function () {
            var $this = $(this);
            if($this.attr('type') ==='checkbox'){
                $this.click(function () {
                    if($(this).is(':checked')){
                        rules[$this.attr('name')]=true;
                    }else{
                        $.each(rules,function (key,value) {
                            if(key===$this.attr('name')){
                                delete rules[key];
                            }
                        });
                    }
                    $.ajax({
                        method: 'post',
                        url: '/form/' + formId + '/component/' + componentId+'/rules',
                        data: {rules:JSON.stringify(rules)}
                    }).done(function (status) {
                        refreshForm();
                    })
                });
            }else if($this.attr('type')==='text'){
                $this.blur(function () {
                    if($(this).val()){
                        rules[$this.attr('name')]=parseInt($(this).val());
                    }else{
                        $.each(rules,function (key,value) {
                            if(key===$this.attr('name')){
                                delete rules[key];
                            }
                        });
                    }
                    $.ajax({
                        method: 'post',
                        url: '/form/' + formId + '/component/' + componentId+'/rules',
                        data: {rules:JSON.stringify(rules)}
                    }).done(function (status) {
                        refreshForm();
                    })
                });
            }
        });

        $('#control_type').change(function () {
            var value = $(this).children('option:selected').val();
            $.ajax({
                method:'post',
                url:'/form/'+formId+'/controlAttribute/'+componentId,
                data:{ruleGroupId:value}
            }).done(function () {
                refreshTab();
            });
        });

        function refreshTab() {
            $.ajax({
                method: 'get',
                url: '/form/' + formId + '/controlAttribute/' + componentId
            }).done(function (html) {
                $("#attributeArea").empty().append(html);
            })
        }

        $('#attributes input,#attributes textarea').each(function () {
            var $this = $(this);
            if($this.attr('type')==='text' ||$this.is('textarea')){
                $this.blur(function () {
                    var data = {};
                    data[$this.attr("name")] = $this.val();
                    $.ajax({
                        method: 'post',
                        url: '/form/' + formId + '/component/' + componentId,
                        data: data
                    }).done(function (status) {
                        refreshForm();
                    })
                });
            }
        });

        function refreshForm() {
            $.ajax({
                method: 'get',
                url: '/form/' + formId
            }).done(function (html) {
                $("#formArea").empty().append(html);
                initForm();
                $("#control_area_" + componentId).addClass("selected");
            });
        }

        $("#controlDataButton").click(function () {
            var value = $('#controlDataValue').val();
            $.ajax({
                method: 'post',
                url: '/form/' + formId + '/componentData/' + componentId,
                data: {value: value}
            }).done(function (status) {
                var newRow = $('<tr><td>' + value + '</td><td><span data="'+value+'" class="deleteData">x</span></td></tr>');
                $('#controlDataTable tr:first').after(newRow);
                $('#controlDataValue').val("");
                bindDeleteData();
                refreshForm();
            });
        });
        var data =[];
        <#if data??&&data!=''>
            data=${data};
            $.each(data,function (i,v) {
                var newRow = $('<tr><td>' + v + '</td><td><span data="'+v+'" class="deleteData">x</span></td></tr>');
                $('#controlDataTable tr:first').after(newRow);
            });
        </#if>
        bindDeleteData();
        function bindDeleteData() {
            $('#controlDataTable span.deleteData').unbind();
            $('#controlDataTable span.deleteData').bind('click',function () {
                var $this = $(this);
                $.ajax({
                    method:'post',
                    url:'/form/'+formId+'/delComponentData/'+componentId,
                    data:{value:$this.attr('data')}
                }).done(function () {
                    $this.parent().parent().empty();
                    refreshForm();
                });
            });
        }

        
    });
</script>
