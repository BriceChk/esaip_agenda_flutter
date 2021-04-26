import 'package:esaip_agenda_flutter/main.dart';
import 'package:esaip_agenda_flutter/models/course_event.dart';
import 'package:esaip_agenda_flutter/screens/home_page/notes.dart';
import 'package:esaip_agenda_flutter/shared/constants.dart';
import 'package:flutter/material.dart';

class BasicEventExtendedWidget extends StatelessWidget {
  BasicEventExtendedWidget(this.event);

  final CourseEvent event;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      color: event.color,
      child: InkWell(
        borderRadius: BorderRadius.circular(4),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Notes(MyApp.events.indexOf(event))));
        },
        child: Padding(
          padding: EdgeInsets.fromLTRB(4, 2, 4, 0),
          child: DefaultTextStyle(
            style: TextStyle(
              fontFamily: FONT_NUNITO,
              fontSize: 12,
              color: Colors.black,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
                SizedBox(height: 2.5),
                Text(
                  event.room,
                  style: TextStyle(
                    color: COLOR_GREY.withOpacity(0.65),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
