import 'dart:convert';

CourseNote courseNoteFromJson(String str) => CourseNote.fromJson(json.decode(str));

String courseNoteToJson(CourseNote data) => json.encode(data.toJson());

class CourseNote {
  CourseNote({
    required this.id,
    required this.content,
    required this.createdDate,
  });

  int id;
  String content;
  DateTime createdDate;

  factory CourseNote.fromJson(Map<String, dynamic> json) => CourseNote(
    id: json["id"],
    content: json["content"],
    createdDate: DateTime.parse(json["created_date"]).toLocal(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "content": content,
    "created_date": createdDate.toIso8601String(),
  };
}
