import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';

class PdfReader extends StatefulWidget {
  PdfReader(this.path, this.title);

  String  title;
  PDFDocument path;

  @override
  _PdfReaderState createState() => _PdfReaderState();
}

class _PdfReaderState extends State<PdfReader> {

  @override
  void initState() {

    super.initState();
    print("path from pdfreader ${widget.path}");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: PDFViewer(document: widget.path, showIndicator: true,showPicker: false,),
    );
  }
}
