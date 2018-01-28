package com.landai.form.service;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import freemarker.template.TemplateExceptionHandler;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.io.StringWriter;

@Service
public class RenderControlService {

    public String getRenderHtml(String view, Object root) {
        /* ------------------------------------------------------------------------ */
        /* You should do this ONLY ONCE in the whole application life-cycle:        */

        /* Create and adjust the configuration singleton */
        Configuration cfg = new Configuration(Configuration.VERSION_2_3_27);
        //cfg.setDirectoryForTemplateLoading(new File("/where/you/store/templates"));
        cfg.setClassLoaderForTemplateLoading(Thread.currentThread().getContextClassLoader(),"/templates");
        cfg.setDefaultEncoding("UTF-8");
        cfg.setTemplateExceptionHandler(TemplateExceptionHandler.RETHROW_HANDLER);
        cfg.setLogTemplateExceptions(false);
        cfg.setWrapUncheckedExceptions(true);

        /* ------------------------------------------------------------------------ */
        /* You usually do these for MULTIPLE TIMES in the application life-cycle:   */

        /* Get the template (uses cache internally) */
        Template temp = null;
        /* Merge data-model with template */
        StringWriter writer = new StringWriter();
        try {
            temp = cfg.getTemplate(view);
            temp.process(root, writer);
        } catch (TemplateException | IOException e) {
            e.printStackTrace();
        }
        return writer.toString();
    }

}
