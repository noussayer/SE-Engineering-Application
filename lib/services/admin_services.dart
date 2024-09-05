import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:se_project/common/constants/error_handling.dart';
import 'package:se_project/common/constants/global_variables.dart';
import 'package:se_project/common/constants/utils.dart';
import 'package:se_project/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:se_project/providers/user_provider.dart';

class AdminServices {
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required String customer,
    required DateTime date,
    required String category,
    required List<File> images,



  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic('duenmski3', 'alvvwewb');
      List<String> imageUrls = [];
      for(int i=0; i<images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(CloudinaryFile.fromFile(images[i].path, folder: name));
        imageUrls.add(res.secureUrl);
      }
      Product product = Product(
        name: name, 
        description: description, 
        date: date, 
        images: imageUrls, 
        category: category, 
        customer: customer,
        );

        http.Response res = await http.post(
          Uri.parse('$uri/admin/add-product'), 
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
            },
          body: product.toJson(),
        );
        httpErrorHandle(
          response: res, 
          context: context, 
          onSuccess:() { 
            showSnackBar(context, 'Product Added successfully');
          },
          );

    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
  // Get all the products:
  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/admin/get-products'),
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
              productList.add(
                Product.fromJson(
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
    return productList;
  }
  void deleteProduct({
    required BuildContext context, 
    required Product product, 
    required VoidCallback onSuccess
    }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
        http.Response res = await http.post(
          Uri.parse('$uri/admin/delete-product'), 
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
            },
          body: jsonEncode({
            'id': product.id,
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

    // update Product:
void updateProduct({
    required BuildContext context,
    required String? id,
    required Product updatedProduct, 
    }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
        http.Response res = await http.put(
          Uri.parse('$uri/admin/update-product/$id'), 
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
            
            },
          body: jsonEncode(updatedProduct.toMap()).toString(),
        );
        httpErrorHandle(
          response: res, 
          context: context, 
          onSuccess:() { 
            showSnackBar(context, 'Product updated successfully');
          },);
           

    } catch (e) {
      showSnackBar(context, e.toString());
    }

    }

  
}