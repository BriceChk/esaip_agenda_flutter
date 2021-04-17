import 'package:esaip_agenda_flutter/models/event.dart';
import 'package:esaip_agenda_flutter/shared/Components/my_event_card.dart';
import 'package:esaip_agenda_flutter/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventList extends StatelessWidget {
  final List<Event> event;
  EventList({required this.event});
  String date = "";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          children: event.map((e) => _buildList(e, context)).toList(),
        ),
    );
  }

  Widget _buildEventCard(Event e, BuildContext context) {
    return Hero(
      tag: e.id.toString(),
      child: MyEventCard(e, true, e.type),
    );
  }

  Widget _buildDate(Event e){
    return Container(
      padding: EdgeInsets.only(top: 15),
      child: Text(
        e.date,
        style: TextStyle(
          fontFamily: FONT_NUNITO,
          fontSize: 20,
          color: COLOR_GREY,
        ),
      ),
    );
  }

  Widget _buildList(Event e, BuildContext context) {
    if (e.date == date){
      return _buildEventCard(e, context);
    }
    else {
      date = e.date;
      return Column(
        children: [
          _buildDate(e),
          _buildEventCard(e, context),
        ],
      );
    }
  }
}
