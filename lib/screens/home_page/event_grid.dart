import 'package:esaip_agenda_flutter/main.dart';
import 'package:esaip_agenda_flutter/models/course_event.dart';
import 'package:esaip_agenda_flutter/screens/home_page/basic_event_extended.dart';
import 'package:flutter/material.dart';
import 'package:time_machine/time_machine.dart';
import 'package:timetable/timetable.dart';

class TimetableExample extends StatefulWidget {
  late final TimetableController<CourseEvent> controller;

  TimetableExample(this.controller);

  @override
  _TimetableExampleState createState() => _TimetableExampleState();
}

class _TimetableExampleState extends State<TimetableExample> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Timetable<BasicEvent>(
      theme: TimetableThemeData(
        weekIndicatorDecoration: BoxDecoration(
          color: Colors.transparent
        ),
        weekIndicatorTextStyle: TextStyle(
          fontSize: 0,
        ),
        minimumHourZoom: 2,
        maximumHourZoom: 2
      ),
        controller: widget.controller,
        onEventBackgroundTap: (start, isAllDay) {},
        eventBuilder: (event) {
          return BasicEventExtendedWidget(event as CourseEvent);
        },
        allDayEventBuilder: (context, event, info) => BasicAllDayEventWidget(
          event,
          info: info,
          onTap: () {
          },
        ),
      );
  }
}