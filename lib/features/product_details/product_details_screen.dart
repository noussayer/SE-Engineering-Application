import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rive/rive.dart';
import 'package:se_project/common/components/animated_btn.dart';
import 'package:se_project/common/constants/global_variables.dart';
import 'package:se_project/features/update/update_product_screen.dart';
import 'package:se_project/models/product.dart';

class ProductDetailsScreen extends StatefulWidget {
  
  static const String routeName ='/product-details';
  final Product product;
  const ProductDetailsScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late RiveAnimationController _btnAnimationColtroller;
  bool isShown = false;

  @override
  void initState() {
    super.initState();
    _btnAnimationColtroller = OneShotAnimation(
      "active",
      autoplay: false,
    );
    super.initState();
  }
  
  

  
  @override
  Widget build(BuildContext context) {
    final String formattedDate = DateFormat.yMMMMd().format(widget.product.date);

    WidgetsFlutterBinding.ensureInitialized();
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
            child: Center(
              child: Text(
                'Product Details',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.product.category,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,  
                      color: Color.fromARGB(255, 64, 71, 108),  
                      shadows: [
                        Shadow( blurRadius: 5.0, color: Color(0x55000000), offset: Offset(2.0, 2.0),),],
                      decoration: TextDecoration.underline,  
                      ),
                      ),
                      ],
                      ),
                      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: Text(
          widget.product.name,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      SizedBox(height: 30,),
      CarouselSlider(
        items: widget.product.images.map((i) {
          return Builder(
            builder: (BuildContext context) => Image.network(
              i,
              fit: BoxFit.cover,
              height: 250,
            ),
          );
        }).toList(),
        options: CarouselOptions(
          viewportFraction: 1,
          height: 350,
        ),
      ),
      SizedBox(height: 30,),
      Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: RichText(
              text: TextSpan(
                text: 'Customer Name:',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  ),
                  ),
                  ),
                  ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              widget.product.customer,
              style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,  // Slightly bold
              color: Colors.black,  // Simple black colo
              ),
              ),
            
      ),
          
        ],
      ),
      SizedBox(height: 30,),
      Padding(
        padding: const EdgeInsets.all(12),
        child: RichText(
          text: TextSpan(
            text: 'Description:',
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Text(widget.product.description),
      ),
      SizedBox(height: 30,),
      Padding(
            padding: const EdgeInsets.all(12),
            child: RichText(
              text: TextSpan(
                text: 'Date :',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  ),
                  ),
                  ),
                  ),
      Container(
  padding: const EdgeInsets.all(8.0),
  margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(8.0),
    border: Border.all(
      color: Colors.grey.shade300,
      width: 1.0,
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.2),
        spreadRadius: 2,
        blurRadius: 5,
        offset: const Offset(0, 3),
      ),
    ],
  ),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(
        Icons.calendar_today,
        color: Colors.grey.shade700,
        size: 20.0,
      ),
      const SizedBox(width: 8.0),
      Text(
        formattedDate,
        style: const TextStyle(
          fontSize: 16.0,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  ),
),
              const SizedBox(height: 30),
                Center(
                  child: AnimatedBtn(
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
                                Navigator.push(context, MaterialPageRoute(builder: 
                                (context) => UpdateProductScreen(product: widget.product, id: widget.product.id),));
                                setState(() {
                                    isShown = false;
                                  });
                              },
                            );
                          },
                        ),
                ),
                SizedBox(height: 30,)

      
      
    ],
  ),
),  
    );
  }
}