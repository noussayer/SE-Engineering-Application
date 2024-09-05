import 'package:flutter/material.dart';

class AboutScreen extends StatefulWidget {
  static const String routeName = '/about-screen';

  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/images/login.png'), fit: BoxFit.fill)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(left: 50, top: 350,right: 50),
                child: ListView(
                  
                    children: const [
                      Text('SE ENGINEERING SARL is a Tunisian company newly founded in January 2020 by a team of engineers. It is a multidisciplinary technology and engineering company operating in various fields: Electronics, Electrics, Mechanics and Computing. ', 
                      style: TextStyle(
                        color: Colors.black, fontSize: 18,
                                ),),
                      SizedBox(height: 30,),
                      Text(' The company has three departments: a design office, an installation and maintenance department, and an expertise department (methods and quality). Thanks to its multidisciplinary staff and skills, SE ENGINEERING SARL provides innovative technological solutions aimed at adding value, accelerating digital transformation and supporting its customers move towards Industry 4.0, particularly in the industrial, textile, transport and agricultural sectors.',
                      style: TextStyle(
                        color: Colors.black, fontSize: 18,
                                ),),
                    
                    ],
                  ),
                ),
        
            ],
          ),
        ),
  
  
  );
  }
}