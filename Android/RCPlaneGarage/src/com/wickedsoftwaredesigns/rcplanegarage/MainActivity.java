package com.wickedsoftwaredesigns.rcplanegarage;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.os.Bundle;
import android.app.Activity;
import android.content.Intent;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;

import com.parse.ParseAnalytics;
import com.parse.PushService;
import com.wickedsoftwaredesigns.dbManagement.PlanesDataSource;

public class MainActivity extends Activity implements OnClickListener{

	PlanesDataSource planeDataSource;
	Button allPlaneList;
	Button typePlaneList;
	Button alphaPlaneList;
	BufferedInputStream responseStream;
	String json = "";
	public static String JSON_PARSE_ID = "objectId";
	public static String JSON_NAME = "Name";
	public static String JSON_TYPE = "Type";
	public static String JSON_POWER_TYPE = "Power_type";
	public static String JSON_FLIGHT_TIME = "Flight_Time";
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);
		
		PushService.setDefaultPushCallback(this, MainActivity.class);
		ParseAnalytics.trackAppOpened(getIntent());
		
		
		//createData();
			
		
		
		allPlaneList = (Button)findViewById(R.id.showPlaneList);
		typePlaneList = (Button)findViewById(R.id.showPlaneListByType);
		alphaPlaneList = (Button)findViewById(R.id.showPlaneListByAlpha);
		allPlaneList.setOnClickListener(this);
		typePlaneList.setOnClickListener(this);
		alphaPlaneList.setOnClickListener(this);
	
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.main, menu);
		return true;
	}
	
	@Override
	public boolean onOptionsItemSelected(MenuItem item){
		
		if(item.getItemId() == R.id.action_addPlane){
			Intent intent = new Intent(this, AddPlaneEntry.class);
			startActivity(intent);
		}
		return false;
		
	}

	@Override
	public void onClick(View v) {
		// TODO Auto-generated method stub
		if (v.equals(this.allPlaneList)) {
			Intent intent = new Intent(this, PlaneList.class);
			startActivity(intent);
			
		}
	}
	
	private void createData(){
		Plane plane = new Plane();
		
		try {
			URL url = new URL("https://aV2YaiwbYmi0dK3YLeOLlRGFVsXR7T5ddFNenXEJ:javascript-key=CvlRPPSoEVsiXMsWtoF55blJRNkQCYgeUBktWjWo@api.parse.com/1/classes/Plane");
			HttpURLConnection urlConnection = (HttpURLConnection) url.openConnection();
			responseStream = new BufferedInputStream(urlConnection.getInputStream());
			
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		try {
			
			
			BufferedReader reader = new BufferedReader(new InputStreamReader(responseStream));
			
			String row;
			while((row = reader.readLine()) != null) {
				json += row;
			}
			reader.close();
			responseStream.close();
		} catch (Exception ex) {
			// TODO Auto-generated catch block
			Log.e("Reading JSON File", ex.getMessage());
		}
		
		try {
			JSONObject object = new JSONObject(json);
			Log.i("JSON Data 1", object.toString());
			JSONArray result = object.getJSONArray("Planes");
			Log.i("JSON Data 2", result.toString());
			int recordSize = result.length();
			for (int i = 0; i < recordSize; i++) {
				
				JSONObject PlaneObject = result.getJSONObject(i);
				String name = PlaneObject.getString(JSON_NAME);
				String type = PlaneObject.getString(JSON_TYPE);
				String powerType = PlaneObject.getString(JSON_POWER_TYPE);
				String flightTime = PlaneObject.getString(JSON_FLIGHT_TIME);
				String parseId = PlaneObject.getString(JSON_PARSE_ID);
				plane.setName(name);
				plane.setType(type);
				plane.setPower(powerType);
				plane.setTime(Integer.parseInt(flightTime));
				plane.setParseId(parseId);
				plane = planeDataSource.create(plane);
				
			}
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
		
	}

}
