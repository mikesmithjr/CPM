package com.wickedsoftwaredesigns.rcplanegarage;

import android.os.Bundle;
import android.app.ActionBar;
import android.app.Activity;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;

public class AddPlaneEntry extends Activity implements OnClickListener {
	
	private Plane plane;
	Button savePlane;
	Button cancelButton;
	EditText name;
	EditText type;
	EditText power;
	EditText time;
	
	@Override
	protected void onCreate(Bundle savedInstanceState){
		plane = new Plane();
		super.onCreate(savedInstanceState);
		this.setTitle("New Plane");
		setContentView(R.layout.activity_new_plane_entry);
		
		ActionBar actionBar = getActionBar();
		actionBar.setDisplayHomeAsUpEnabled(true);
		
		name = (EditText)findViewById(R.id.nameField);
		type = (EditText)findViewById(R.id.typeField);
		power = (EditText)findViewById(R.id.powerTypeField);
		time = (EditText)findViewById(R.id.flightTimeField);
		
		savePlane = (Button)findViewById(R.id.savePlaneButton);
		cancelButton = (Button)findViewById(R.id.cancelButton);
		savePlane.setOnClickListener(this);
		cancelButton.setOnClickListener(this);
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
			Log.i("Add Plane", "Already on the Add Plane Page");
		}
		return false;
		
	}

	@Override
	public void onClick(View v) {
		if (v.equals(this.savePlane)) {
			plane.setName(name.getText().toString());
			plane.setType(type.getText().toString());
			plane.setPower(power.getText().toString());
			int timeNum = Integer.parseInt(time.getText().toString());
			plane.setTime(timeNum);
			
			plane.saveInBackground();
			
			setResult(RESULT_OK);
			finish();
			
		}else if (v.equals(this.cancelButton)){
			
			setResult(RESULT_OK);
			finish();
		}
		
	}

}
