package com.landai.form.web;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.landai.form.utils.Constants;
import com.landai.form.utils.OSSUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.io.InputStream;

/**
 * @author <a href="mailto:huangjiang1026@gmail.com">H.J</a> on 2018/3/16 09:14
 */
@Controller
public class UploadController {

    @PostMapping("/upload/singleUpload")
    @ResponseBody
    public ObjectNode anonSingleUpload(MultipartHttpServletRequest request)
            throws Exception {
        ObjectMapper objectMapper = new ObjectMapper();
        String key = request.getFileNames().next();
        ObjectNode objectNode = objectMapper.createObjectNode();
        MultipartFile file = request.getFile(key);
        InputStream is = file.getInputStream();
        int pointIndex = file.getOriginalFilename().lastIndexOf(".");
        String postfix = file.getOriginalFilename().substring(pointIndex + 1).toLowerCase();
        String fileName = OSSUtil.upload(is, postfix);
        objectNode.put("fileName", fileName);
        objectNode.put("fileUrl", Constants.IMAGE_DOMAIN + fileName);
        is.close();
        return objectNode;
    }
}
