package com.landai.form.repository;

import com.landai.form.model.NameValuePair;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ControlDataRepository extends JpaRepository<NameValuePair,Long> {

    NameValuePair getNameValuePairsByControlId(final String controlId);
}
