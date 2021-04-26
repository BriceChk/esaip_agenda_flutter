import 'package:esaip_agenda_flutter/models/course_event.dart';
import 'package:esaip_agenda_flutter/models/course_note.dart';
import 'package:esaip_agenda_flutter/services/api.dart';
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
        backgroundColor: COLOR_GREY,
        onPressed: () {
          _showMyDialog(context, null);
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
            'Aucune note',
            style: TextStyle(
              fontFamily: FONT_NUNITO,
              fontSize: 16,
            ),
          ),
        ],
      );
    } else {
      return Container(
        height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom - 280,
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: widget.event.notes.map((e) => _buildNote(e)).toList(),
        ),
      );
    }
  }

  Widget _buildNote(CourseNote note) {
    var df = DateFormat('dd MMM yyyy - H:mm', 'fr_FR');
    return GestureDetector(
      onTap: () {
        _showMyDialog(context, note);
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 40,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: COLOR_GREY.withOpacity(0.2),
              spreadRadius: 0.5,
              blurRadius: 3,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
          border: Border.all(
            width: 0.75,
            color: COLOR_GREY.withOpacity(0.5),
          ),
          color: COLOR_WHITE,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              df.format(note.createdDate),
              style: TextStyle(fontFamily: FONT_NUNITO, color: Colors.grey[500]),
            ),
            Text(
              note.content,
              style: TextStyle(fontFamily: FONT_NUNITO),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showMyDialog(BuildContext context, CourseNote? note) async {
    TextEditingController textEditingController = TextEditingController();

    List<Widget> actions = [
      TextButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all<Color>(COLOR_WHITE_GREY),
        ),
        child: Text(
          'Annuler',
          style: TextStyle(
            fontFamily: FONT_NUNITO,
            fontSize: 14,
          ),
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      TextButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all<Color>(COLOR_WHITE_GREY),
        ),
        child: Text(
          'Enregistrer',
          style: TextStyle(
              fontFamily: FONT_NUNITO,
              fontSize: 14,
              color: Colors.black
          ),
        ),
        onPressed: () {
          if (textEditingController.text != '') {
            if (note != null) {
              note.content = textEditingController.text;
              updateNote(note).then((value) {
                Navigator.pop(context, true);
                if (value == null) {
                  //TODO Error
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      'Une erreur est survenu, la note n\'a pas été enregister',
                      style: TextStyle(fontFamily: FONT_NUNITO),
                    ),
                    duration: Duration(seconds: 3),
                  ));
                } else {
                  setState(() {
                    widget.event.notes.remove(note);
                    widget.event.notes.insert(0, value);
                  });
                }
              });
            } else {
              addNote(widget.event, textEditingController.text).then((value) {
                Navigator.pop(context, true);
                if (value == null) {
                  //TODO Error
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      'Une erreur est survenu, la note n\'a pas été enregister',
                      style: TextStyle(fontFamily: FONT_NUNITO),
                    ),
                    duration: Duration(seconds: 3),
                  ));
                } else {
                  setState(() {
                    widget.event.notes.add(value);
                  });
                }
              });
            }
          }
        },
      ),
    ];

    if (note != null) {
      textEditingController.text = note.content;
      actions.insert(1, TextButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all<Color>(COLOR_RED_CARD),
        ),
        onPressed: () {
          deleteNote(note).then((value) {
            Navigator.pop(context, true);
            setState(() {
              widget.event.notes.remove(note);
            });
          });
        },
        child: Text(
          'Supprimer',
          style: TextStyle(
            fontFamily: FONT_NUNITO,
            fontSize: 14,
            color: Colors.redAccent,
          ),
        ),
      ));
    }

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Rédiger une note',
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
                  autofocus: true,
                  minLines: 1,//Normal textInputField will be displayed
                  maxLines: 5,// when user presses enter it will adapt to it
                ),
              ],
            ),
          ),
          actions: actions,
        );
      },
    );
  }
}
