// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_api/models/postsModel.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<PostModel> postList = [];

  Future<List<PostModel>> getPostUri() async {
    await Future.delayed(Duration(seconds: 5));
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        postList.add(PostModel.fromJson(i));
      }
      return postList;
    } else {
      return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('POSTS API\'S'),
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
                  future: getPostUri(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: postList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              child: Card(
                                elevation: 0,
                                color: Colors.transparent,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Divider(
                                        thickness: 1,
                                        height: 1,
                                        color: Colors.orange,
                                        indent: 50,
                                        endIndent: 50,
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                          'TITLE: ${postList[index].title.toString()}'),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                          'ID: ${postList[index].id.toString()}'),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                          'USERID: ${postList[index].userId.toString()}'),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                          'BODY: ${postList[index].body.toString()}'),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Divider(
                                        thickness: 1,
                                        height: 1,
                                        color: Colors.orange,
                                        indent: 50,
                                        endIndent: 50,
                                      )
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
