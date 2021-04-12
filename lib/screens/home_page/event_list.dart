import 'package:esaip_agenda_flutter/models/event.dart';
import 'package:esaip_agenda_flutter/shared/Components/my_event_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventList extends StatelessWidget {
  final List<Event> event;
  EventList({required this.event});


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: 20),
        child: Column(
          children: event.map((e) => _buildEventCard(e, context)).toList(),
        ),
      ),
    );
  }

  Widget _buildEventCard(Event e, BuildContext context) {
    return Hero(
      tag: e.id.toString(),
      child: MyEventCard(e),
    );
  }
}
