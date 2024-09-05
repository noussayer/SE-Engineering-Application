import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

import 'package:se_project/common/components/info_card.dart';
import 'package:se_project/common/components/rive_assest.dart';
import 'package:se_project/common/components/side_menu_tile.dart';
import 'package:se_project/common/constants/rive_utils.dart';
import 'package:se_project/providers/user_provider.dart';
import 'package:se_project/services/account_services.dart';

class SideMenu extends StatefulWidget {
  final Function(Widget?) updateCurrentScreen;
  const SideMenu({
    Key? key,
    required this.updateCurrentScreen,
  }) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  RiveAsset selectedMenu = sideMenus.first;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
     
    return Scaffold(
      body: Container(
        width: 288,
        height: double.infinity,
        color: const Color(0xFF17203A),
        child:  SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InfoCard(name: user.name, type: user.type,),
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
                child: Text(
                  "BROWSE",
                  style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.white70),
                  
                  ),
              ),
              ...sideMenus.map(
                (menu) => SideMenuTile(
                  menu: menu,  
                  riveonInit: (artboard) {
                    StateMachineController controller =
                    RiveUtils.getRiveController(artboard,
                    StateMachineName: menu.stateMachineName
                    );
                    menu.input = controller.findSMI("active") as SMIBool;
                    
                  },
                  press: () { 
                    menu.input!.change(true);
                    Future.delayed(const Duration(seconds: 1), () {
                      menu.input!.change(false);
                      widget.updateCurrentScreen(menu.currentScreen);
                    });
                    setState(() {
                      selectedMenu =menu;
                    });
                    },
                  isActive: selectedMenu == menu)
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
                child: Text(
                  "Account",
                  style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.white70),
                  
                  ),
              ),
              ...sideMenu2.map(
                (menu) => SideMenuTile(
                  menu: menu,  
                  riveonInit: (artboard) {
                    StateMachineController controller =
                    RiveUtils.getRiveController(artboard,
                    StateMachineName: menu.stateMachineName
                    );
                    menu.input = controller.findSMI("active") as SMIBool;
                    
                  },
                  press: () { 
                    menu.input!.change(true);
                    Future.delayed(const Duration(seconds: 1), () {
                      menu.input!.change(false);
                      AccountServices().logOut(context);
                    });
                    setState(() {
                      selectedMenu =menu;
                    });
                    },
                  isActive: selectedMenu == menu)
              ),
            ],
          ),
        ),
      ),
    );
  }
}


