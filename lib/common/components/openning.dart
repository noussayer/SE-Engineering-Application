import 'dart:ui';

class Openning {
  final String title, iconSrc, description;
  final Color bgColor;
  Openning(
    {
    this.description ="Build An App",
    required this.title,
    required this.iconSrc ,
    this.bgColor = const Color(0xFF7553F6)}
    
  );

}

List<Openning> opennings = [ 
   Openning(
    title: "Automation",
    iconSrc: "assets/images/automation.png",
  ),
  Openning(
    title: "Robotics",
    bgColor: const Color(0xFF9CC5FF),
    iconSrc: "assets/images/rob1.png",
  ),
  Openning(
    title: "Engineering office",
    iconSrc: "assets/images/be.png",
  ),
   Openning(
    title: "Solar Energy",
    bgColor: const Color(0xFF9CC5FF),
    iconSrc: "assets/images/ss.png",
  ),
   Openning(
    title: "Industrial Maintenance",
    iconSrc: "assets/images/maintenance.png",
  ),
  Openning(
    title: "Expertise",
    bgColor: const Color(0xFF9CC5FF),
    iconSrc: "assets/images/expertiseee.png",
  ),

 
];
List<Openning> services = [
  Openning(
    title: "Energy",
    description: "Smart energy systems monitoring",
    bgColor: const Color(0xFF9CC5FF),
    iconSrc: "assets/icons/energy.svg",
  ),
  Openning(
    title: "Industry",
    description: "Smart control of industrial machinery",
    bgColor: const Color(0xFF9CC5FF),
    iconSrc: "assets/icons/industry.svg",
  ),
  Openning(
    title: "Agriculture",
    description: "Smart monitoring of agricultural systems",
    bgColor: const Color(0xFF9CC5FF),
    iconSrc: "assets/icons/agriculture.svg",
  ),
  
];

