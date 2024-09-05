import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:se_project/common/components/animated_btn.dart';
import 'package:se_project/common/components/loader.dart';
import 'package:se_project/common/components/pdf_card.dart';
import 'package:se_project/common/components/pdf_dialog.dart';
import 'package:se_project/common/constants/global_variables.dart';
import 'package:se_project/features/pdf/pdf_search_screen.dart';

import 'package:se_project/models/pdf.dart';
import 'package:se_project/services/pdf_service.dart';
import 'package:url_launcher/url_launcher.dart';

class PdfScreen extends StatefulWidget {
  
  const PdfScreen({super.key});

  @override
  State<PdfScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<PdfScreen> {
  List<Pdf>? pdfs;
  final PdfService pdfService = PdfService();
  late RiveAnimationController _btnAnimationColtroller;
  bool isShown = false;
  @override
  void initState() {
    super.initState();
    _btnAnimationColtroller = OneShotAnimation(
      "active",
      autoplay: false,
    );
    
    fetchAllPdfs();
  }

  fetchAllPdfs() async {
    pdfs= await pdfService.fetchAllPdfs(context);
    setState(() {
     
      
    });
  }
  void deletePdf(Pdf pdf, int index) {
    pdfService.deletePdf(
      context: context, 
      pdf: pdf, 
      onSuccess: () {
        pdfs!.removeAt(index);
        setState(() {});
      },
      );
  }
  void openPdfFile(String pdfLink) async {
    if (await canLaunch(pdfLink)) {
      await launch(pdfLink);
      } else {
        throw 'Could not launch';
        }
        }
 void navigateToPdfSearchScreen(String query) {
    Navigator.pushNamed(context, PdfSearchScreen.routeName, arguments: query);
  }
  @override
  Widget build(BuildContext context) {
   return pdfs == null
    ? const loader()
    : Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                height: 42,
                margin: EdgeInsets.only(left: 50, top: 15),
                child: Material(
                  borderRadius: BorderRadius.circular(7),
                  elevation: 1,
                  child: Padding(
                    padding: EdgeInsets.zero,
                    child: TextFormField(
                      onFieldSubmitted: navigateToPdfSearchScreen,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: (){},
                          child: const Padding(
                            padding: EdgeInsets.only(left: 6,),
                            child: Icon(Icons.search, color: Colors.black, size: 23,),
                    
                            ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top: 10),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                          borderSide: BorderSide(color: Colors.black38, width: 1),
                          ),
                          hintText: 'Search',
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          ),
                      ),
                    ),
                  ),
                  
                  ),
                            ),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: const Icon(Icons.mic, color: Colors.black, size: 25),

              )
           

            ],
            
          ),
        ),

      ),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  "PDF Documents",
                  style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              
              ...pdfs!.asMap().entries.map(
                (e) => Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
                  child: PdfCard(pdf: e.value, onDelete: () {deletePdf(e.value, e.key);}, 
                  openPdf: () {openPdfFile(e.value.pdfs[0]);},),
                  ),
                  
                  ),
                  
              
            SizedBox(height: 30,),
            Center(
              child: AnimatedBtn(
                        text: "Add PDF File",
                        btnAnimationColtroller: _btnAnimationColtroller,
                        press: () {
                          _btnAnimationColtroller.isActive = true;
                          Future.delayed(
                            const Duration(milliseconds: 800),
                            () {
                              
                              setState(() {
                                isShown = true;
                              });
                              pdfDialog(context);
                              // Let's add the slide animation while dialog shows
                              setState(() {
                                  isShown = false;
                                });
                            },
                          );
                        },
                      ),
            ),
            SizedBox(height: 30,),   
            ],
          ),
        ),
      ),
        
      
    );
  }
}