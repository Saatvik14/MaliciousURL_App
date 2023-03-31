import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'api.dart';

var fetchdata;

class Info extends StatefulWidget {
  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  @override
  void initState() {
    super.initState();
  }

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
              child: Icon(Icons.search),
              onPressed: () async {
                setState(() async {
                  fetchdata = await getRiskScore(_urlController.text);
                });
                //var data =await getRiskScore(_urlController.text);
                //Text('$data');
              },
            ),
            Text(fetchdata.toString()),
          ],
        ),
      ),
    );
  }
}
