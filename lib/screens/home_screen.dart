import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Models/PostsModel.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  List<PostsModel> postList = [];

  Future<List<PostsModel>> getPostsApi() async{

    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      postList.clear();
      for(Map i in data){
        postList.add(PostsModel.fromJson(i));
      }

      return postList;
    }
    else{

      return postList;
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rest APIs"),
        backgroundColor: Colors.lightBlue,
      ),
      body: Column(
        children: [

          Expanded(
            child: FutureBuilder(
                future: getPostsApi(),
                builder: (context,snapshot){
                  if(!snapshot.hasData){
                    return Text("Loading...");
                  }
                  else{

                    return ListView.builder(
                      itemCount: postList.length,
                        itemBuilder: (context,index){
                      return  Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('ID:', style: TextStyle(fontWeight: FontWeight.bold),),
                              Text(postList[index].id.toString(),),

                              Text('Title:', style: TextStyle(fontWeight: FontWeight.bold),),
                              Text(postList[index].title.toString(),textAlign: TextAlign.start,),
                              SizedBox(height: 5,),
                              Text('Description:', style: TextStyle(fontWeight: FontWeight.bold),),
                              SizedBox(height: 5,),
                              Text(postList[index].body.toString(),textAlign: TextAlign.start,),
                            ],
                          ),
                        ),
                      );
                    });
                  }
                },
            ),
          )
        ],
      ),
    );
  }
}



