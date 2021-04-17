import 'package:esaip_agenda_flutter/models/event.dart';
import 'package:esaip_agenda_flutter/shared/Components/my_event_card.dart';
import 'package:esaip_agenda_flutter/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Notes extends StatefulWidget {
  late final Event event;

  Notes(this.event);

  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  List<String> noteList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            noteList.add('value');
          });
        },
        child: Icon(FontAwesomeIcons.plus),
      ),
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
                child: MyEventCard(widget.event, false, widget.event.type)),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Text(
                'Notes',
                style: TextStyle(
                  fontSize: 22,
                  fontFamily: FONT_NUNITO,
                ),
              ),
            ),
            _buildNotesList(),
          ],
        ),
      ),
    );
  }

  Widget _buildNotesList() {
    if (noteList.isEmpty) {
      return Column(
        children: [
          Container(
            //color: Colors.amber,
            child: Image.asset(
              'assets/images/Empty.png',
              height: 200,
            ),
          ),
          SizedBox(height: 25),
          Text(
            'Aucune note de disponible',
            style: TextStyle(
                fontFamily: FONT_NUNITO,
                fontSize: 16,
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: noteList.map((e) => _buildNote(e)).toList(),
      );
    }
  }

  Widget _buildNote(String note) {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      decoration: BoxDecoration(
          color: Colors.amber, borderRadius: BorderRadius.circular(20)),
      child: Text(
        note,
        style: TextStyle(fontFamily: FONT_NUNITO),
      ),
    );
  }
}
