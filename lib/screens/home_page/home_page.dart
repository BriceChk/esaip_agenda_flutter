import 'package:esaip_agenda_flutter/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: COLOR_WHITE,
        leading: Padding(
          padding: EdgeInsets.only(left: 20),
          child: IconButton(
            splashRadius: 25,
            icon: Icon(FontAwesomeIcons.bars),
            onPressed: (){},
          ),
        ),
        title: Text(
          'Agenda ESAIP',
          style: TextStyle(
            fontFamily: FONT_NUNITO,
            color: COLOR_GREY,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(75),
          child: Column(
            children: [
              Container(
                height: 40,
                width: 250,
                decoration: BoxDecoration(
                  color: COLOR_GREY,
                  borderRadius: BorderRadius.circular(
                    25.0,
                  ),
                ),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    border: Border.all(
                      color: COLOR_GREY,
                      width: 1.5,
                    ),
                    color: COLOR_WHITE,
                  ),
                  labelColor: COLOR_GREY,
                  unselectedLabelColor: COLOR_WHITE,
                  tabs: [
                    Tab(
                      child: Text(
                        'Liste',
                        style: TextStyle(
                          fontFamily: FONT_NUNITO,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Grille',
                        style: TextStyle(
                          fontFamily: FONT_NUNITO,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        color: COLOR_WHITE,
        child: TabBarView(
          controller: _tabController,
          children: [
            Center(
              child: Text(
                'Liste',
                style: TextStyle(
                  fontFamily: FONT_NUNITO,
                  fontSize: 18,
                ),
              ),
            ),
            Center(
              child: Text(
                'Grille',
                style: TextStyle(
                  fontFamily: FONT_NUNITO,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}