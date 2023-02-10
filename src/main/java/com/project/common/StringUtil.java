package com.project.common;

public class StringUtil {
	
	// String이 정수인지 확인
	public static boolean isNumeric(String s) {
		  try {
			  Integer.parseInt(s);
		      return true;
		  } catch(NumberFormatException e) {
		      return false;
		  }
	}
}
