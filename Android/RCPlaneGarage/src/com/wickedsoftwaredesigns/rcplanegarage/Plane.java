package com.wickedsoftwaredesigns.rcplanegarage;

import com.parse.ParseClassName;
import com.parse.ParseObject;

@ParseClassName("Plane")
public class Plane extends ParseObject {

	private long id;
	
	public Plane(){
		
	}
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	
	public String getName(){
		return getString("Name");
	}
	
	public void setName(String name){
		put("Name", name);
	}
	
	public String getType(){
		return getString("Type");
	}
	
	public void setType(String type){
		put("Type", type);
	}
	
	public String getPower(){
		return getString("Power_type");
	}
	
	public void setPower(String power){
		put("Power_type", power);
	}
	
	public int getTime(){
		return getInt("Flight_Time");
	}
	
	public void setTime(int time){
		put("Flight_Time", time);
	}
		
	public String getParseId(){
		String parseId = getObjectId().toString();
		//Log.i("ParseId", parseId);
		return parseId;
	}
	
	public void setParseId(String parseId){
		put("objectId", parseId);
	}
	
}
