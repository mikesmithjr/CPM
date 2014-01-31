package com.wickedsoftwaredesigns.rcplanegarage;

import com.parse.ParseQueryAdapter;

import android.app.ListActivity;
import android.os.Bundle;
import android.widget.ListView;

public class PlaneList extends ListActivity{
	PlaneListAdapter allPlaneAdapter;
	
	String parseId;
	
	@Override
	public void onCreate(Bundle savedInstanceState){
		
		super.onCreate(savedInstanceState);
		
		allPlaneAdapter = new PlaneListAdapter(this);
		
		
		setListAdapter(allPlaneAdapter);
		
		
	}

}
