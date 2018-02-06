package com.landai.form.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Service;

/**
 * @author <a href="mailto:jrliwiscom@gmail.com">L.J.R</a>
 *         15/4/10 下午2:14
 */

@PropertySource(value = { "classpath:environment.properties" })
@Service
public class UniqueIDService extends Snowflake {

    @Autowired
    public UniqueIDService(@Value("${node}") int node) {
        super(node);
    }

    public String getUniqueStringID() {
        return String.valueOf(next());
    }

    public Long getUniqueID(){return next();}
}
