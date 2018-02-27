package com.landai.form.repository;

import com.landai.form.FormApplicationTests;
import com.landai.form.model.Authority;
import com.landai.form.model.SystemRole;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

public class AuthorityRepositoryTest extends FormApplicationTests{

    @Autowired
    AuthorityRepository authorityRepository;

    @Test
    public void addAuthority(){
        authorityRepository.save(new Authority("user1", SystemRole.ROLE_ADMIN.name()));
    }
}
