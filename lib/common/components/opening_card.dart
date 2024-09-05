import 'package:flutter/material.dart';
import 'package:se_project/common/components/openning.dart';

class OpeningCard extends StatelessWidget {
  const OpeningCard({
    super.key, required this.openning,
  });
  final Openning openning;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      height: 280,
      width: 260,
      decoration:  BoxDecoration(
        color: openning.bgColor,
        borderRadius: const BorderRadius.all(Radius.circular(30),),
      ),
      child: Row(
        children: [
          Expanded(
            
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    
                    
                    child: Text(openning.title,
                    
                      style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                      ),
                  ),
                  
                  SizedBox(height: 5,),
                  Center(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: SingleChildScrollView(
                        child: Image.asset(
                          openning.iconSrc,
                          width: 160,
                          height: 160,
                          fit: BoxFit.fill,
                          ),
                      ),
                    
                              ),
                  ),
                  
                   
                  
                  
                  Spacer(),
                ],
              ),
            ),
            
          
        ],
      ),
    );
  }
}