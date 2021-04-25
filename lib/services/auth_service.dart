import 'dart:convert';

import 'package:esaip_agenda_flutter/models/course_event.dart';
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

Future<List<CourseEvent>?> getEvents() async {
  final response = await Requests.get('$url/courses');
  if (response.hasError) {
    return null;
  }
  var jsonArray = jsonDecode(response.content()) as List;
  return jsonArray.map((e) => CourseEvent.fromJson(e)).toList();
}