package com.landai.form.utils;


import com.landai.form.model.User;

/**
 * @author <a href="mailto:jrliwiscom@gmail.com">L.J.R</a>
 *         15/3/9 下午2:49
 */
public class CurrentUserUtil {

    private static ThreadLocal<User> userHolder = new ThreadLocal<User>();

    static void setCurrentUser(User user) {
        userHolder.set(user);
    }

    public static User getUser() {
        return userHolder.get();
    }

    public static void empty() {
        userHolder.remove();
    }
}
