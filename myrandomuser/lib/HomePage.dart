import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List usersData;
  bool isloading = true;
  final String url = "https://randomuser.me/api/?results=50";
  Future getData() async {
    var response = await http.get(
      Uri.encodeFull(url),
      headers: {"Accept": "application/json"},
    );
    List data = jsonDecode(response.body)["results"];
    setState(() {
      usersData = data;
      isloading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Randon User"),
      ),
      body: Container(
        child: Center(
            child: isloading
                ? CircularProgressIndicator()
                : ListView.builder(
                    itemCount: usersData == null ? 0 : usersData.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.all(20.0),
                              child: Image(
                                  height: 70.0,
                                  width: 70.0,
                                  fit: BoxFit.contain,
                                  image: NetworkImage(
                                      usersData[index]["picture"]["thumbnai"])),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    usersData[index]["name"]['first'] +
                                        usersData[index]["name"]['last'],
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                  Text(usersData[index]['phone']),
                                  Text(usersData[index]['gender'])
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  )),
      ),
    );
  }
}
