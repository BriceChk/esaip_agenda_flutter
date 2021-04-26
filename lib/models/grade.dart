class GradeGroup {
  GradeGroup({
    required this.name,
  });

  String name;
  List<Grade> grades = [];
}

class Grade {
  Grade({
    required this.evalName,
    required this.grade,
  });
  String evalName;
  String grade;
}