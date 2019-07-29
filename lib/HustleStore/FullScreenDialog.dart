import 'package:flutter/material.dart';
import 'HustleStore.dart';

class AddEntryDialog extends StatefulWidget {
  AddEntryDialog(
      {Key key,
      this.points,
      this.available,
      this.descript,
      this.image,
      this.title})
      : super(key: key);
  int points;
  int available;
  String descript;
  String image;
  String title;
  @override
  AddEntryDialogState createState() => new AddEntryDialogState();
}

class AddEntryDialogState extends State<AddEntryDialog> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text(widget.title),
        actions: [
          new FlatButton(
            onPressed: () {
              widget.available = widget.available - widget.points;
              print(widget.available);
              Navigator.pop(context);
            },
            child: new Text(
              'Yes',
              style: Theme.of(context)
                  .textTheme
                  .subhead
                  .copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.0000001),
              child: Card(
                child: Padding(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.height * 0.05),
                    child: Column(
                      children: <Widget>[
                        Image.network(
                          widget.image,
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width * 0.5,
                        ),
                        Text(
                          widget.descript.replaceAll(".", ".\n\n"),
                          textAlign: TextAlign.center,
                        )
                      ],
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
