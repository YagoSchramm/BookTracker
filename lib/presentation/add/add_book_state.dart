import 'dart:io';

import 'package:book_tracker/global.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class AddBookState extends ChangeNotifier {
  TextEditingController titleController = TextEditingController();
  String selectedPdfName = "";
  File? file;
  bool isLoading = false;
  Future<bool> pickPdf() async {
    file = await fileService.pickPdf();
    if (file == null) return false;
    selectedPdfName = basename(file!.path);
    notifyListeners();
    return true;
  }

  Future<bool> saveBook() async {
    if (file == null) return false;
    if (titleController.text.isEmpty) return false;
    isLoading = true;
    notifyListeners();
    String pdfPath = await fileService.importPdf(file!);
    String coverPath = await pdfService.generateCover(pdfPath);
    bookService.insertBook(titleController.text, pdfPath, coverPath);
    isLoading = false;
    titleController.text = "";
    selectedPdfName = "";
    file=null;
    notifyListeners();
    return true;
  }
}
