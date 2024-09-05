import 'package:flutter/material.dart';
import 'package:se_project/entry_point.dart';
import 'package:se_project/features/about/about_screen.dart';
import 'package:se_project/features/admin/add_product_screen.dart';
import 'package:se_project/features/auth/auth_screen.dart';
import 'package:se_project/features/home/home_screen.dart';
import 'package:se_project/features/pdf/pdf_search_screen.dart';
import 'package:se_project/features/product_details/product_details_screen.dart';
import 'package:se_project/features/search/search_screen.dart';
import 'package:se_project/features/update/update_product_screen.dart';
import 'package:se_project/models/product.dart';


Route<dynamic> generateRoute (RouteSettings routeSettings) {
  switch(routeSettings.name){
    case AuthScreen.routeName: 
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );
    case HomeScreen.routeName: 
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );
    case AboutScreen.routeName: 
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AboutScreen(),
      );
      
    
    
    case EntryPoint.routeName: 
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const EntryPoint(),
      );
    case AddProductScreen.routeName: 
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddProductScreen(),
      );
    
    case SearchScreen.routeName:
    var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) =>  SearchScreen(searchQuery: searchQuery),
      );
    case ProductDetailsScreen.routeName:
    var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) =>  ProductDetailsScreen(product: product),
      );
    case PdfSearchScreen.routeName:
    var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) =>  PdfSearchScreen(searchQuery: searchQuery),
      );
    
    case UpdateProductScreen.routeName:
    var product = routeSettings.arguments as Product;
    var id = routeSettings.arguments as String?;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) =>  UpdateProductScreen(product: product, id: id),
      );
    
    
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist'),
          ),
        ),
      ); 
  }
}