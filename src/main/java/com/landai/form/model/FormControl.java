package com.landai.form.model;

/**
 *  表单控件最顶层抽象
 */
public interface FormControl {

    /**
     * 控件渲染
     * @return 控件html 片段
     */
    String getHtml();

    /**
     *
     * @return 控件的ftl 模板名称
     */
    String getViewName();


}
