import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HelpAndFaq extends StatefulWidget {
  @override
  _HelpAndFaqState createState() => _HelpAndFaqState();
}

class _HelpAndFaqState extends State<HelpAndFaq> {
  LongPressGestureRecognizer longPressGestureRecognizer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    longPressGestureRecognizer = LongPressGestureRecognizer();}

  void _handlePress(BuildContext context) {
    ClipboardManager.copyToClipBoard("your text to copy").then((result) {
      final snackBar = SnackBar(
        content: Text('Copied to Clipboard'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {},
        ),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    longPressGestureRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help and FAQ"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Card(
              elevation: 0,
              child: Text(
                "Help and FAQ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              elevation: 2.0,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            "We are always ready to help you out in your journey to become an Entrepreneur :)\n\n",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          // fontStyle: FontStyle.italic,
                        ),
                      ),
                      TextSpan(
                        text:
                            "For any help using this application or giving feedback on it, do drop us a line at\n\n",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          // fontStyle: FontStyle.italic,
                        ),
                      ),
                      TextSpan(
                        // recognizer: longPressGestureRecognizer.onLongPress,                
                        text: "startupreneur.official@gmail.com\n\n",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                          // fontStyle: FontStyle.italic,
                        ),
                      ),
                      TextSpan(
                        text:
                            "We will get back to you as soon as we can, in the meanwhile keep the journey going!\n\n",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          // fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// startupreneur.official@gmail.com
