import 'package:flutter/material.dart';

class Event {
  Event({
    required this.id,
    required this.name,
    required this.hours,
    required this.classroom,
    required this.teacher,
  });

  int id;
  String name;
  String hours;
  String classroom;
  String teacher;
}