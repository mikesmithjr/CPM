package com.wickedsoftwaredesigns.dbManagement;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.util.Log;

public class JSONFileManagement {

	/**
	 * Builds the json.
	 * 
	 * @return the jSON object
	 */
	public static JSONObject buildJSON(JSONArray movies) {

		
		
		// create Movies JSONObject
		JSONObject moviesObject = new JSONObject();

		try {
			// create query object
			JSONObject queryObject = new JSONObject();

			// create movie objects in query
			for (int i = 0; i<movies.length(); i++) {

				JSONObject movie = movies.getJSONObject(i);
				
				// create movies info object
				JSONObject infoObject = new JSONObject();

				// add movie info to object
				infoObject.put("title", movie.getString("title"));
				infoObject.put("runtime", movie.getString("runtime"));
				infoObject.put("rating", movie.getString("mpaa_rating"));
				queryObject.put(movie.getString("title"), infoObject);

			}
			// Add query to movies object
			moviesObject.put("query", queryObject);
			Log.i("Build JSOn", queryObject.toString());
			
			
		} catch (JSONException e) {
			Log.e("JSoNError", "Error", e);
			e.printStackTrace();
		}

		return moviesObject;
	}

	/**
	 * Read json.
	 * 
	 * @param selected
	 *            the selected Here is the c
	 * @return the string
	 */
	public static String readJSON(JSONArray jsonData) {

		String result;
		String title;
		String runtime;
		String rating;
	
		// Creates local JSON Object from passed data
		JSONObject object = buildJSON(jsonData);
		//Log.i("Read Json Data", jsonData.toString());
		
		
		// Pulls and parses the data into a string
		try {
			title = object.getJSONObject("query").getJSONObject("movie").getString("title");
			rating = object.getJSONObject("query").getJSONObject("movie").getString("rating");
			runtime = object.getJSONObject("query").getJSONObject("movie").getString("runtime");
			result = "Title: " + title + "\r\n" + 
					"Rated: " + rating + "\r\n" + 
					"Movie Length: " + runtime + " Minutes";

		} catch (JSONException e) {
			
			
			Log.e("error tag", "error", e);
			result = "";
		}

		return result;
	}
}