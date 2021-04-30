import 'package:esaip_agenda_flutter/main.dart';
import 'package:esaip_agenda_flutter/models/course_event.dart';
import 'package:esaip_agenda_flutter/screens/home_page/basic_event_extended.dart';
import 'package:flutter/material.dart';
import 'package:time_machine/time_machine.dart';
import 'package:timetable/timetable.dart';

class TimetableExample extends StatefulWidget {
  @override
  _TimetableExampleState createState() => _TimetableExampleState();
}

class _TimetableExampleState extends State<TimetableExample> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late TimetableController<BasicEvent> _controller;

  @override
  void initState() {
    super.initState();

    _controller = TimetableController(
      //A basic EventProvider containing a single event:
      eventProvider: EventProvider.list(MyApp.events),

      // Other (optional) parameters:
      initialTimeRange: InitialTimeRange.range(
        startTime: LocalTime(8, 0, 0),
        endTime: LocalTime(20, 0, 0),
      ),
      initialDate: LocalDate.today(),
      visibleRange: VisibleRange.days(3),
      firstDayOfWeek: DayOfWeek.monday,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
        controller: _controller,
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