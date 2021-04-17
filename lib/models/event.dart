import 'package:flutter/material.dart';

class Event {
  Event({
    required this.id,
    required this.name,
    required this.hours,
    required this.date,
    required this.classroom,
    required this.teacher,
    required this.type,
  });

  int id;
  String date;
  String name;
  String hours;
  String classroom;
  String teacher;
  int type;
}