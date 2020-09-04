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
        context,
        int.parse(widget.data['id_proposal']),
        int.parse(widget.data['id_mahasiswa']),
        status);
    popPage(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data['nama_mahasiswa']),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildListTile(
                  widget.data['nim_mahasiswa'], "NIM Mahasiswa", Icons.person),
              _buildListTile(widget.data['nama_mahasiswa'], "Nama Mahasiswa",
                  Icons.person),
              _buildListTile(
                  widget.data['judul'], "Judul Proposal", Icons.title),
              _buildListTile(
                  widget.data['file'], "File Document", Icons.note_add,
                  trailing: IconButton(
                    icon: Icon(Icons.file_download),
                    onPressed: () {},
                  )),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: colDanger,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      tooltip: 'Batalkan',
                      icon: Icon(Icons.close),
                      color: colLight,
                      onPressed: () => _konfirmasi("Ditolak"),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: colSuccess,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      tooltip: 'Konfirmasi',
                      icon: Icon(Icons.check),
                      color: colLight,
                      onPressed: () => _konfirmasi("Acc"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListTile _buildListTile(String title, String subTitle, IconData icon,
      {Widget trailing}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subTitle),
      trailing: trailing,
    );
  }
}
