package com.godric.lms.common.config;

import org.springframework.core.convert.converter.Converter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @author Godric
 */
//public class DateConverter implements Converter<String, Date> {
//    @Override
//    public Date convert(String source) {
//
//        if(source.equals("")) {
//            return null;
//        }
//        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
//        dateFormat.setLenient(false);
//        try {
//            return dateFormat.parse(source);
//        } catch (ParseException e) {
//            e.printStackTrace();
//        }
//        return null;
//    }
//
//}
