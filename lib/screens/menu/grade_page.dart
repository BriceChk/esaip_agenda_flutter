import 'package:esaip_agenda_flutter/models/grade.dart';
import 'package:esaip_agenda_flutter/services/api.dart';
import 'package:esaip_agenda_flutter/shared/constants.dart';
import 'package:flutter/material.dart';

class GradePage extends StatefulWidget {
  @override
  _GradePageState createState() => _GradePageState();
}

class _GradePageState extends State<GradePage> {
  List<GradeGroup> gd = [];

  late ThemeData themeData;

  @override
  void initState() {
    super.initState();
    getGrades().then((value) {
      if (value == null) {
        //TODO Error
      } else {
        setState(() {
          gd = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context).copyWith(
        dividerColor: Colors.transparent
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: COLOR_WHITE,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: COLOR_WHITE,
        title: Text(
          'Notes',
          style: TextStyle(
            fontFamily: FONT_NUNITO,
            color: COLOR_GREY,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: gd.map((grd) => _buildGradeWidget(grd)).toList(),
      ),
    );
  }

  Widget _buildGradeWidget(GradeGroup grade) {
    return Theme(
      data: themeData,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        child: Card(
          elevation: 2,
          shadowColor: COLOR_WHITE_GREY,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: ListTileTheme(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            dense: true,
            child: ExpansionTile(
              title: Text(
                grade.name,
                softWrap: false,
                overflow: TextOverflow.fade,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: FONT_NUNITO,
                ),
              ),
              childrenPadding: EdgeInsets.fromLTRB(10, 0, 10, 5),
              children: grade.grades.map((grd) => _buildGrade(grd)).toList(),
            ),
          )
        ),
      ),
    );
  }

  Widget _buildGrade(Grade grades) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            grades.evalName,
            softWrap: false,
            overflow: TextOverflow.fade,
            maxLines: 1,
            style: TextStyle(
              fontSize: 12,
              fontFamily: FONT_NUNITO,
            ),
          ),
          Text(
            grades.grade,
            softWrap: false,
            overflow: TextOverflow.fade,
            maxLines: 1,
            style: TextStyle(
              fontSize: 12,
              fontFamily: FONT_NUNITO,
            ),
          ),
        ],
      ),
    );
  }
}
