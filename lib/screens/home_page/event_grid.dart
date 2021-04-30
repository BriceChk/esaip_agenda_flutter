import 'package:esaip_agenda_flutter/models/course_event.dart';
import 'package:esaip_agenda_flutter/screens/home_page/basic_event_extended.dart';
import 'package:flutter/material.dart';
import 'package:timetable/timetable.dart';

class EventGrid extends StatefulWidget {
  late final TimetableController<CourseEvent> controller;

  EventGrid(this.controller);

  @override
  _EventGridState createState() => _EventGridState();
}

class _EventGridState extends State<EventGrid> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
    );
  }
}