import 'package:esaip_agenda_flutter/main.dart';
import 'package:esaip_agenda_flutter/shared/Components/my_event_card.dart';
import 'package:esaip_agenda_flutter/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class EventList extends StatefulWidget {
  late final ItemScrollController itemScrollController;

  EventList(ItemScrollController itemScrollController) {
    this.itemScrollController = itemScrollController;

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      itemScrollController.jumpTo(index: MyApp.getCurrentEventIndex());
    });
  }

  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return ScrollablePositionedList.builder(
        itemScrollController: widget.itemScrollController,
        initialScrollIndex: MyApp.getCurrentEventIndex(),
        physics: BouncingScrollPhysics(),
        itemCount: MyApp.events.length,
        itemBuilder: (context, index) {
          if (index == -1) return Container();

          List<Widget> widgets = [];
          // Add date if it's not the current date
          var date = formatDate(MyApp.events[index].startsAt);
          if (index == 0 || date != formatDate(MyApp.events[index - 1].startsAt)) {
            widgets.add(Container(
              padding: EdgeInsets.only(top: 15),
              child: Text(
                date,
                style: TextStyle(
                  fontFamily: FONT_NUNITO,
                  fontSize: 20,
                  color: COLOR_GREY,
                ),
              ),
            ));
          }
          widgets.add(Hero(
            tag: MyApp.events[index].id.toString(),
            child: MyEventCard(index, true),
          ));
          return Column(
            children: widgets,
          );
        }
    );
  }
}
