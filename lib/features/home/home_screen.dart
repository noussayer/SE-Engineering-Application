import 'package:flutter/material.dart';
import 'package:se_project/common/components/opening_card.dart';
import 'package:se_project/common/components/openning.dart';
import 'package:se_project/common/components/selection_title.dart';
import 'package:se_project/common/components/service_card.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName= '/home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child : SingleChildScrollView(
        child: Column(
          
            
            children: [
              const SizedBox(height: 50,),
              const Padding(
                padding: EdgeInsets.all(20),
                child: SelectionTitle(text: "Our Services")
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: [...opennings.map((openning) => Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: OpeningCard(openning: openning),
                )).toList(),],),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: SelectionTitle(text: "Our Products")
              ),
              ...services.map(
                (openning) => Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
                  child: ServiceCard(openning: openning),
                ),
              ),
              
            ],
          ),
        ),
      ),
      
    );
  }
}


