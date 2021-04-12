import 'package:esaip_agenda_flutter/models/event.dart';
import 'package:esaip_agenda_flutter/shared/Components/my_event_card.dart';
import 'package:esaip_agenda_flutter/shared/constants.dart';
import 'package:flutter/material.dart';

class Notes extends StatefulWidget {
  late final Event event;
  Notes(this.event);

  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: COLOR_WHITE,
          title: Text(
            'Agenda ESAIP',
            style: TextStyle(
              fontFamily: FONT_NUNITO,
              color: COLOR_GREY,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
      ),
      body: Center(
        child: Column(
          children: [
            Hero(
              tag: widget.event.id.toString(),
              child: MyEventCard(widget.event)
            ),
          ],
        ),
      ),
    );
  }
}
