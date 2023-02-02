package com.project.util;

import com.github.scribejava.core.builder.api.DefaultApi20;

public class GoogleLoginApi extends DefaultApi20 {
	protected GoogleLoginApi(){
	    }

	    private static class InstanceHolder{
	        private static final GoogleLoginApi INSTANCE = new GoogleLoginApi();
	    }


	    public static GoogleLoginApi instance(){
	        return InstanceHolder.INSTANCE;
	    }

	    
	    @Override
	    public String getAccessTokenEndpoint() {
//	        return "https://accounts.google.com/o/oauth2/token?"
	    	return "https://oauth2.googleapis.com/token?"
	        		
	        		+ "code=http://localhost/redirect"
	        		+ "&scope=https://www.googleapis.com/auth/userinfo.email"
	        		+ "&client_id=233418186817-v6nlobapoh55eda8bsujrdiabo9p78d1.apps.googleusercontent.com"
	        		+ "&client_secret=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"
	        		+ "&redirect_uri=http://localhost/redirect"
	        		+ "&grant_type=authorization_code";

	    }

	    @Override
	    protected String getAuthorizationBaseUrl() {
	        // TODO Auto-generated method stub
	        return "https://accounts.google.com/o/oauth2/v2/auth";
	    }
}