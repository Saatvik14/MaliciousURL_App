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
