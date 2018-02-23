package com.landai.form.repository;

import com.landai.form.model.QRCode;
import org.springframework.data.jpa.repository.JpaRepository;

public interface QRCodeRepository extends JpaRepository<QRCode, Long> {
    
    QRCode findQRCodeByFormId(String formId);
}
