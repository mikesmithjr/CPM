package com.wickedsoftwaredesigns.rcplanegarage;

import com.parse.Parse;
import com.parse.ParseObject;

import android.app.Application;

public class RCPlanneGarageApplication extends Application {

	@Override
	public void onCreate(){
		super.onCreate();
		
		ParseObject.registerSubclass(Plane.class);
		
		Parse.initialize(this, "aV2YaiwbYmi0dK3YLeOLlRGFVsXR7T5ddFNenXEJ", "fPA6N5YVouV1DxVNUqo0wfFWxp4UD6jVf4YfPZPb");
		
		
	}
	
	
	
}
