import 'package:esaip_agenda_flutter/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:timetable/timetable.dart';
import 'package:time_machine/time_machine.dart' hide Offset;

class BasicEventExtendedWidget extends StatelessWidget {
  BasicEventExtendedWidget(
      this.basicEvent,
      this.onTap,
      this.room
      );

  final BasicEvent basicEvent;
  final VoidCallback onTap;
  final String room;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      color: basicEvent.color,
      child: InkWell(
        borderRadius: BorderRadius.circular(4),
        onTap: onTap,
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
                Text(basicEvent.title),
                SizedBox(height: 2.5),
                Text(
                  room,
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
