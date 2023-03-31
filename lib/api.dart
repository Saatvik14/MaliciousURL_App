import 'dart:convert';
import 'package:http/http.dart' as http;

var data;
Future<double> getRiskScore(String url) async {
  final endpoint =
      'https://endpoint.apivoid.com/urlrep/v1/pay-as-you-go/?key=f4d8e5ff5f197009e3280548310093646f5a662d&url=$url';
  final response = await http.get(Uri.parse(endpoint));
  if (response.statusCode == 200) {
    data = jsonDecode(response.body)['data']['report']['risk_score']['result'];
    //data = jsonDecode(response.body);
    print(data);
    return data;
  } else {
    throw Exception('Failed to get risk score: ${response.statusCode}');
  }
}

class Album {
  final String value;

  const Album({required this.value});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      value: json['data']['report']['risk_score']['result'],
    );
  }
}

var countryName;

Future<Album> getData(String url) async {
  http.Response response = await http.get(
    Uri.parse(
        'https://endpoint.apivoid.com/urlrep/v1/pay-as-you-go/?key=f4d8e5ff5f197009e3280548310093646f5a662d&url=$url'),
  );
  if (response.statusCode == 200) {
    print(response.body);
    countryName =
        jsonDecode(response.body)['data']['report']['risk_score']['result'];
    // print("ISO Code: $query");
    // print("COuntryName: $countryName");

    // countryCapital = jsonDecode(response.body)["data"]["capital"];
    // print("Capital: $countryCapital");

    return Album.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('error cought');
  }
}
