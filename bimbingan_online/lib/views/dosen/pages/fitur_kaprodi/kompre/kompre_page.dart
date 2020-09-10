import 'package:bimbingan_online/utils/assets.dart';
import 'package:flutter/material.dart';

class KomprePage extends StatefulWidget {
  static const routeName = '/KomprePage';
  @override
  _KomprePageState createState() => _KomprePageState();
}

class _KomprePageState extends State<KomprePage> with TickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      floatingActionButton: _buildFab(),
      body: TabBarView(
        controller: tabController,
        children: <Widget>[
          Container(),
          Container(),
        ],
      ),
    );
  }

  FloatingActionButton _buildFab() {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {},
      tooltip: "Tambah Jadwal",
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text("Jadwal"),
      bottom: TabBar(
        controller: tabController,
        labelColor: colLight,
        indicatorColor: colPrimary,
        indicatorWeight: 5,
        onTap: (v) {
          setState(() {});
        },
        tabs: <Widget>[
          Tab(text: "Seminar Proposal"),
          Tab(text: "Kompre"),
        ],
      ),
    );
  }
}
