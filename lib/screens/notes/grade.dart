import 'package:esaip_agenda_flutter/models/grade.dart';
import 'package:esaip_agenda_flutter/shared/constants.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GradePage extends StatelessWidget {
  List<Grade> gd = [];
  List<Grades> gds = [];
  List<Grades> gds2 = [];

  @override
  Widget build(BuildContext context) {
    gds.add(Grades(name: 'Note 1', grade: '20/20'));
    gds.add(Grades(name: 'Projet', grade: '12/20'));
    gd.add(Grade(id: 0, name: 'JEE', grades: gds));
    gds2.add(Grades(name: 'Note 1', grade: '20/20'));
    gds2.add(Grades(name: 'Projet', grade: '12/20'));
    gds2.add(Grades(name: 'Note 2', grade: '3/20'));
    gds2.add(Grades(name: 'Projet 25', grade: '5.3/20'));
    gd.add(Grade(id: 0, name: 'Android avancé', grades: gds2));
    gd.add(Grade(id: 0, name: 'Android avancé', grades: gds2));
    gd.add(Grade(id: 0, name: 'Android avancé', grades: gds2));
    gd.add(Grade(id: 0, name: 'Android avancé', grades: gds2));

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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: gd.map((grd) => _buildGradeWidget(grd)).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGradeWidget(Grade grade) {
    return ExpandableNotifier(
      initialExpanded: false,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Card(
          elevation: 2,
          shadowColor: COLOR_WHITE_GREY,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: <Widget>[
              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: ExpandablePanel(
                  theme: ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                    hasIcon: true,
                  ),
                  header: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                grade.name,
                                softWrap: false,
                                overflow: TextOverflow.fade,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: FONT_NUNITO,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  collapsed: Container(),
                  expanded: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: grade.grades.map((grd) => _buildGrade(grd)).toList(),
                    ),
                  ),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        theme: const ExpandableThemeData(crossFadePoint: 0),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGrade(Grades grades) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 2.5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
             grades.name,
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
