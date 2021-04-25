import 'package:esaip_agenda_flutter/models/course_event.dart';
import 'package:esaip_agenda_flutter/screens/home_page/notes.dart';
import 'package:esaip_agenda_flutter/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class MyEventCard extends StatefulWidget {
  MyEventCard(this.event, this.opennedState);

  final CourseEvent event;
  final bool opennedState;

  @override
  _MyEventCardState createState() => _MyEventCardState();
}

class _MyEventCardState extends State<MyEventCard> {
  late Color colorText;
  late Color colorCard;
  late Color colorButton;

  @override
  void initState() {
    super.initState();
    switch (widget.event.type) {
      case Type.EXAM:
         colorText = COLOR_RED_TEXT;
         colorCard = COLOR_RED_CARD;
         colorButton = COLOR_RED_CARD_BUTTON;
         break;
      case Type.COURS:
        colorText = COLOR_GREEN_TEXT;
        colorCard = COLOR_GREEN_CARD;
        colorButton = COLOR_GREEN_CARD_BUTTON;
        break;
      default:
        colorText = COLOR_PURPLE_TEXT;
        colorCard = COLOR_PURPLE_CARD;
        colorButton = COLOR_PURPLE_CARD_BUTTON;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 100,
      ),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 2.5),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            width: MediaQuery.of(context).size.width - 40,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: colorCard,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.event.name,
                  style: TextStyle(
                    color: colorText,
                    fontSize: 20,
                    fontFamily: FONT_NUNITO,
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 3),
                      child: Icon(
                        FontAwesomeIcons.clock,
                        size: 15,
                        color: colorText,
                      ),
                    ),
                    SizedBox(width: 7.5),
                    Text(
                      formatHours(widget.event.startsAt) + ' - ' + formatHours(widget.event.endsAt),
                      style: TextStyle(
                        color: colorText,
                        fontSize: 16,
                        fontFamily: FONT_NUNITO,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 3),
                              child: Icon(
                                FontAwesomeIcons.mapMarkerAlt,
                                size: 15,
                                color: colorText,
                              ),
                            ),
                            SizedBox(width: 7.5),
                            Text(
                              widget.event.room,
                              style: TextStyle(
                                color: colorText,
                                fontSize: 16,
                                fontFamily: FONT_NUNITO,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 3),
                              child: Icon(
                                FontAwesomeIcons.userAlt,
                                size: 15,
                                color: colorText,
                              ),
                            ),
                            SizedBox(width: 7.5),
                            Text(
                              widget.event.teacher,
                              style: TextStyle(
                                color: colorText,
                                fontSize: 16,
                                fontFamily: FONT_NUNITO,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    _buildNoteIcon(widget.opennedState),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNoteIcon(bool openState){
    if (openState){
      return Container(
        height: 50,
        width: 50,
        child: Stack(
          children: [
            Center(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(7.5),
                  onTap: () {
                    Navigator.push(context, CupertinoPageRoute(builder: (_) {
                      return Notes(widget.event);
                    },
                    ));},

                  splashColor: Colors.white,
                  child: Ink(
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: colorButton.withOpacity(0.75),
                        borderRadius: BorderRadius.circular(7.5),
                      ),
                      child: Center(
                        child: Icon(
                          FontAwesomeIcons.stickyNote,
                          color: colorText,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            _buildNumberOfNote(widget.event.notes.length),
          ],
        ),
      );
    }
    else {
      return Container(
        height: 50,
        width: 50,
      );
    }
  }

  Widget _buildNumberOfNote(int nbNote){
    if (nbNote == 0){
      return Container();
    }
    else {
      return Positioned(
        right: 0,
        child: Container(
          height: 15,
          width: 15,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: colorText,
          ),
          child: Center(
            child: Text(
              nbNote.toString(),
              style: TextStyle(
                fontSize: 9,
                fontFamily: FONT_NUNITO,
                color: COLOR_WHITE_GREY,
              ),
            ),
          ),
        ),
      );
    }
  }
}
