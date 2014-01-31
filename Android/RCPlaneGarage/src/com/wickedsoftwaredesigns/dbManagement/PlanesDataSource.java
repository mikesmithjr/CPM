package com.wickedsoftwaredesigns.dbManagement;

import java.util.ArrayList;
import java.util.List;

import com.wickedsoftwaredesigns.rcplanegarage.Plane;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.util.Log;

public class PlanesDataSource {

	SQLiteOpenHelper planedbhelper;
	SQLiteDatabase planedatabase;
	
	private static final String[] allColumns = {
		PlaneDataDBOpenHelper.COLUMN_ID,
		PlaneDataDBOpenHelper.COLUMN_PARSE_ID,
		PlaneDataDBOpenHelper.COLUMN_NAME,
		PlaneDataDBOpenHelper.COLUMN_TYPE,
		PlaneDataDBOpenHelper.COLUMN_POWER_TYPE,
		PlaneDataDBOpenHelper.COLUMN_FLIGHT_TIME
	};
	
	public PlanesDataSource(Context context){
		
		planedbhelper = new PlaneDataDBOpenHelper(context);
	}
	
	public void open(){
		Log.i("DataSource", "Database Opened");
		planedatabase = planedbhelper.getWritableDatabase();
	}
	public void close(){
		Log.i("DataSource", "Database Closed");
		planedbhelper.close();
	}
	
	public Plane create(Plane plane){
		ContentValues values = new ContentValues();
		values.put(PlaneDataDBOpenHelper.COLUMN_PARSE_ID, plane.getParseId());
		values.put(PlaneDataDBOpenHelper.COLUMN_NAME, plane.getName());
		values.put(PlaneDataDBOpenHelper.COLUMN_TYPE, plane.getType());
		values.put(PlaneDataDBOpenHelper.COLUMN_POWER_TYPE, plane.getPower());
		values.put(PlaneDataDBOpenHelper.COLUMN_FLIGHT_TIME, plane.getTime());
		long insertid = planedatabase.insert(PlaneDataDBOpenHelper.TABLE_PLANES, null, values);
		plane.setId(insertid);
		return plane;
		
	}
	
	public List<Plane> findAll(){
		List<Plane> planes = new ArrayList<Plane>();
		
		Cursor cursor = planedatabase.query(PlaneDataDBOpenHelper.TABLE_PLANES, allColumns, null, null, null, null, null);
		
		Log.i("Find All", "Returned " + cursor.getCount() + " rows");
		
		if (cursor.getCount()> 0) {
			while (cursor.moveToNext()) {
				Plane plane = new Plane();
				plane.setId(cursor.getLong(cursor.getColumnIndex(PlaneDataDBOpenHelper.COLUMN_ID)));
				plane.setName(cursor.getString(cursor.getColumnIndex(PlaneDataDBOpenHelper.COLUMN_NAME)));
				plane.setType(cursor.getString(cursor.getColumnIndex(PlaneDataDBOpenHelper.COLUMN_TYPE)));
				plane.setPower(cursor.getString(cursor.getColumnIndex(PlaneDataDBOpenHelper.COLUMN_POWER_TYPE)));
				int time = Integer.parseInt(cursor.getString(cursor.getColumnIndex(PlaneDataDBOpenHelper.COLUMN_FLIGHT_TIME)));
				plane.setTime(time);
				planes.add(plane);
			}
			
		}
		return planes;
	}
}
