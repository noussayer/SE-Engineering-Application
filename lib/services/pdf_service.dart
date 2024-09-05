import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:se_project/common/constants/error_handling.dart';
import 'package:se_project/common/constants/global_variables.dart';
import 'package:se_project/common/constants/utils.dart';
import 'package:se_project/models/pdf.dart';
import 'package:http/http.dart' as http;
import 'package:se_project/providers/user_provider.dart';

class PdfService {
  void uploadPdf({
    required BuildContext context,
    required String customer,
    required List<File> pdfs,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic('duenmski3', 'alvvwewb');
      List<String> pdfUrls = [];
      for(int i=0; i<pdfs.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(CloudinaryFile.fromFile(pdfs[i].path, folder: customer, resourceType: CloudinaryResourceType.Auto));
        pdfUrls.add(res.secureUrl);
      }
      Pdf pdf = Pdf(
        customer: customer,
        pdfs: pdfUrls, 
        );
      http.Response res = await http.post(
          Uri.parse('$uri/admin/add-pdf'), 
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
            },
          body: pdf.toJson(),
        );
        httpErrorHandle(
          response: res, 
          context: context, 
          onSuccess:() { 
            showSnackBar(context, 'PDF Added successfully');
          },
          );

    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
  // Get all the pdfs:
  Future<List<Pdf>> fetchAllPdfs(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Pdf> pdfsList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/admin/get-pdfs'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        );
        httpErrorHandle(
          response: res, 
          context: context, 
          onSuccess: () {
            for( int i=0; i<jsonDecode(res.body).length; i++) {
              pdfsList.add(
                Pdf.fromJson(
                  jsonEncode(
                    jsonDecode(res.body)[i],
                    ),
                    ),

              );
            }
          }
        );
    } catch(e) {
      showSnackBar(context, e.toString());
    }
    return pdfsList;
  }
  // deleting pdf
  void deletePdf({
    required BuildContext context, 
    required Pdf pdf, 
    required VoidCallback onSuccess
    }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
        http.Response res = await http.post(
          Uri.parse('$uri/admin/delete-pdf'), 
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
            },
          body: jsonEncode({
            'id': pdf.id,
          }),
        );
        httpErrorHandle(
          response: res, 
          context: context, 
          onSuccess:() { 
            onSuccess();
          },
          );

    } catch (e) {
      showSnackBar(context, e.toString());
    }

    }
  Future<List<Pdf>> fetchSearchedPdf({
    required BuildContext context, 
    required String searchQuery
    }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Pdf> pdfList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/pdfs/search/$searchQuery'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        );
        httpErrorHandle(
          response: res, 
          context: context, 
          onSuccess: () {
            for( int i=0; i<jsonDecode(res.body).length; i++) {
              pdfList.add(
                Pdf.fromJson(
                  jsonEncode(
                    jsonDecode(res.body)[i],
                    ),
                    ),

              );
            }
          }
        );
    } catch(e) {
      showSnackBar(context, e.toString());
    }
    return pdfList;

  }
}