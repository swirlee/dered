package com.asjy.commerplat.util;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;

@Component
@PropertySource(value="classpath:message.properties",encoding="utf-8")
public class Message {
	
	@Value("${MI01}")
	public String MI01;
	
	@Value("${MI02}")
	public String MI02;
	
	@Value("${MI03}")
	public String MI03;
	
	
	
}
