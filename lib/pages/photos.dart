// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_api/models/photosModel.dart';
import 'package:http/http.dart' as http;

class PhotosPage extends StatefulWidget {
  const PhotosPage({super.key});

  @override
  State<PhotosPage> createState() => _PhotosPageState();
}

class _PhotosPageState extends State<PhotosPage> {
  List<Photos> photosList = [];

  Future<List<Photos>> getPhotosUri() async {
    await Future.delayed(Duration(seconds: 3));
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        Photos photos = Photos(id: i['id'], title: i['title'], url: i['url']);
        photosList.add(photos);
      }
      return photosList;
    } else {
      return photosList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('PHOTOS API\'S'),
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
                  future: getPhotosUri(),
                  builder: (context, AsyncSnapshot<List<Photos>> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: photosList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(snapshot.data![index].url),
                              ),
                              title: Text(
                                  'ID: ${snapshot.data![index].id.toString()}'),
                              subtitle: Text(
                                  'TITLE: ${snapshot.data![index].title.toString()}'),
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
