package com.wickedsoftwaredesigns.rcplanegarage;

import android.content.Context;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.parse.ParseQuery;
import com.parse.ParseQueryAdapter;

public class PlaneListAdapter extends ParseQueryAdapter<Plane> {

	public PlaneListAdapter(Context context) {
		super(context, new ParseQueryAdapter.QueryFactory<Plane>() {
			public ParseQuery<Plane> create(){
				ParseQuery query = new ParseQuery("Plane");
				return query;
			}
		});
		
	}
	
	@Override
	public View getItemView(Plane plane, View view, ViewGroup parent){
		 
		if (view == null) {
			view = View.inflate(getContext(), R.layout.activity_planelist, null);
			
		}
		
		super.getItemView(plane, view, parent);
		TextView planeNameText = (TextView) view.findViewById(R.id.mainLabel);
		planeNameText.setText(plane.getName());
		TextView planeParseId = (TextView) view.findViewById(R.id.subLabel);
		String parseId = plane.getParseId();
		planeParseId.setText(parseId);
		TextView planeType = (TextView) view.findViewById(R.id.subLabel1);
		planeType.setText(plane.getType());
		
		return view;
	}
}
