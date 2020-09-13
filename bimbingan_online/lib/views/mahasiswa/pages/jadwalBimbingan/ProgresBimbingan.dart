import 'package:flutter/material.dart';

class ProgresBimbingan extends StatefulWidget {
  static const routeName = '/ProgresBimbingan';
  @override
  _ProgresBimbinganState createState() => new _ProgresBimbinganState();
}

class _ProgresBimbinganState extends State<ProgresBimbingan>
    with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    controller = new TabController(vsync: this, length: 2);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        title: new Text("Progres Bimbingan"),
        bottom: new TabBar(
          controller: controller,
          tabs: <Widget>[
            new Tab(
              text: "Pembimbing 1",
            ),
            new Tab(
              text: "Pembimbing 2",
            ),
          ],
        ),
      ),
      body: TabBarView(children: <Widget>[]),
    );
  }
}
