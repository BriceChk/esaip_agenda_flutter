import 'package:esaip_agenda_flutter/models/course_event.dart';
import 'package:esaip_agenda_flutter/shared/Components/my_event_card.dart';
import 'package:esaip_agenda_flutter/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventList extends StatelessWidget {
  final List<CourseEvent> courseEvents;

  EventList({required this.courseEvents});

  @override
  Widget build(BuildContext context) {
    var currentDate = '';

    return ListView.builder(
      itemCount: courseEvents.length,
      itemBuilder: (BuildContext context, int index) {
        var e = courseEvents[index];
        List<Widget> widgets = [];

        // Add date if it's not the current date
        if (formatDate(e.startsAt) != currentDate){
          currentDate = formatDate(e.startsAt);
          widgets.add(Container(
            padding: EdgeInsets.only(top: 15),
            child: Text(
              currentDate,
              style: TextStyle(
                fontFamily: FONT_NUNITO,
                fontSize: 20,
                color: COLOR_GREY,
              ),
            ),
          ));
        }

        widgets.add(Hero(
          tag: e.id.toString(),
          child: MyEventCard(e, true),
        ));

        return Column(
          children: widgets,
        );
      },
    );
  }
}
