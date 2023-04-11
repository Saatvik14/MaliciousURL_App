import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api.dart';

String? inputURL;
int? score;

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeState();
}

class _WelcomeState extends State<WelcomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _urlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.indigo[300],
        appBar: AppBar(
          backgroundColor: Colors.indigo[200],
          title: Container(
            alignment: Alignment.center,
            child: Text(
              'Malicious URL Detection App',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          elevation: 15,
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 20, left: 5, right: 5),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 50),
                    child: Column(
                      children: [
                        Text('About the App',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Malicious URL detection App is an app which will help you to find the malicious urls on internet. This app uses a Machine Learning model inyegrated in this app to predict whether the provided url can be malicious or not. So in order to use this app you just need to write the url in textfield and it will provide you the riskscore, if riskscore is 0 then the website is safe to browse and if it is 100 then the website is malicious. The format in which you need to enter url is :- "https://www.google.com"',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        )
                      ],
                    ),
                  ),
                  TextFormField(
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
                  SizedBox(height: 16.0),
                  FloatingActionButton(
                      onPressed: () async {
                        Album fetchdata = await getData(inputURL.toString());
                        setState(() {
                          score = fetchdata.value;
                        });
                      },
                      backgroundColor: Colors.indigo[300],
                      child: const Icon(Icons.search)),
                  score == null
                      ? Container(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            "Press the button",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : score! > 50
                          ? Container(
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                "URL is Bad",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.only(top: 10),
                              child: Text('URL is Good',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                  textAlign: TextAlign.center),
                            ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


 /* Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _riskScore = null;
      });
      try {
        final riskScore = await getRiskScore(_urlController.text);
        setState(() {
          _riskScore = riskScore;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            duration: Duration(seconds: 5),
          ),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<double> getRiskScore(String url) async {
    final endpoint =
        'https://endpoint.apivoid.com/urlrep/v1/pay-as-you-go/?key=f4d8e5ff5f197009e3280548310093646f5a662d&url=$url';
    final response = await http.get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      final data =
          jsonDecode(response.body)['data']['report']['risk_score']['result'];
      print(data);
      return data;
    } else {
      throw Exception('Failed to get risk score: ${response.statusCode}');
    }
  }*/