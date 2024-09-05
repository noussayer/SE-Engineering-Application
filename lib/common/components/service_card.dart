import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:se_project/common/components/openning.dart';

class ServiceCard extends StatelessWidget {
  const ServiceCard({
    super.key, required this.openning,
  });
  final Openning openning;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: openning.bgColor,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        children: [
          Expanded(child: Column(
            children: [
              Text(openning.title,
              style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              
              ),
              Text(openning.description,
              style: TextStyle(
                color: Colors.white60,
                fontSize: 16,
                
                ),
              
              )
            ],
          ),
          ),
          const SizedBox(
            height: 40,
            child: VerticalDivider(color: Colors.white70,),
    
            ),
            const SizedBox(width: 8,),
            Container(
              height: 40,
              width: 40,
              child: SvgPicture.asset(openning.iconSrc)),
        ],
      ),
    );
  }
}