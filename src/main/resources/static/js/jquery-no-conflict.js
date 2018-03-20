/* 阻止 require js 引用 jquery 后污染全局变量 jQuery 和 $ */
define(['jquery'], function(jq) {
    return jQuery.noConflict(true);
});