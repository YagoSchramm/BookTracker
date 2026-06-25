import 'dart:io';

abstract class FileService{
  Future<String> importPdf(File pickedFile);
  Future<File?> pickPdf();
}