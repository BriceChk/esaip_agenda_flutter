import 'package:esaip_agenda_flutter/models/event.dart';
import 'package:esaip_agenda_flutter/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EventList extends StatelessWidget {
  final List<Event> event;
  EventList({required this.event});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: SingleChildScrollView(
        child: Column(
          children: event.map((e) => _buildEventCard(e, context)).toList(),
        ),
      ),
    );
  }

  Widget _buildEventCard(Event e, BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 150,
      ),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 7.5),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            width: MediaQuery.of(context).size.width - 40,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: COLOR_RED_CARD,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  e.name,
                  style: TextStyle(
                    color: COLOR_RED_TEXT,
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
                        color: COLOR_RED_TEXT,
                      ),
                    ),
                    SizedBox(width: 7.5),
                    Text(
                      e.hours,
                      style: TextStyle(
                        color: COLOR_RED_TEXT,
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
                                color: COLOR_RED_TEXT,
                              ),
                            ),
                            SizedBox(width: 7.5),
                            Text(
                              e.classroom,
                              style: TextStyle(
                                color: COLOR_RED_TEXT,
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
                                color: COLOR_RED_TEXT,
                              ),
                            ),
                            SizedBox(width: 7.5),
                            Text(
                              e.teacher,
                              style: TextStyle(
                                color: COLOR_RED_TEXT,
                                fontSize: 16,
                                fontFamily: FONT_NUNITO,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      //color: Colors.amber,
                      child: Stack(
                        children: [
                          Center(
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: COLOR_RED_CARD_BUTTON.withOpacity(0.75),
                                borderRadius: BorderRadius.circular(7.5),
                              ),
                            ),
                          ),
                          Center(
                            child: Icon(
                              FontAwesomeIcons.stickyNote,
                              color: COLOR_RED_TEXT,
                            ),
                          ),
                          Positioned(
                            right: 0,
                            child: Container(
                              height: 15,
                              width: 15,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: COLOR_RED_TEXT,
                              ),
                              child: Center(
                                child: Text(
                                  '1',
                                  style: TextStyle(
                                    fontSize: 9,
                                    fontFamily: FONT_NUNITO,
                                    color: COLOR_WHITE_GREY,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
