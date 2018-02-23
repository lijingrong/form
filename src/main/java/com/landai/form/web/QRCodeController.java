package com.landai.form.web;

import com.landai.form.model.QRCode;
import com.landai.form.repository.QRCodeRepository;
import com.landai.form.utils.Constants;
import com.landai.form.utils.OSSUtil;
import com.landai.form.utils.QRCodeUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class QRCodeController {

    @Autowired
    private QRCodeRepository qrCodeRepository;


    @GetMapping("/f/qrcode/{formId}")
    @ResponseBody
    public QRCode qrcode(@PathVariable("formId") String formId) {
        QRCode qrCode = qrCodeRepository.findQRCodeByFormId(formId);
        if (qrCode != null) return qrCode;
        QRCode storeQRCode = new QRCode();
        storeQRCode.setFormId(formId);
        storeQRCode.setOssName(OSSUtil.upload(QRCodeUtil.generateQRCodeStream(Constants.FORM_DOMAIN + formId)));
        qrCodeRepository.save(storeQRCode);
        return storeQRCode;
    }


}
