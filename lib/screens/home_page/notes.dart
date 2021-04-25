import 'package:esaip_agenda_flutter/models/course_event.dart';
import 'package:esaip_agenda_flutter/models/course_note.dart';
import 'package:esaip_agenda_flutter/shared/Components/my_event_card.dart';
import 'package:esaip_agenda_flutter/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

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
      resizeToAvoidBottomInset: false,
      backgroundColor: COLOR_WHITE,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _showMyDialog(context);
            //widget.event.notes.add(CourseNote(id: -1, content: 'A FAIRE', createdDate: DateTime.now()));
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
          Image.asset(
            'assets/images/Empty.png',
            height: 200,
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
          color: COLOR_WHITE_GREY,
          borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        note.content,
        style: TextStyle(fontFamily: FONT_NUNITO),
      ),
    );
  }

  Future<void> _showMyDialog(BuildContext context) async {
    TextEditingController textEditingController = TextEditingController();
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Que voulez-vous noter ?',
            style: TextStyle(
              fontFamily: FONT_NUNITO,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: textEditingController,
                  keyboardType: TextInputType.multiline,
                  minLines: 1,//Normal textInputField will be displayed
                  maxLines: 5,// when user presses enter it will adapt to it
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all<Color>(COLOR_WHITE_GREY),
              ),
              child: Text(
                'Retour',
                style: TextStyle(
                  fontFamily: FONT_NUNITO,
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all<Color>(COLOR_RED_CARD_BUTTON),
              ),
              child: Text(
                'Valider',
                style: TextStyle(
                  fontFamily: FONT_NUNITO,
                  fontSize: 14,
                  color: Colors.redAccent,
                ),
              ),
              onPressed: () {
                Navigator.pop(context, true);
                setState(() {
                  if (textEditingController.text != '') {
                    widget.event.notes.add(CourseNote(id: -1, content:  DateTime.now().day.toString()+"/" + DateTime.now().month.toString() + " : " + textEditingController.text, createdDate: DateTime.now()));
                  }
                });
              },
            ),
          ],
        );
      },
    );
  }
}
