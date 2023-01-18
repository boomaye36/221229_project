package com.project.util;

import com.github.scribejava.core.builder.api.DefaultApi20;

public class GoogleLoginApi  extends DefaultApi20 {
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
	        
	        return "https://www.googleapis.com/oauth2/v4/token?"
	        		
	        		+ "  client_id=10488992723-vs8585mi2nsc4tsim89vf8icpeukops0.apps.googleusercontent.com&"
	        		+ "  client_secret=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&"
	        		+ "  redirect_uri=https://www.googleapis.com/auth/indexing&"
	        		+ "  grant_type=authorization_code";

	    }

	    @Override
	    protected String getAuthorizationBaseUrl() {
	        // TODO Auto-generated method stub
	        return"https://accounts.google.com/o/oauth2/v2/auth";
	    }
}