import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class LoanOfferPdfViewerScreen extends StatefulWidget {
  final String pdfUrl;

  const LoanOfferPdfViewerScreen({Key? key, required this.pdfUrl})
      : super(key: key);

  @override
  _LoanOfferPdfViewerScreenState createState() =>
      _LoanOfferPdfViewerScreenState();
}

class _LoanOfferPdfViewerScreenState extends State<LoanOfferPdfViewerScreen> {
  late PDFViewController _pdfViewController;
  late String _downloadedFilePath;

  @override
  void initState() {
    super.initState();
    _downloadedFilePath = '';
    _downloadPdf();
  }

  Future<void> _downloadPdf() async {
    try {
      Dio dio = Dio();
      Response response = await dio.get(
        widget.pdfUrl,
        options: Options(responseType: ResponseType.bytes),
      );

      // Extract the last part of the URL and use it to generate the file name
      String fileName =
          'loan_offer_${widget.pdfUrl.split('/').last.split('.').first}.pdf';

      // Save the downloaded file to a temporary location with the generated file name
      _downloadedFilePath = await _saveFile(response.data, fileName);
      setState(() {});
    } catch (e) {
      debugPrint('Error downloading PDF: $e');
      _downloadedFilePath = 'Unable to download loan offer letter';
      debugPrint('_downloadedFilePath: $_downloadedFilePath');
    }
  }

  Future<String> _saveFile(List<int> bytes, String fileName) async {
    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/$fileName');
    await file.writeAsBytes(bytes);
    return file.path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const RexAppBar(
        shouldHaveBackButton: true,
        title: StringAssets.loanOfferLetter,
      ),
      body: _downloadedFilePath.isNotEmpty
          ? _downloadedFilePath != 'Unable to download loan offer letter'
              ? PDFView(
                  filePath: _downloadedFilePath,
                  autoSpacing: true,
                  enableSwipe: true,
                  pageSnap: true,
                  pageFling: true,
                  onError: (error) {
                    debugPrint('PDF ERROR:$error');
                  },
                  onPageError: (page, error) {
                    debugPrint('$page: ${error.toString()}');
                  },
                  onRender: (_pages) {
                    // PDF has been rendered
                    debugPrint('PDF has been rendered: ${widget.pdfUrl}');
                  },
                  onViewCreated: (PDFViewController pdfViewController) {
                    _pdfViewController = pdfViewController;
                  },
                )
              : Center(child: Text(_downloadedFilePath))
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
