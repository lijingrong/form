package com.landai.form.utils;

import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;

public class PageableHolder {

    private static ThreadLocal<Pageable> pageableThreadLocal = new ThreadLocal<>();

    public static void setPageable(Pageable pageable){
        pageableThreadLocal.set(pageable);
    }

    public static Pageable getPageable(){
        if(pageableThreadLocal.get()!=null)
            return pageableThreadLocal.get();
        return new PageRequest(0,9);
    }

    public static void empty(){
        pageableThreadLocal.remove();
    }

}
