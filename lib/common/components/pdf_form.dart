import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:se_project/common/constants/utils.dart';
import 'package:se_project/services/pdf_service.dart';

class PdfForm extends StatefulWidget {
  const PdfForm({super.key});

  @override
  State<PdfForm> createState() => _PdfFormState();
}

class _PdfFormState extends State<PdfForm> {
  final _signInFormKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  List<File> selectedPdfs = [];
  final PdfService pdfService = PdfService();

   @override
  void dispose() {
    super.dispose();
    nameController.dispose();
  }
   Future<void> pickPdfFiles() async {
    List<File> files = await pickPdf();
    setState(() {
      selectedPdfs = files;
    });
  }
void uploadPdf() {
  if (selectedPdfs.isNotEmpty) {
    pdfService.uploadPdf(
      context: context, 
      customer: nameController.text, 
      pdfs: selectedPdfs,
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('You should pick a PDF file'),
      ),
    );
  }
}
void onTap() {
    pickPdfFiles();
    uploadPdf();
    }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _signInFormKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Name",
              style: TextStyle(color: Colors.black54),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 16),
              child: TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: SvgPicture.asset("assets/icons/email.svg"),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30,),
            Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text('Select PDF Files', style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                      ),
                    ),
                    SizedBox(width: 30,),
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Color(0xff4c505b),
                      child: IconButton(
                        color: Colors.white,
                        onPressed: () {
                          if (_signInFormKey.currentState!.validate()) {pickPdfFiles();}},
                        icon: Icon(Icons.file_upload),
                      ),
                    ),
                  ],
                ),
           
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 24),
              child: ElevatedButton.icon(
                onPressed:  () {if (_signInFormKey.currentState!.validate()) {uploadPdf();}},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF77D8E),
                  minimumSize: const Size(double.infinity, 56),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                      bottomLeft: Radius.circular(25),
                    ),
                  ),
                ),
                icon: const Icon(
                  CupertinoIcons.folder_circle,
                  color: Color.fromARGB(255, 42, 0, 254),
                ),
                label: const Text("Upload Document", style: TextStyle(color: Colors.black, fontSize: 20),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}