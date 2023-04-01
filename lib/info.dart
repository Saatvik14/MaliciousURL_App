import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'api.dart';

var fetchdata;

int? score;
String? inputURL;

class Info extends StatefulWidget {
  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  final _urlController = TextEditingController();

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
                onChanged: (value) {
                  setState(() {
                    inputURL = value;
                  });
                },
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
                Album fetchdata = await getData(inputURL.toString());
                setState(() {
                  score = fetchdata.value;
                });
              },
            ),
            score == null ? Text("Press the button") : Text(score.toString())
          ],
        ),
      ),
    );
  }
}
