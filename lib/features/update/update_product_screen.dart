import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rive/rive.dart';
import 'package:se_project/common/components/animated_btn.dart';
import 'package:se_project/common/components/custom_textfield.dart';
import 'package:se_project/common/constants/global_variables.dart';
import 'package:se_project/common/constants/utils.dart';
import 'package:se_project/models/product.dart';
import 'package:se_project/services/admin_services.dart';

class UpdateProductScreen extends StatefulWidget {
  static const String routeName = '/update-screen-product';
  final Product product;
  final String? id;
  const UpdateProductScreen({
    Key? key,
    required this.product, required this.id,
  }) : super(key: key);

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {

  // Controllers:
  late final TextEditingController productNameController;
  late TextEditingController descriptionController;
  late TextEditingController customerController;
  late TextEditingController dateController;
  late RiveAnimationController _btnAnimationColtroller;
  bool isShown = false;
  // Services:
  final AdminServices adminServices = AdminServices();
  //Other Variables:
  String category = 'Preventive Maintenance';
  final _updateProductFormKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  
  List<File> images = [];
  List<String> imagesUrl = [];

  

  // List of categories:
  List<String> productCategories = [
    'Preventive Maintenance',
    'Corrective Maintenance',
    'Adaptive Maintenance',
    'Perfective Maintenance',
    'Curative Maintenance',
    'Evolutionary Maintenance'
  ];


  // Functions:
   @override
  void initState() {
    getImagesProduct();
    super.initState();
    _btnAnimationColtroller = OneShotAnimation(
      "active",
      autoplay: false,
    );
    productNameController = TextEditingController(text: widget.product.name);
    descriptionController = TextEditingController(text: widget.product.description);
    customerController = TextEditingController(text: widget.product.customer);
    dateController = TextEditingController(text: DateFormat('yyyy-MM-dd').format(widget.product.date));
    
   
  }
  getImagesProduct() async {
    imagesUrl= widget.product.images;
    setState(() {
      
    });
  }

  @override
  void dispose() {
    super.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    customerController.dispose();
    dateController.dispose();
  }
  void onTap() {
    uploadToCloudinary();
    updateProduct();
    }

 
  void updateProduct() async {
    try {
      final cloudinary = CloudinaryPublic('duenmski3', 'alvvwewb');
      for(int i=0; i<images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(CloudinaryFile.fromFile(images[i].path, folder: widget.product.name));
        imagesUrl.add(res.secureUrl);
      }
      showSnackBar(context, 'Images Added Successuflly');
    }
    catch(e){
      throw(Exception);
    }
    if (_updateProductFormKey.currentState!.validate()){
      var updatedProduct = Product(
        id: widget.id,
        name: productNameController.text, 
        description: descriptionController.text, 
        date: selectedDate,
        images: imagesUrl, 
        category: category, 
        customer: customerController.text);
      var id = widget.id;
      adminServices.updateProduct(context: context, id: id, updatedProduct: updatedProduct);
     
      }
   }
   void uploadToCloudinary () async {

    try {
      final cloudinary = CloudinaryPublic('duenmski3', 'alvvwewb');
      for(int i=0; i<images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(CloudinaryFile.fromFile(images[i].path, folder: widget.product.name));
        imagesUrl.add(res.secureUrl);
      }
      showSnackBar(context, 'Images Added Successuflly');
    }
    catch(e){
      throw(Exception);
    }
   }
     void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Center(
            child: Text(
              'Update Product',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _updateProductFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
               const SizedBox(height: 30),
                CustomTextField(
                  controller: productNameController,
                  hintText: 'Product Name',
                ),
                const SizedBox(height: 30),
                CustomTextField(
                  controller: descriptionController,
                  hintText: 'Description',
                  maxLines: 15,
                ),
                const SizedBox(height: 30),
                CustomTextField(
                  controller: customerController,
                  hintText: 'Customer',
                ),
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: widget.product.date,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null && pickedDate != selectedDate) {
                      setState(() {
                        selectedDate = pickedDate;
                        dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
                      });
                    }
                  },
                  child: AbsorbPointer(
                    child: CustomTextField(
                      controller: dateController,
                      hintText: 'Select Date',
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton(
                    value: category,
                    icon: Icon(Icons.keyboard_arrow_down),
                    items: productCategories.map((String item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (String? newVal) {
                      setState(() {
                        category = newVal!;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 30),
                images.isNotEmpty
                    ? CarouselSlider(
                        items: images.map((i) {
                          return Builder(
                            builder: (BuildContext context) => Image.file(
                              i,
                              fit: BoxFit.cover,
                              height: 200,
                            ),
                          );
                        }).toList(),
                        options: CarouselOptions(
                          viewportFraction: 1,
                          height: 200,
                        ),
                      )
                    : GestureDetector(
                        onTap: selectImages,
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(10),
                          dashPattern: const [10, 4],
                          strokeCap: StrokeCap.round,
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.folder_open, size: 40),
                                SizedBox(height: 15),
                                Text(
                                  'Add New Images',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                const SizedBox(height: 30),  
              
                AnimatedBtn(
                        text: "Update Product",
                        btnAnimationColtroller: _btnAnimationColtroller,
                        press: () {
                          _btnAnimationColtroller.isActive = true;
                          Future.delayed(
                            const Duration(milliseconds: 800),
                            () {
                              
                              setState(() {
                                isShown = true;
                              });
       
                              updateProduct();
                              
                              
                              setState(() {
                                  isShown = false;
                                });
                            },
                          );
                        },
                      ),
                SizedBox(height: 30,)
              ],
            ),
          ),
        ),
      ),
    );
  }

}