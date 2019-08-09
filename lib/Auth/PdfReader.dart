import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_plugin.dart';
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
  Widget build(BuildContext context) {
//    return PDFViewerScaffold(
//      path: widget.path,
//      appBar: AppBar(
//        title: Text(widget.title),
//      ),
//    );
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: PDFViewer(document: widget.path),
    );
  }
}
