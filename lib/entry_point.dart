
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:se_project/common/components/menu_btn.dart';
import 'package:se_project/common/components/side_menu.dart';
import 'package:se_project/common/constants/constants.dart';
import 'package:se_project/common/constants/rive_utils.dart';
import 'package:se_project/features/home/home_screen.dart';

class EntryPoint extends StatefulWidget {
  static const String routeName= '/entry';
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> with SingleTickerProviderStateMixin {
    

  Widget? currentScreen = const HomeScreen();
  late AnimationController animationController;
  late Animation<double> animation;
  late Animation<double> scaleAnimation;
  late SMIBool isSideBarClosed;
  bool isSideMenuClosed = true;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(microseconds: 20000),
      )..addListener(() {
        setState(() {});
      });
      animation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: animationController, 
          curve: Curves.fastOutSlowIn)
          );
      scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(
        CurvedAnimation(
          parent: animationController, 
          curve: Curves.fastOutSlowIn)
          );
    super.initState();
  }


  void updateCurrentScreen(Widget? newScreen){
    setState(() {
      currentScreen=newScreen;
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor2,
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(microseconds: 200000),
            curve: Curves.fastOutSlowIn,
            width: 288,
            left: isSideMenuClosed ? -288 : 0,
            height: MediaQuery.of(context).size.height,
            child:  SideMenu(updateCurrentScreen: updateCurrentScreen),
            ),
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(animation.value - 30 * animation.value / 180),
            child: Transform.translate(
              offset: Offset( animation.value *265,0),
              child: Transform.scale(
                scale: scaleAnimation.value,
                child:  ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                  child: currentScreen,  
                  ),
                
                ),
                ),
          ),
          AnimatedPositioned(
            duration: const Duration(microseconds: 20000),
            left: isSideMenuClosed ? 0 : 220,
            top: 16,
            child: MenuBtn(
              riveOnInit: (artboard) {
                StateMachineController controller = RiveUtils
                .getRiveController(artboard, StateMachineName: "State Machine");
                isSideBarClosed = controller.findSMI("isOpen") as SMIBool;
                isSideBarClosed.value = true;
              },
              press: () {
                isSideBarClosed.value =! isSideBarClosed.value;
                if (isSideMenuClosed) {
                  animationController.forward();
                } else {
                  animationController.reverse();
                }
                setState(() {
                  isSideMenuClosed = isSideBarClosed.value;
                });
              },
              ),
          ),
        ],
      ),
      
    );
  }}




