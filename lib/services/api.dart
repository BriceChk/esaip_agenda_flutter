import 'dart:convert';

import 'package:esaip_agenda_flutter/models/course_event.dart';
import 'package:esaip_agenda_flutter/models/course_note.dart';
import 'package:esaip_agenda_flutter/models/grade.dart';
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

Future<CourseNote?> addNote(CourseEvent e, String note) async {
  final response = await Requests.post('$url/courses/' + e.id.toString() + '/notes', body: {
    'content': note
  });
  if (response.hasError) {
    return null;
  }
  return courseNoteFromJson(response.content());
}

Future<CourseNote?> updateNote(CourseNote note) async {
  final response = await Requests.post('$url/notes/' + note.id.toString(), body: {
    'content': note.content
  });
  if (response.hasError) {
    return null;
  }
  return courseNoteFromJson(response.content());
}

Future<bool> deleteNote(CourseNote note) async {
  final response = await Requests.delete('$url/notes/' + note.id.toString());
  return !response.hasError;
}

Future<List<GradeGroup>?> getGrades() async {
  final response = await Requests.get('$url/grades');
  if (response.hasError) {
    print(response.content());
    return null;
  }
  var jsonArray = jsonDecode(response.content()) as List;
  var map = Map<int, GradeGroup>();
  jsonArray.forEach((element) {
    map.putIfAbsent(element['idSession'], () => new GradeGroup(name: element['sessionName']));
    map[element['idSession']]!.grades.add(new Grade(evalName: element['evalName'], grade: element['note']));
  });
  return map.values.toList();
}