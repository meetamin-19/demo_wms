import 'package:flutter/material.dart';
import 'package:internet_file/internet_file.dart';
import 'package:pdfx/pdfx.dart';

class PdfViewScreen extends StatefulWidget {
  PdfViewScreen({Key? key, required this.path}) : super(key: key);

  final String path;

  @override
  State<PdfViewScreen> createState() => _PdfViewScreenState();
}

class _PdfViewScreenState extends State<PdfViewScreen> {
  PdfController? pdfController;
  PdfControllerPinch? pdfPinchController;

  @override
  void initState() {
    super.initState();
    pdfController = PdfController(
      document: PdfDocument.openData(InternetFile.get(widget.path)),
    );
    pdfPinchController = PdfControllerPinch(document: PdfDocument.openData(InternetFile.get(widget.path)));
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   pdfController?.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(),
        ),
        body: SingleChildScrollView(
            child: SizedBox(
                height: MediaQuery.of(context).size.height * .94,
                width: MediaQuery.of(context).size.width ,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PdfView(controller: pdfController!),
                ))));
  }
}
