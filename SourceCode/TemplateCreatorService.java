package com.click.stream.dataset.template;

import java.io.StringWriter;
import java.util.HashMap;
import java.util.Map;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.Version;

// TODO: Auto-generated Javadoc
/** The Class TemplateCreatorService. */
public class TemplateCreatorService {

    /** Creates the template.
     *
     * @param templateDTO
     *            the template DTO
     * @return the string
     * @throws Exception
     *             the exception */
    public String createTemplate(DataSetModel templateDTO) throws Exception {

        Configuration cfg = new Configuration(new Version("2.3.0"));
        cfg.setClassForTemplateLoading(TemplateCreatorService.class, "/");
        cfg.setDefaultEncoding("UTF-8");

        Template template = null;
        String templateString = null;

        template = cfg.getTemplate("datasettemplate.ftl");

        Map<String, Object> templateData = new HashMap<>();
        templateData.put("datamodel", templateDTO);

        StringWriter out = new StringWriter();
        template.process(templateData, out);

        templateString = out.getBuffer().toString();
        out.flush();
        return templateString;
    }
}