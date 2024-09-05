import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

Future<List<File>> pickImages() async {
  List<File> images = [];
  try{
    var files = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );
    if (files != null && files.files.isNotEmpty){
      for(int i=0; i<files.files.length; i++){
        images.add(File(files.files[i].path!));
      }

    }

  } catch (e) {
    debugPrint(e.toString());
  }
  return images;
}

Future<List<File>> pickPdf() async {
  List<File> pdfFiles = [];
  try {
    var files = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowMultiple: true,
    );
    if (files != null && files.files.isNotEmpty) {
      for (var file in files.files) {
        if (file.path != null) {
          pdfFiles.add(File(file.path!));
        }
      }
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return pdfFiles;
}
  void openPdfFile(String pdfLink) async {
    if (await canLaunch(pdfLink)) {
      await launch(pdfLink);
      } else {
        throw 'Could not launch';
        }}