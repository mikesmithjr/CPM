package com.wickedsoftwaredesigns.dbManagement;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.util.Log;

public class PlaneDataDBOpenHelper extends SQLiteOpenHelper{

	private static final String DATABASE_NAME = "planes.db";
	private static final int DATABASE_VERSION = 1;
	
	public static final String TABLE_PLANES = "movies";
	public static final String COLUMN_ID = "planeId";
	public static final String COLUMN_PARSE_ID = "objectId";
	public static final String COLUMN_NAME = "Name";
	public static final String COLUMN_TYPE = "Type";
	public static final String COLUMN_POWER_TYPE = "Power_type";
	public static final String COLUMN_FLIGHT_TIME = "Flight_Time";
	
	private static final String TABLE_CREATE =
			"CREATE TABLE " + TABLE_PLANES + " (" +
			COLUMN_ID + " INTEGER PRIMARY KEY AUTOINCREMENT, " +
			COLUMN_PARSE_ID + " TEXT, " +
			COLUMN_NAME + " TEXT, " +
			COLUMN_TYPE + " TEXT, " +
			COLUMN_POWER_TYPE + " TEXT, " +
			COLUMN_FLIGHT_TIME + " INTEGER " +
			")";
	
	
	public PlaneDataDBOpenHelper(Context context) {
		super(context, DATABASE_NAME, null, DATABASE_VERSION);
		
	}

	@Override
	public void onCreate(SQLiteDatabase arg0) {
		arg0.execSQL(TABLE_CREATE);
		Log.i("DBonCreate", "Table has been created");
	}

	@Override
	public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
		db.execSQL("DROP TABLE IF EXISTS " + TABLE_PLANES);
		onCreate(db);

	}

}
