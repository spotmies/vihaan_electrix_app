import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

pdfViewer() {
  return PDF(
    enableSwipe: false,
    swipeHorizontal: false,

    autoSpacing: false,
    pageFling: false,
    preventLinkNavigation: false,
    pageSnap: true,
    // onPageChanged: (int? current, int? total) =>
    //     _pageCountController.add('${current! + 1} - $total'),
    // onViewCreated: (PDFViewController pdfViewController) async {
    //   _pdfViewController.complete(pdfViewController);
    //   final int currentPage = await pdfViewController.getCurrentPage() ?? 0;
    //   final int? pageCount = await pdfViewController.getPageCount();
    //   _pageCountController.add('${currentPage + 1} - $pageCount');
    // },
  ).fromUrl(
    'https://firebasestorage.googleapis.com/v0/b/vihaan-electrix.appspot.com/o/0A-ESP8266__Datasheet__EN_v4.3.pdf?alt=media&token=b98af751-d1a1-4fad-8c8b-c99df7fe64e4',
    placeholder: (double progress) => Center(child: Text('$progress %')),
    errorWidget: (dynamic error) => Center(child: Text(error.toString())),
  );
}
