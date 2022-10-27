import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:uuid/uuid.dart';

class GooglePlacesApiScreen extends StatefulWidget {

  @override
  State<GooglePlacesApiScreen> createState() => _GooglePlacesApiScreenState();
}

class _GooglePlacesApiScreenState extends State<GooglePlacesApiScreen> {
  TextEditingController _controller = TextEditingController();
  var uuid = Uuid();
  String _sessionToken = "122344";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(() {
      onChange();
    });
  }
  void onChange(){
    if(_sessionToken == null)
      {
        setState(() {
          _sessionToken = uuid.v4();
        });
      }
    getSuggestions(_controller.text);
  }
  Dio _dio = Dio();
  List<dynamic> _placesList =[];

  getSuggestions(String input)async{
    String kPLACES_API_KEY = "AIzaSyAj1U4NV784fzjvERjGzevCpjKzeJQkQyk";
    String base_url = "https://maps.googleapis.com/maps/api/place/autocomplete/json";
    String request = "$base_url?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken";
    var response = await _dio.get(request);
    print(response.data['predictions']);

    if(response.statusCode == 200)
      {
        setState(() {
            _placesList = response.data['predictions'];
        });
      }
    else{
      throw Exception("Failed");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("search google"),

      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Search here",
              ),
            ),

          ],
        ),
      ),
    );
  }
}
