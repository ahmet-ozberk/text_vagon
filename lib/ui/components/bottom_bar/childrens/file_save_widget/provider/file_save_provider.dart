import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';

import 'package:text_vagon/app/constant/app_string.dart';


final fileSaveProvider = ChangeNotifierProvider((ref) => FileSaveProvider());

class FileSaveProvider extends ChangeNotifier {
  final fileNameController = TextEditingController();

  Future<bool> saveFile(String data) async {
    try {
      String? outputFile = await FilePicker.platform.saveFile(
        dialogTitle: AppString.saveFile,
        type: FileType.custom,
        fileName: "${fileNameController.text}.md",
        allowedExtensions: ['md'],
      );
      if (outputFile == null) {
        return false;
      }
      final file = File(outputFile);
      await file.writeAsString(data);
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<File?> openFile()async{
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['md'],
      );
      if (result != null) {
        File file = File(result.files.single.path!);
        return file;
      } else {
        return File("");
      }
    } catch (e) {
      log(e.toString());
      return null; 
    }
  }
}
