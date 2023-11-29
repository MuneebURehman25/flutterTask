import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ImagesHomeScreen extends StatefulWidget {
  const ImagesHomeScreen({super.key});

  @override
  State<ImagesHomeScreen> createState() => _ImagesHomeScreenState();
}

class _ImagesHomeScreenState extends State<ImagesHomeScreen> {
  
  List<Photos> photosList = [];
  
  Future<List<Photos>> getPhotosApiCall() async{
    
    final photosResponse = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(photosResponse.body.toString());
    
    if(photosResponse.statusCode == 200){

      for(Map i in data){
        Photos photos = Photos(title: i['title'], url: i['url'], id: i['id']);
        photosList.add(photos);
      }

      return photosList;
    }
    else{
      return photosList;
    }
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
        title: Text("Images",style: TextStyle(
          color: Colors.white,
        )),
      ),

      body: Column(
        children: [

          FutureBuilder(future: getPhotosApiCall(), builder: (context,AsyncSnapshot<List<Photos>> snapshot){
            return Expanded(
              child: ListView.builder(
                  itemCount: photosList.length,
                  itemBuilder: (context,index){
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage:  NetworkImage(snapshot.data![index].url.toString()),
                  ),
                  subtitle: Text(snapshot.data![index].title.toString()),
                  title: Text("ID: ${snapshot.data![index].id.toString()}"),
                );
              }),
            );
          })
        ],
      ),
    );
  }
}

class Photos{
  String title , url;
  int id;

  Photos({required this.title, required this.url,required this.id});
}
