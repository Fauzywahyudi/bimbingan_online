import 'dart:async';

import 'package:bimbingan_online/providers/proposal_provider.dart';
import 'package:bimbingan_online/utils/assets.dart';
import 'package:bimbingan_online/views/dosen/pages/fitur_kaprodi/proposal/confirm_proposal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:flutter_expanded_tile/tileController.dart';
import 'package:google_fonts/google_fonts.dart';

class ProposalPage extends StatefulWidget {
  static const routeName = '/ProposalPage';
  @override
  _ProposalPageState createState() => _ProposalPageState();
}

class _ProposalPageState extends State<ProposalPage>
    with TickerProviderStateMixin {
  TabController tabController;
  ExpandedTileController _controller;

  ProposalProvider _proposalProvider = ProposalProvider();

  Future<List> _getMahasiswa(String status) async {
    final result = await _proposalProvider.getProposal(context, status);
    return result;
  }

  Future<Null> handleRefresh() async {
    Completer<Null> completer = new Completer<Null>();
    new Future.delayed(new Duration(milliseconds: 500)).then((_) {
      completer.complete();
      setState(() {});
    });
    return completer.future;
  }

  @override
  void initState() {
    tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Proposal"),
        bottom: TabBar(
          controller: tabController,
          labelColor: colLight,
          indicatorColor: colPrimary,
          indicatorWeight: 5,
          tabs: <Widget>[
            Tab(
              text: "Confirm",
            ),
            Tab(
              text: "Proses",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: <Widget>[
          _buildConfirm(),
          _buildPending(),
        ],
      ),
    );
  }

  Widget _buildConfirm() {
    return Container(
      child: FutureBuilder<List>(
        future: _getMahasiswa("Acc"),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? RefreshIndicator(
                  onRefresh: handleRefresh,
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(Icons.person),
                        title: Text(
                          snapshot.data[index]['nama_mahasiswa'],
                          style: GoogleFonts.mcLaren(),
                        ),
                        subtitle: Text(
                            "NIM :" + snapshot.data[index]['nim_mahasiswa']),
                      );
                    },
                  ),
                )
              : loadingCircular();
        },
      ),
    );
  }

  Widget _buildPending() {
    return Container(
      child: FutureBuilder<List>(
        future: _getMahasiswa("Proses"),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? RefreshIndicator(
                  onRefresh: handleRefresh,
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                          leading: Icon(Icons.person),
                          title: Text(
                            snapshot.data[index]['nama_mahasiswa'],
                            style: GoogleFonts.mcLaren(),
                          ),
                          subtitle: Text(
                            "NIM :" + snapshot.data[index]['nim_mahasiswa'],
                          ),
                          onTap: () async {
                            await pushPage(
                              context,
                              ConfirmProposal(data: snapshot.data[index]),
                            );
                            handleRefresh();
                          });
                    },
                  ),
                )
              : loadingCircular();
        },
      ),
    );
  }
}
