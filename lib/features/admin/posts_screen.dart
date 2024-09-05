import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:se_project/common/components/animated_btn.dart';
import 'package:se_project/common/components/loader.dart';
import 'package:se_project/common/components/product_card.dart';
import 'package:se_project/common/constants/global_variables.dart';
import 'package:se_project/features/admin/add_product_screen.dart';
import 'package:se_project/features/product_details/product_details_screen.dart';
import 'package:se_project/features/search/search_screen.dart';
import 'package:se_project/models/product.dart';
import 'package:se_project/services/admin_services.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  List<Product>? products;
  final AdminServices adminServices = AdminServices();
  late RiveAnimationController _btnAnimationColtroller;
  bool isShown = false;

  

  @override
  void initState() {
    super.initState();
    fetchAllProducts();
    _btnAnimationColtroller = OneShotAnimation(
      "active",
      autoplay: false,
    );
    super.initState();
  }

  fetchAllProducts() async {
    products= await adminServices.fetchAllProducts(context);
    setState(() {
      
    });
  }
  void deleteProduct(Product product, int index) {
    adminServices.deleteProduct(
      context: context, 
      product: product, 
      onSuccess: () {
        products!.removeAt(index);
        setState(() {});
      },
      );
  }
  void navigateToAddProduct(){
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }
  @override
  Widget build(BuildContext context) {
    return products == null
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
                  "All Products",
                  style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.w600),
                  
                
                ),
              ),
              ...products!.asMap().entries.map(
                (entry) => GestureDetector(
                  onTap: () {Navigator.push(context, MaterialPageRoute(builder: 
                  (context) => ProductDetailsScreen(product: entry.value),),);},
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
                    child: ProductCard(product: entry.value, onDelete: () {deleteProduct(entry.value, entry.key);},),
                    ),
                    ),
                    ),
            Center(
              child: AnimatedBtn(
                        text: "Add Product",
                        btnAnimationColtroller: _btnAnimationColtroller,
                        press: () {
                          _btnAnimationColtroller.isActive = true;
                          Future.delayed(
                            const Duration(milliseconds: 800),
                            () {
                              
                              setState(() {
                                isShown = true;
                              });
                              // Let's add the slide animation while dialog shows
                              navigateToAddProduct();
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