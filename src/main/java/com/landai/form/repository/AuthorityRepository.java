package com.landai.form.repository;

import com.landai.form.model.Authority;
import com.landai.form.model.AuthorityKey;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AuthorityRepository extends JpaRepository<Authority, AuthorityKey> {

}
