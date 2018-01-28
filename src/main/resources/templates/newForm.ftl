<#include "header.ftl"/>
    <div class="py-5 bg-light">
        <div style="width: 50%;margin: 0 auto">
            <form method="post" action="/form/new">
                <div class="form-group">
                    <label for="title">标题</label>
                    <input type="text" class="form-control" id="title" aria-describedby="titleHelp" placeholder="请输入标题">
                    <small id="titleHelp" class="form-text text-muted"></small>
                </div>
                <div class="form-group">
                    <label for="description">描述</label>
                    <textarea class="form-control" id="description" placeholder="请输入描述"></textarea>
                </div>
                <button type="submit" class="btn btn-primary">提交</button>
            </form>
        </div>
    </div>
<#include "footer.ftl"/>