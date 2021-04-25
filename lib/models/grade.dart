import 'package:flutter/material.dart';

class Grade {
  Grade({
    required this.id,
    required this.name,
    required this.grades,
  });

  int id;
  String name;
  List<Grades> grades;
}

class Grades {
  Grades({
    required this.name,
    required this.grade,
  });
  String name;
  String grade;
}