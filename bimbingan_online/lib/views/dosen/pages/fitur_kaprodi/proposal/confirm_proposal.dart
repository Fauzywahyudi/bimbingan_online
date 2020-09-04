import 'package:bimbingan_online/providers/proposal_provider.dart';
import 'package:bimbingan_online/utils/assets.dart';
import 'package:flutter/material.dart';

class ConfirmProposal extends StatefulWidget {
  final data;

  const ConfirmProposal({Key key, this.data}) : super(key: key);
  @override
  _ConfirmProposalState createState() => _ConfirmProposalState();
}

class _ConfirmProposalState extends State<ConfirmProposal> {
  ProposalProvider _proposalProvider = ProposalProvider();

  void _konfirmasi(String status) async {
    await _proposalProvider.konfirmasi(
        context, int.parse(widget.data['id_proposal']), status);
    popPage(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data['nama_mahasiswa']),
      ),
    );
  }
}
