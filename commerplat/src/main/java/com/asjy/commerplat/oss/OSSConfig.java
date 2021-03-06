package com.asjy.commerplat.oss;

import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class OSSConfig implements InitializingBean{
 
    @Value("${yeti-shopping.file.endpoint}")
    private String file_endpoint;
 
    @Value("${yeti-shopping.file.keyid}")
    private String file_keyid;
 
    @Value("${yeti-shopping.file.keysecret}")
    private String file_keysecret;
 
    @Value("${yeti-shopping.file.bucketname}")
    private String file_bucketname;
 
    @Value("${yeti-shopping.file.filehost}")
    private String file_filehost;
    
 
    public static String END_POINT;
    public static String ACCESS_KEY_ID;
    public static String ACCESS_KEY_SECRET;
    public static String BUCKET_NAME;
    public static String FILE_HOST;
 
    @Override
    public void afterPropertiesSet() throws Exception {
        END_POINT = file_endpoint;
        ACCESS_KEY_ID = file_keyid;
        ACCESS_KEY_SECRET = file_keysecret;
        BUCKET_NAME = file_bucketname;
        FILE_HOST = file_filehost;
    }
}


