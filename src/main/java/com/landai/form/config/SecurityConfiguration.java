package com.landai.form.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.password.MessageDigestPasswordEncoder;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import javax.sql.DataSource;

@Configuration
public class SecurityConfiguration extends WebSecurityConfigurerAdapter {

    public static final String DEF_USERS_BY_USERNAME_QUERY = "select username,password,enabled "
            + "from users " + "where telephone = ?";

    @Qualifier("dataSource")
    @Autowired
    private DataSource dataSource;

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.csrf().disable().authorizeRequests().antMatchers("/","/signUp","/f/**","/anon/**").permitAll().anyRequest()
                .fullyAuthenticated().and().formLogin().loginPage("/login").defaultSuccessUrl("/form/list")
                .failureUrl("/loginError").permitAll().and().logout().
                logoutRequestMatcher(new AntPathRequestMatcher("/logout")).
                invalidateHttpSession(true).permitAll();
    }

    @Override
    public void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.jdbcAuthentication().usersByUsernameQuery(DEF_USERS_BY_USERNAME_QUERY)
                .dataSource(this.dataSource).passwordEncoder(new MessageDigestPasswordEncoder("MD5"));
    }

    @Override
    public void configure(WebSecurity web) throws Exception {
        web.ignoring().mvcMatchers("/static/**");
    }
}
