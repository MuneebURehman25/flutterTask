import 'dart:convert';

import 'package:flutter/material.dart';

import '../Models/UserModel.dart';
import 'package:http/http.dart' as http;

class UserApiScreen extends StatefulWidget {
  const UserApiScreen({super.key});

  @override
  State<UserApiScreen> createState() => _UserApiScreenState();
}

class _UserApiScreenState extends State<UserApiScreen> {

  List<UserModel> userList = [];

  Future<List<UserModel>> getUserApi() async{
    final userResponse = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));

    if(userResponse.statusCode == 200){
      var userData = jsonDecode(userResponse.body.toString());
      for(Map i in userData){
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    }
    else{
      return userList;
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black12,
        title: Text('User Api'),
      ),
      body: Column(
        children: [
          
          Expanded(
              child: FutureBuilder(future: getUserApi(), builder: (BuildContext context, AsyncSnapshot<List<UserModel>> snapshot) {

                if(!snapshot.hasData){
                  return const CircularProgressIndicator();
                }
                else{
                  return ListView.builder(
                      itemCount: userList.length,
                      itemBuilder: (context,index){

                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(

                              children: [

                                ReusableRow(title: 'Name:', value: snapshot.data![index].name.toString()),
                                ReusableRow(title: 'UserName:', value: snapshot.data![index].username.toString()),
                                ReusableRow(title: 'Email:', value: snapshot.data![index].email.toString()),
                                ReusableRow(title: 'Address:',
                                    value: snapshot.data![index].address!.street.toString()+
                                    snapshot.data![index].address!.geo!.lat.toString()+
                                    snapshot.data![index].address!.geo!.lng.toString()),
                                ReusableRow(title: 'City:', value: snapshot.data![index].address!.city.toString()),

                              ],

                            ),
                          ),
                        );

                      });
                }

              },))

        ],
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value)
        ],
      ),
    );
  }
}
