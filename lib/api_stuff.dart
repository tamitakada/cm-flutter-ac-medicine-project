//https://open.fda.gov/apis/drug/drugsfda/how-to-use-the-endpoint/
//response.statusCode, 200 success, 0 fail

import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'package:convert/convert.dart';
import 'medicine_listing.dart';

class apiStuff{

  static Future<String?> getDirections (String name) async {

    var response = await get(Uri.parse("https://api.fda.gov/drug/label.json?search=openfda.generic_name:\"$name\"&limit=1"));

    if (response.statusCode == 200){

      return jsonDecode(response.body)["results"][0]["dosage_and_administration"][0];
    }

    return null;
  }

  static Future<List<MedicineListing>?> find (String name) async {

    var response = await get(Uri.parse("https://api.fda.gov/drug/label.json?search=openfda.generic_name:" + name + "&limit=10"));
    Map<String, dynamic> medicine = jsonDecode(response.body);
    List<MedicineListing> tenMeds = [];

    if (response.statusCode == 200){

      for (int i = 0; i < medicine["results"].length; i++){


        tenMeds.add(MedicineListing(brandName: medicine["results"][i]["openfda"]["brand_name"][0],
          purpose: medicine["results"][i]["indications_and_usage"][0],
          warnings: medicine["results"][i]["warnings_and_cautions"],
          directions: medicine["results"][i]["dosage_and_administration"][0],
          route: medicine["results"][i]["openfda"]["route"][0],
          ingredients: medicine["results"][i]["active_ingredient"],
        ));



      }

      return tenMeds;
    }

    return null;
  }
}

