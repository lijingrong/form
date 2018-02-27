package com.landai.form.repository;

import com.landai.form.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, String> {

    User getUserByTelephone(final String telephone);
}
