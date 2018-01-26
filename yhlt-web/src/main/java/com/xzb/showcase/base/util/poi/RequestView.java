package com.xzb.showcase.base.util.poi;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.view.AbstractView;

/**
 *  判断浏览器类型
 */
public abstract class RequestView extends AbstractView {
    
    
    public static boolean isIE(HttpServletRequest request) {
        return (request.getHeader("USER-AGENT").toLowerCase().indexOf("msie") > 0
                || request.getHeader("USER-AGENT").toLowerCase().indexOf("rv:11.0") > 0) ? true
                    : false;
    }

}

