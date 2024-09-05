import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:se_project/models/pdf.dart';

class PdfCard extends StatelessWidget {
  final Pdf pdf;
  final VoidCallback? onDelete;
   final VoidCallback? openPdf; 
  const PdfCard({super.key, required this.pdf, this.onDelete, this.openPdf});

  @override
  Widget build(BuildContext context) {
   return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color:  Color(0xFF9CC5FF),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  pdf.customer,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8), // Add some padding between title and description
                Text(
                  "Pdf details of product",
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 16,
                  ),
                  maxLines: 2, // Limit the number of lines for the description
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
            child: VerticalDivider(color: Colors.white70),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: openPdf,
            child: Container(
              height: 40,
              width: 40,
              child: SvgPicture.asset("assets/icons/pdf-svgrepo-com.svg"),
            ),
          ),
          const SizedBox(
            height: 40,
            child: VerticalDivider(color: Colors.white70),
          ),
          GestureDetector(
            onTap: onDelete,
            child: Container(
              height: 40,
              width: 40,
              child: SvgPicture.asset("assets/icons/delete-svgrepo-com.svg"),
            ),
          ),
          
        ],
      ),
    );
  }
}