package com.asjy.commerplat.exception;

/**
 * @author lee
 *声明异常类
 */
public class SystemException extends RuntimeException {//继承RuntimeException是因为可以直接将异常抛到最上级，不用一级一级抛

	public SystemException(String message) {//重载了RuntimeExceptionde构造方法，目的是我们要传递参数
		super(message);
	}

}
