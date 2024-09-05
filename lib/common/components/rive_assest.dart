
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:se_project/features/about/about_screen.dart';
import 'package:se_project/features/admin/posts_screen.dart';
import 'package:se_project/features/home/home_screen.dart';
import 'package:se_project/features/pdf/pdf_screen.dart';


class RiveAsset {
  final Widget? currentScreen;
  final String artboard, stateMachineName, title, src;
  late SMIBool? input;
  
  
  RiveAsset(this.src, {
    this.currentScreen,
    required this.artboard, 
    required this.stateMachineName,
    required this.title,
    this.input,
  });
  set setInput(SMIBool status){
    input = status;
  }
}



List<RiveAsset> sideMenus = [
  RiveAsset(
    "assets/RiveAssets/icons.riv",
    currentScreen: const HomeScreen(),
    artboard: "HOME",
    stateMachineName:"HOME_interactivity", 
    title: "Home",
  ),
  RiveAsset(
    "assets/RiveAssets/icons.riv",
    currentScreen: const PostsScreen(),
    artboard: "SEARCH",
    stateMachineName: "SEARCH_Interactivity",
    title: "Managing Maintenance",
  ),
  RiveAsset(
    "assets/RiveAssets/icons.riv",  
    currentScreen: const PdfScreen(),
    artboard: "CHAT",
    stateMachineName: "CHAT_Interactivity",
    title: "Documents",
  ),
  RiveAsset(
    "assets/RiveAssets/icons.riv",
    currentScreen: const AboutScreen(),
    artboard: "LIKE/STAR",
    stateMachineName: "STAR_Interactivity",
    title: "About",
  ),
];
List<RiveAsset> sideMenu2 = [
  RiveAsset(
    "assets/RiveAssets/icons.riv",
    artboard: "TIMER",
    stateMachineName: "TIMER_Interactivity",
    title: "Log Out",
  ),
 
];