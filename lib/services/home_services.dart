import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:se_project/common/constants/error_handling.dart';
import 'package:se_project/common/constants/global_variables.dart';
import 'package:se_project/common/constants/utils.dart';
import 'package:se_project/models/product.dart';
import 'package:se_project/providers/user_provider.dart';
import 'package:http/http.dart' as http;

class HomeServices {
  Future<List<Product>> fetchCategoryProducts({
    required BuildContext context, 
    required String category
    }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/products?category=$category'),
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
}