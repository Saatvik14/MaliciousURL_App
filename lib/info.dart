import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'api.dart';

var fetchdata;

class Info extends StatefulWidget {
  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  late Future<Album> fetch;
  final _urlController = TextEditingController();
  @override
  void initState() {
    fetch = getData(_urlController.text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 50),
              child: TextFormField(
                controller: _urlController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Enter a URL',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a URL';
                  }
                  if (!Uri.parse(value).isAbsolute) {
                    return 'Please enter a valid URL';
                  }
                  return null;
                },
              ),
            ),
            FloatingActionButton(
              onPressed: () async {
                await getData(_urlController.text);
              },
            ),
            FutureBuilder<Album>(
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data!.value.toString());
                } else {
                  return CircularProgressIndicator();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
