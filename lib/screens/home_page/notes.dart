import 'package:esaip_agenda_flutter/models/course_event.dart';
import 'package:esaip_agenda_flutter/models/course_note.dart';
import 'package:esaip_agenda_flutter/shared/Components/my_event_card.dart';
import 'package:esaip_agenda_flutter/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Notes extends StatefulWidget {
  late final CourseEvent event;

  Notes(this.event);

  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLOR_WHITE,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            widget.event.notes.add(CourseNote(id: -1, content: 'A FAIRE', createdDate: DateTime.now()));
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
                child: MyEventCard(widget.event, false)),
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
    if (widget.event.notes.isEmpty) {
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
        children: widget.event.notes.map((e) => _buildNote(e)).toList(),
      );
    }
  }

  //TODO Afficher date
  Widget _buildNote(CourseNote note) {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      decoration: BoxDecoration(
          color: Colors.amber, borderRadius: BorderRadius.circular(20)),
      child: Text(
        note.content,
        style: TextStyle(fontFamily: FONT_NUNITO),
      ),
    );
  }
}
