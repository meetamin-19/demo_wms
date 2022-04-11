import 'package:demo_win_wms/app/utils/constants.dart';
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
  PdfController? _pdfController;
  static const int _initialPage = 0;

  @override
  void initState() {
    super.initState();
    _pdfController = PdfController(
        document: PdfDocument.openData(InternetFile.get(widget.path)),
        initialPage: _initialPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          leading: BackButton(),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.navigate_before),
              onPressed: () {
                _pdfController?.previousPage(
                  curve: Curves.ease,
                  duration: const Duration(milliseconds: 100),
                );
              },
            ),
            PdfPageNumber(
              controller: _pdfController!,
              builder: (_, loadingState, page, pagesCount) => Container(
                alignment: Alignment.center,
                child: Text(
                  '$page/${pagesCount ?? 0}',
                  style: const TextStyle(fontSize: 22),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.navigate_next),
              onPressed: () {
                _pdfController?.nextPage(
                  curve: Curves.ease,
                  duration: const Duration(milliseconds: 100),
                );
              },
            ),
          ],
        ),
        body: Container(
          child: PdfView(
            builders: PdfViewBuilders<DefaultBuilderOptions>(
              options: const DefaultBuilderOptions(),
              documentLoaderBuilder: (_) =>
                  const Center(child: CircularProgressIndicator()),
              pageLoaderBuilder: (_) =>
                  const Center(child: CircularProgressIndicator()),
              pageBuilder: _pageBuilder,
            ),
            controller: _pdfController!,
          ),
        ));
  }
}

PhotoViewGalleryPageOptions _pageBuilder(
  BuildContext context,
  Future<PdfPageImage> pageImage,
  int index,
  PdfDocument document,
) {
  return PhotoViewGalleryPageOptions(
    imageProvider: PdfPageImageProvider(
      pageImage,
      index,
      document.id,
    ),
    minScale: PhotoViewComputedScale.contained * 1,
    maxScale: PhotoViewComputedScale.contained * 2,
    initialScale: PhotoViewComputedScale.contained * 1.0,
    heroAttributes: PhotoViewHeroAttributes(tag: '${document.id}-$index'),
  );
}
