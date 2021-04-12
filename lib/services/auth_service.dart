import 'package:requests/requests.dart';

String url = 'https://agenda-esaip.bricechk.fr';

Future<bool> login(String login, String password) async {
  final response = await Requests.post('$url/login', body: {
    'username': login,
    'password': password
  }, bodyEncoding: RequestBodyEncoding.JSON);

  return response.statusCode == 200;
}

Future<bool> getStatus() async {
  final response = await Requests.get('$url/status');
  return response.statusCode == 200;
}