import 'package:flutter/material.dart';
import 'package:se_project/common/components/loader.dart';
import 'package:se_project/common/components/pdf_card.dart';
import 'package:se_project/common/constants/global_variables.dart';
import 'package:se_project/models/pdf.dart';
import 'package:se_project/services/pdf_service.dart';
import 'package:url_launcher/url_launcher.dart';

class PdfSearchScreen extends StatefulWidget {
  static const String routeName='/search-screen-pdf';
  final String searchQuery;
  const PdfSearchScreen({
    Key? key,
    required this.searchQuery,
  }) : super(key: key);

  @override
  State<PdfSearchScreen> createState() => _PdfSearchScreenState();
}

class _PdfSearchScreenState extends State<PdfSearchScreen> {
  List<Pdf>? pdfs;
  final PdfService pdfServices = PdfService();


    @override
  void initState() {
    super.initState();
    fetchSearchedPdf();
  }
  
  fetchSearchedPdf() async {
    pdfs = await pdfServices.fetchSearchedPdf(
      context: context, 
      searchQuery: widget.searchQuery
    );
    setState(() {});
  }
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, PdfSearchScreen.routeName, arguments: query);
  }
  void deletePdf(Pdf pdf, int index) {
    pdfServices.deletePdf(
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                margin: EdgeInsets.only( top: 15),
                child: Material(
                  borderRadius: BorderRadius.circular(7),
                  elevation: 1,
                  child: Padding(
                    padding: EdgeInsets.zero,
                    child: TextFormField(
                      onFieldSubmitted: navigateToSearchScreen,
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
      body: pdfs==null
      ? const loader()
      : SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  "Results",
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
                  
              
           
            
               
            ],
          ),
        ),
      ),
    );
  }
}