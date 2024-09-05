import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key, required this.name, required this.type,
  });
  final String name, type;

  @override
  Widget build(BuildContext context) {
    return ListTile(leading: const CircleAvatar(
      backgroundColor: Colors.white24,
      child: Icon(
        CupertinoIcons.person,
        color: Colors.white,
        ),
    ),
    title: Text(name, style: const TextStyle(color: Colors.white),),
    subtitle: Text(type, style: const TextStyle(color: Colors.white),),
    
    );
  }
}