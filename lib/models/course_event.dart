import 'dart:convert';
import 'dart:ui';

import 'package:esaip_agenda_flutter/models/course_note.dart';
import 'package:esaip_agenda_flutter/shared/constants.dart';
import 'package:time_machine/src/localdatetime.dart';
import 'package:timetable/timetable.dart';

List<CourseEvent> courseEventFromJson(String str) => List<CourseEvent>.from(json.decode(str).map((x) => CourseEvent.fromJson(x)));

String courseEventToJson(List<CourseEvent> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CourseEvent implements BasicEvent {
  CourseEvent({
    required this.id,
    required this.name,
    required this.startsAt,
    required this.endsAt,
    required this.room,
    required this.teacher,
    required this.type,
    required this.notes,
    required this.alcuinId,
  });

  int id;
  String name;
  DateTime startsAt;
  DateTime endsAt;
  String room;
  String teacher;
  Type type;
  List<CourseNote> notes;
  int alcuinId;

  factory CourseEvent.fromJson(Map<String, dynamic> json) {
    var e = CourseEvent(
      id: json["id"],
      name: json["name"],
      startsAt: DateTime.parse(json["starts_at"]).toLocal(),
      endsAt: DateTime.parse(json["ends_at"]).toLocal(),
      room: json["room"],
      teacher: json["teacher"],
      type: typeValues.map[json["type"]]!,
      notes: List<CourseNote>.from(json["course_notes"].map((x) => CourseNote.fromJson(x))),
      alcuinId: json["alcuin_id"],
    );
    e.notes.sort((a, b) => a.createdDate.isAfter(b.createdDate) ? -1 : 1);
    return e;
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "starts_at": startsAt.toIso8601String(),
    "ends_at": endsAt.toIso8601String(),
    "room": room,
    "teacher": teacher,
    "type": typeValues.reverse[type],
    "course_notes": notes.map((x) => x.toJson()),
    "alcuin_id": alcuinId,
  };

  @override
  LocalDateTime get end => LocalDateTime.dateTime(endsAt.add(endsAt.timeZoneOffset));

  @override
  bool get isAllDay => false;

  @override
  bool get isPartDay => true;

  @override
  LocalDateTime get start => LocalDateTime.dateTime(startsAt.add(startsAt.timeZoneOffset));

  @override
  bool operator ==(other) {
    return super == other;
  }

  @override
  int get hashCode => super.hashCode;

  @override
  Color get color {
    switch (this.type) {
      case Type.EXAM:
        return COLOR_RED_CARD;
      case Type.COURS:
        return COLOR_GREEN_CARD;
      default:
        return COLOR_PURPLE_CARD;
    }
  }

  @override
  String get title => name;

}

enum Type { EXAM, COURS, AUTRE }

final typeValues = EnumValues({
  "Autre": Type.AUTRE,
  "Cours": Type.COURS,
  "Exam": Type.EXAM
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
