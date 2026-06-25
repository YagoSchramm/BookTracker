abstract class PdfService {
  Future<String> generateCover(String pdfPath);
  Future<int> getBookPages(String pdfPath);
}