import 'dart:io';

import 'package:book_tracker/services/pdf.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdfx/pdfx.dart';

PdfService newPdfService() {
  return _PdfService();
}

class _PdfService implements PdfService {
  @override
  Future<String> generateCover(String pdfPath) async {
    final document = await PdfDocument.openFile(pdfPath);
    final page = await document.getPage(1);
    final pageImage = await page.render(width: page.width, height: page.height);
    await page.close();
    Directory directory = await getApplicationDocumentsDirectory();
    final imagesDir = Directory(join(directory.path, "images"));
    await imagesDir.create(recursive: true);
    final String coverPath = join(
      directory.path,
      "images",
      "${DateTime.now().millisecondsSinceEpoch}.png",
    );
    final coverFile = File(coverPath);
    await coverFile.writeAsBytes(pageImage!.bytes);
    return coverPath;
  }
}
