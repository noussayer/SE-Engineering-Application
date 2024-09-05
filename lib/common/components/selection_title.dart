import 'package:flutter/material.dart';

class SelectionTitle extends StatelessWidget {
  final String text;
  const SelectionTitle({
    super.key, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text( text, 
    style: Theme.of(context).textTheme
    .headlineMedium!
    .copyWith(color: Colors.black, fontWeight: FontWeight.w600),
    
    
    );
  }
}
