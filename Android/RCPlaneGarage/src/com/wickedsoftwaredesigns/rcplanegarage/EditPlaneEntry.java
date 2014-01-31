package com.wickedsoftwaredesigns.rcplanegarage;

import android.app.ActionBar;
import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;

public class EditPlaneEntry extends Activity implements OnClickListener{

	Button savePlane;
	Button cancelButton;
	EditText name;
	EditText type;
	EditText power;
	EditText time;
	
	@Override
	protected void onCreate(Bundle savedInstanceState){
		super.onCreate(savedInstanceState);
		this.setTitle("Edit Plane");
		setContentView(R.layout.activity_edit_plane_entry);
		
		ActionBar actionBar = getActionBar();
		actionBar.setDisplayHomeAsUpEnabled(true);
		
		name = (EditText)findViewById(R.id.nameField);
		type = (EditText)findViewById(R.id.typeField);
		power = (EditText)findViewById(R.id.powerTypeField);
		time = (EditText)findViewById(R.id.flightTimeField);
		
		savePlane = (Button)findViewById(R.id.editPlaneButton);
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
			Intent intent = new Intent(this, AddPlaneEntry.class);
			startActivity(intent);
		}
		return false;
		
	}
	
	
	
	
	@Override
	public void onClick(View v) {
		// TODO Auto-generated method stub
		
	}

}
