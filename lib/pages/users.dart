// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_api/models/usersModel.dart';
import 'package:http/http.dart' as http;

import '../widgets/ReusableRow.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  List<UserModel> userList = [];

  Future<List<UserModel>> getUserUri() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    } else {
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('USER API\'S'),
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            decoration: appBarDecoration(context),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Container(
          decoration: bodyDecoration(context),
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder(
                  future: getUserUri(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: userList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              child: Card(
                                elevation: 0,
                                color: Colors.transparent,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      ReusableRow(
                                        title: 'NAME: ',
                                        value: snapshot.data![index].name
                                            .toString(),
                                      ),
                                      ReusableRow(
                                        title: 'USERNAME: ',
                                        value: snapshot.data![index].username
                                            .toString(),
                                      ),
                                      ReusableRow(
                                        title: 'EMAIL: ',
                                        value: snapshot.data![index].email
                                            .toString(),
                                      ),
                                      ReusableRow(
                                        title: 'CITY: ',
                                        value: snapshot
                                            .data![index].address.city
                                            .toString(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    } else {
                      return Center(
                        child: Container(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator(
                            color: Colors.deepOrangeAccent,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Decoration appBarDecoration(BuildContext con) {
  return BoxDecoration(
    gradient: LinearGradient(colors: [
      Color(0xff89216B),
      Color(0xffDA4453),
    ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
  );
}

Decoration bodyDecoration(BuildContext con) {
  return BoxDecoration(
    gradient: LinearGradient(colors: [
      Color(0xffDA4453),
      Color(0xff89216B),
    ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
  );
}
