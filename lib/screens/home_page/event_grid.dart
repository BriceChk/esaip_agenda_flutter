import 'package:esaip_agenda_flutter/models/course_event.dart';
import 'package:esaip_agenda_flutter/screens/home_page/basic_event_extended.dart';
import 'package:esaip_agenda_flutter/screens/home_page/notes.dart';
import 'package:flutter/material.dart';
import 'package:time_machine/time_machine.dart';
import 'package:timetable/timetable.dart';



class TimetableExample extends StatefulWidget {
  final List<CourseEvent> courseEvents;

  TimetableExample({required this.courseEvents});

  @override
  _TimetableExampleState createState() => _TimetableExampleState();
}

class _TimetableExampleState extends State<TimetableExample> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  late TimetableController<BasicEvent> _controller;

  @override
  void initState() {
    super.initState();

    _controller = TimetableController(
      //A basic EventProvider containing a single event:
      eventProvider: EventProvider.list(widget.courseEvents),

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
      ),
        controller: _controller,
        onEventBackgroundTap: (start, isAllDay) {},
        eventBuilder: (event) {
          return BasicEventExtendedWidget(event, () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Notes((event as CourseEvent))));
          }, (event as CourseEvent).room);
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