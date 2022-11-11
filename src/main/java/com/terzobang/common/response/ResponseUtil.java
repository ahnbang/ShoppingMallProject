package com.terzobang.common.response;


public class ResponseUtil {

    public static <T>Response<T> SUCCESS (String message, T data) {
        return new Response(ResponseStatus.SUCCESS, message, data);
    }

    public static <T>Response<T> FAIL (String message, T data) {
        return new Response(ResponseStatus.FAIL, message, data);
    }

    public static <T>Response<T> ERROR (String message, T data) {
        return new Response(ResponseStatus.ERROR, message, data);
    }
}