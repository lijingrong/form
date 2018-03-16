package com.landai.form.utils;

import com.aliyun.oss.OSSClient;
import org.apache.commons.lang3.time.DateFormatUtils;

import java.io.InputStream;
import java.util.Date;
import java.util.Random;

public class OSSUtil {

    public static String upload(InputStream is) {
        return upload(is, "jpg");
    }

    public static String upload(InputStream is, String postfix) {
        String ossImgName = DateFormatUtils.format(new Date(), "yyyyMMddHHmmss") + getFourRandom()
                + "." + postfix;
        // endpoint以杭州为例，其它region请按实际情况填写
        String endpoint = "oss-cn-shanghai.aliyuncs.com";
        // accessKey请登录https://ak-console.aliyun.com/#/查看
        String accessKeyId = "LTAIVPa308k7uyaL";
        String accessKeySecret = "JYC2luXwOm4f8lEwGQfDgWlZPuYRZa";
        // 创建OSSClient实例
        OSSClient ossClient = new OSSClient(endpoint, accessKeyId, accessKeySecret);
        // 上传文件流
        ossClient.putObject("one-page-img", ossImgName, is);
        // 关闭client
        ossClient.shutdown();
        return ossImgName;
    }

    /**
     * 产生4位随机数(0000-9999)
     *
     * @return 4位随机数
     */
    public static String getFourRandom() {
        Random random = new Random();
        StringBuilder fourRandom = new StringBuilder(random.nextInt(10000) + "");
        int randLength = fourRandom.length();
        if (randLength < 4) {
            for (int i = 1; i <= 4 - randLength; i++)
                fourRandom.insert(0, "0");
        }
        return fourRandom.toString();
    }
}
