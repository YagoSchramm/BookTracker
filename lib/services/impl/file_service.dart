import 'dart:io';

import 'package:book_tracker/services/file.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

FileService newFileService(){
  return _FileService();
}

class _FileService implements FileService {
  @override
  Future<String> importPdf(File pickedFile) async {
    Directory documents = await getApplicationDocumentsDirectory();
    String newPath = join(
      documents.path,
      "${DateTime.now().microsecondsSinceEpoch.toString()}.pdf",
    );
    File newFile = await pickedFile.copy(newPath);
    return newFile.path;
  }

  @override
  Future<File?> pickPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
   if (result == null) return null;

  final path = result.files.first.path;
  if (path == null) return null;

  return File(path);
  }
}
