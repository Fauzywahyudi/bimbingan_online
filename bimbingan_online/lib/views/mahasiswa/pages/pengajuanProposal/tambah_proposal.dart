import 'package:bimbingan_online/models/shared_preferenced.dart';
import 'package:bimbingan_online/utils/link.dart' as link;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddProposal extends StatefulWidget {
  @override
  _AddProposalState createState() => new _AddProposalState();
}

class _AddProposalState extends State<AddProposal> {
  TextEditingController controllerJudul = new TextEditingController();
  TextEditingController controllerFile = new TextEditingController();
  // TextEditingController controllerPrice = new TextEditingController();
  // TextEditingController controllerStock = new TextEditingController();
  DataShared _dataShared = DataShared();

  // ignore: non_constant_identifier_names
  void AddProposal() async {
    var url = link.Link.mahasiswa + "tambahProposal.php";
    // final response = await http.get(link.Link.mahasiswa + "getProposal.php");
    int id = await _dataShared.getId();
    await http.post(url, body: {
      "id": id.toString(),
      "judul": controllerJudul.text,
      "file": controllerFile.text,
      // "price": controllerPrice.text,
      // "stock": controllerStock.text
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Upload Proposal"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            new Column(
              children: <Widget>[
                new TextField(
                  controller: controllerJudul,
                  decoration: new InputDecoration(
                      hintText: "Inputkan Judul Proposal",
                      labelText: "Judul Proposal"),
                ),
                new TextField(
                  controller: controllerFile,
                  decoration: new InputDecoration(
                      hintText: "Inputkan File", labelText: "File Upload"),
                ),
                // new TextField(
                //   controller: controllerPrice,
                //   decoration: new InputDecoration(
                //       hintText: "Inputkan Price", labelText: "Price"),
                // ),
                // new TextField(
                //   controller: controllerStock,
                //   decoration: new InputDecoration(
                //       hintText: "Inputkan Jumlah Stock", labelText: "Stock"),
                // ),
                new Padding(
                  padding: const EdgeInsets.all(10.0),
                ),
                new RaisedButton(
                    child: new Text("Tambah Data"),
                    color: Colors.blueAccent,
                    onPressed: () {
                      AddProposal();
                      Navigator.pop(context);
                    })
              ],
            ),
          ],
        ),
      ),
    );
  }
}
