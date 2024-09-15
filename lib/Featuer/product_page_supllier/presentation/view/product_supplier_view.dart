// import 'package:eghyptproject/Featuer/cart/presentation/view/cart_view.dart';
// import 'package:eghyptproject/Featuer/cart/presentation/view/widget/cart.dart';
// import 'package:eghyptproject/Featuer/cart/presentation/view/widget/quantity_selector.dart';
// import 'package:eghyptproject/Featuer/home/presentation/view/widget/move_photo.dart';
// import 'package:eghyptproject/Featuer/product_page_supllier/data/product_model.dart';

// import 'package:eghyptproject/Featuer/product_page_supllier/presentation/view/manger/product_supllier_cubit.dart';
// import 'package:eghyptproject/Featuer/product_page_supllier/presentation/view/manger/product_supllier_state.dart';
// import 'package:eghyptproject/Featuer/product_page_supllier/presentation/view/manger/test_cubit/test_cubit.dart';
// import 'package:eghyptproject/Featuer/product_page_supllier/presentation/view/manger/with_offer_cubit/with_offer_cubit.dart';
// import 'package:eghyptproject/Featuer/product_page_supllier/presentation/view/slider.dart';
// import 'package:eghyptproject/constant.dart';
// import 'package:eghyptproject/core/styles.dart';
// import 'package:eghyptproject/core/utils/funcations/show_snack_bar.dart';
// import 'package:eghyptproject/core/widget/custom_loading.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// // ignore: must_be_immutable
// class ProductsList extends StatefulWidget {
//   ///////
//   final String type;
//   final SupplierModel? supplier;
//   List<Map<String, dynamic>>? order;
//   final Map<int, String>? supplierNames;
//   final double? minBillPrice;
//   final int? minSellingQuantity;

//   final int categoryId;
//   final Function(Product) onProductSelected;

//   // final String type;
// //////

//   ProductsList({
//     super.key,
//     required this.categoryId,
//     required this.onProductSelected,
//     this.order,
//     this.supplier,
//     this.supplierNames,
//     this.minBillPrice,
//     this.minSellingQuantity,
//     required this.type,
//   });

//   @override
//   ProductsListState createState() => ProductsListState();
// }

// class ProductsListState extends State<ProductsList> {
//   late List<Product> products;
//   late List<Product> productsWithOffer;
//   late List<Offer> offers;
//   /////
//   double progressValue = 0.0;
//   bool isAddedToCart = false;
//   bool isAddedToCart2 = false;

//   // Map<int, bool> isAddedToCartMap = {};
//   late double totalCost;
//   double totalCost1 = 0.0;

//   double totalCostH = 0.0;

//   late List<bool> isAddedToCartList1;
//   late List<bool> isAddedToCartListH;

//   CategoryCubit categoryCubit = CategoryCubit(ApiProvider());
//   WithOfferCubit withOfferCubit = WithOfferCubit(ApiProvider());
//   ProductCubitSupllier productCubitSupllier =
//       ProductCubitSupllier(ApiProvider());

//   late Cart _cart;

//   @override
//   void initState() {
//     super.initState();
//     /////

//     const QuantitySelector(
//       initialValue: 0,
//       maxOfferQuantity: 0,
//     );

//     setState(() {
//       totalCost = totalCost1 + totalCost1;
//     });
//     // setState(() {
//     //   _loadTotalCost();
//     // });

//     // setState(() {
//     //   totalCost;
//     // });
//     _cart = Cart();
//   }

//   @override
//   void dispose() {
//     // sliderCubit.close();
//     categoryCubit.close();
//     withOfferCubit.close();
//     productCubitSupllier.close();

//     super.dispose();
//   }

//   int _retryCount = 0;
//   static const int _maxRetries = 5;

//   void _retryLoadingImage() {
//     if (_retryCount < _maxRetries) {
//       setState(() {
//         _retryCount++;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     totalCost = totalCost1 + totalCostH;
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;
//     double getResponsiveSizedBoxWidth(double baseWidth) {
//       // Define your breakpoints for different screen sizes
//       if (screenWidth > 1200) {
//         // Larger screens (large tablets, desktops)
//         return baseWidth * 1.5;
//       } else if (screenWidth > 600) {
//         // Medium screens (tablets)
//         return baseWidth * 1.25;
//       } else {
//         // Small screens (phones)
//         return baseWidth;
//       }
//     }

//     double getResponsiveFontSize(double baseFontSize) {
//       // Define your breakpoints and font size scaling
//       if (screenWidth > 1200) {
//         // Larger screens (large tablets, desktops)
//         return baseFontSize * 1.5;
//       } else if (screenWidth > 600) {
//         // Medium screens (tablets)
//         return baseFontSize * 1.2;
//       } else {
//         // Small screens (phones)
//         return baseFontSize;
//       }
//     }

//     // double totalMethod() {
//     //   double totalForProduct;
//     //   if (product.hasOffer && product.quantity > product.maxOfferQuantity) {
//     //     int offerQuantity = product.maxOfferQuantity;
//     //     int restQuantity = product.quantity - offerQuantity;
//     //     totalForProduct = (offerQuantity * product.offerPrice) +
//     //         (restQuantity * product.price);
//     //   } else if (product.hasOffer) {
//     //     totalForProduct = product.quantity * product.offerPrice;
//     //   } else {
//     //     totalForProduct = product.quantity * product.price;
//     //   }

//     //   return sum + totalForProduct;
//     // }

//     // Calculate the size of the SizedBox based on the screen size
//     double size = screenWidth < 600 ? screenWidth * 0.24 : screenWidth * 0.2;
//     // Ensure the image is not too big for tablets or small screens
//     size = size > 140 ? 140 : size;

//     // تحديد عرض الزر بناءً على عرض الشاشة
//     double buttonWidth;
//     if (screenWidth < 600) {
//       // للأجهزة المحمولة
//       buttonWidth = screenWidth * 0.32;
//     } else if (screenWidth < 1200) {
//       // للأجهزة اللوحية الصغيرة
//       buttonWidth = screenWidth * 0.47;
//     } else {
//       // للأجهزة اللوحية الكبيرة والشاشات الأكبر
//       buttonWidth = screenWidth * 0.3;
//     }

//     // تحديد ارتفاع الزر بناءً على ارتفاع الشاشة
//     double buttonHeight;
//     if (screenHeight < 600) {
//       buttonHeight = 35.0;
//     } else if (screenHeight < 1200) {
//       buttonHeight = 48.0;
//     } else {
//       buttonHeight = 56.0;
//     }

//     // Set default padding
//     double paddingAllSides = screenWidth * 0.03;

//     // Increase padding for larger screens
//     if (screenWidth > 600) {
//       // Tablets and larger devices
//       paddingAllSides = screenWidth * 0.04;
//     }
//     if (screenWidth > 1200) {
//       // Larger tablets and desktops
//       paddingAllSides = screenWidth * 0.05;
//     }

//     return PopScope(
//       onPopInvoked: (didPop) {
//         setState(() {});
//       },
//       child: Column(
//         children: [
//           Expanded(
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   MySliderPagemove(
//                     id: widget.supplier!.id,
//                   ),
//                   BlocConsumer<WithOfferCubit, WithOfferState>(
//                     listener: (context, state) {
//                       if (state is WithOfferError) {
//                         showCustomSnackBar(context, state.errorMessage,
//                             color: const Color.fromARGB(255, 135, 112, 110));
//                       }
//                     },
//                     builder: (context, state) {
//                       if (state is WithOfferSuccess &&
//                           state.products.isNotEmpty &&
//                           state.categotyId == widget.categoryId) {
//                         //////////////
//                         isAddedToCartList1 =
//                             List<bool>.generate(state.products.length, (index) {
//                           return _cart.isAddedToCartMap[
//                                   state.products[index].productId] ??
//                               false;
//                         });
//                         isAddedToCartList1 =
//                             List<bool>.filled(state.products.length, false);

//                         // calculateTotalForAddedProducts(
//                         //     state.products, isAddedToCartList1);

//                         totalCost = totalCost1 + totalCostH;
//                         progressValue =
//                             totalCost >= state.supplier!.minBillPrice
//                                 ? 1
//                                 : totalCost / state.supplier!.minBillPrice;
//                         return Column(
//                           children: <Widget>[
//                             // const Divider(
//                             //   color: kPrimaryColorred,
//                             //   thickness: 1,
//                             // ),
//                             Align(
//                               alignment: Alignment.centerRight,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Container(
//                                   color: Colors.yellow,
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(4),
//                                     child: Text(
//                                       'عروض اليوم😊',
//                                       style: Styles.textStyle20(context)
//                                           .copyWith(
//                                               fontWeight: FontWeight.bold),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Directionality(
//                               textDirection: TextDirection.rtl,
//                               child: SizedBox(
//                                 height: MediaQuery.of(context).size.width < 600
//                                     ? 323
//                                     : 353,
//                                 child: ListView.builder(
//                                   scrollDirection: Axis.horizontal,
//                                   itemCount: state.products.length,
//                                   itemBuilder:
//                                       (BuildContext context, int bindex) {
//                                     final isAddedToCart2 =
//                                         _cart.isAddedToCartMap[bindex] ?? false;

//                                     final productQuantity =
//                                         _cart.productQuantities[
//                                                 state.products[bindex].id] ??
//                                             state.products[bindex].quantity;
//                                     // final isAddedToCart =
//                                     //     isAddedToCartMap1[bindex] ??
//                                     //         false;
//                                     final product = state.products[bindex];

//                                     return Card(
//                                       child: Container(
//                                         color: Colors.white,
//                                         child: Column(
//                                           children: <Widget>[
//                                             // LayoutBuilder(builder:
//                                             //     (context, constraints) {
//                                             //   double screenHeight =
//                                             //       MediaQuery.of(context)
//                                             //           .size
//                                             //           .height;
//                                             //   double screenWidth =
//                                             //       MediaQuery.of(context)
//                                             //           .size
//                                             //           .width;

//                                             //   // تحديد الأبعاد بناءً على نسبة من حجم الشاشة
//                                             //   double imageHeight = screenHeight *
//                                             //       0.2; // 20% من ارتفاع الشاشة
//                                             //   double imageWidth =
//                                             //       screenWidth * 0.3; // 30%
//                                             //   return SizedBox(
//                                             //     height: imageHeight,
//                                             //     width: imageWidth,
//                                             //     child: Image.network(
//                                             //       state.products[bindex].images!
//                                             //           .first!,
//                                             //       errorBuilder: (context, error,
//                                             //               stackTrace) =>
//                                             //           const Icon(Icons
//                                             //               .image_not_supported_outlined),
//                                             //     ),
//                                             //   );
//                                             // }),
// /////////////////////////////////////////////////////////////////////////////////
//                                             // LayoutBuilder(
//                                             //   builder: (context, constraints) {
//                                             //     double screenHeight =
//                                             //         MediaQuery.of(context)
//                                             //             .size
//                                             //             .height;
//                                             //     double screenWidth =
//                                             //         MediaQuery.of(context)
//                                             //             .size
//                                             //             .width;

//                                             //     // تحديد الأبعاد بناءً على نسبة من حجم الشاشة
//                                             //     double imageHeight = screenHeight *
//                                             //         0.2; // 20% من ارتفاع الشاشة
//                                             //     double imageWidth = screenWidth *
//                                             //         0.3; // 30% من عرض الشاشة

//                                             //     // الحصول على رابط الصورة
//                                             //     String? imageUrl = state
//                                             //         .products[bindex]
//                                             //         .images
//                                             //         ?.first;

//                                             //     return SizedBox(
//                                             //       width: imageWidth, // العرض
//                                             //       height:
//                                             //           imageHeight, // الارتفاع
//                                             //       child: Image.network(
//                                             //         imageUrl!,
//                                             //         loadingBuilder: (context,
//                                             //             child,
//                                             //             loadingProgress) {
//                                             //           if (loadingProgress ==
//                                             //               null) {
//                                             //             return child;
//                                             //           } else {
//                                             //             return Center(
//                                             //               child:
//                                             //                   CircularProgressIndicator(
//                                             //                 value: loadingProgress
//                                             //                             .expectedTotalBytes !=
//                                             //                         null
//                                             //                     ? loadingProgress
//                                             //                             .cumulativeBytesLoaded /
//                                             //                         (loadingProgress
//                                             //                                 .expectedTotalBytes ??
//                                             //                             1)
//                                             //                     : null,
//                                             //               ),
//                                             //             );
//                                             //           }
//                                             //         },
//                                             //         errorBuilder: (context,
//                                             //             error, stackTrace) {
//                                             //           if (_retryCount <
//                                             //               _maxRetries) {
//                                             //             Future.delayed(
//                                             //                 const Duration(
//                                             //                     seconds: 2),
//                                             //                 _retryLoadingImage);
//                                             //             return const Center(
//                                             //               child:
//                                             //                   CircularProgressIndicator(),
//                                             //             );
//                                             //           } else {
//                                             //             return const Icon(Icons
//                                             //                 .image_not_supported_outlined);
//                                             //           }
//                                             //         },
//                                             //       ),
//                                             //     );
//                                             //   },
//                                             // ),
// ///////////////////////////////////////////////////////////////////////
//                                             Text(
//                                               '${product.name}',
//                                               style:
//                                                   Styles.textStyle24(context),
//                                               softWrap: true,
//                                             ),
//                                             Text(
//                                               product.discription,
//                                               style:
//                                                   Styles.textStyle20(context),
//                                               softWrap: true,
//                                             ),
//                                             Row(
//                                               children: [
//                                                 Text(
//                                                   '${product.price}ج',
//                                                   style: TextStyle(
//                                                     fontSize:
//                                                         getResponsiveFontSize(
//                                                             20),
//                                                     decoration: TextDecoration
//                                                         .lineThrough,
//                                                   ),
//                                                   softWrap: true,
//                                                 ),
//                                                 SizedBox(
//                                                     width:
//                                                         getResponsiveSizedBoxWidth(
//                                                             10)),
//                                                 Text(
//                                                   '${product.offerPrice}ج',
//                                                   style: Styles.textStyle20(
//                                                           context)
//                                                       .copyWith(
//                                                           color: Colors.green),
//                                                   softWrap: true,
//                                                 ),
//                                                 SizedBox(
//                                                     width:
//                                                         getResponsiveSizedBoxWidth(
//                                                             10)),
//                                                 Text(
//                                                   textAlign: TextAlign.left,
//                                                   " عرض خاص",
//                                                   style: TextStyle(
//                                                     color: Colors.red,
//                                                     fontSize:
//                                                         getResponsiveFontSize(
//                                                             20),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                             AnimatedSwitcher(
//                                               duration: const Duration(
//                                                   milliseconds: 500),
//                                               transitionBuilder: (Widget child,
//                                                   Animation<double> animation) {
//                                                 return FadeTransition(
//                                                   opacity: animation,
//                                                   child: child,
//                                                 );
//                                               },
//                                               switchInCurve: Curves.easeIn,
//                                               switchOutCurve: Curves.easeOut,
//                                               child: isAddedToCart2
//                                                   ? Row(
//                                                       mainAxisSize:
//                                                           MainAxisSize.min,
//                                                       children: [
//                                                         QuantitySelector(
//                                                           key: ValueKey(
//                                                               'selectr_${product.productId}'),
//                                                           initialValue: _cart
//                                                                       .productQuantities[
//                                                                   state
//                                                                       .products[
//                                                                           bindex]
//                                                                       .productId] ??
//                                                               productQuantity,
//                                                           maxSillingQuantity: state
//                                                               .products[bindex]
//                                                               .maxSellingQuantity,
//                                                           onChanged:
//                                                               (productQuantity) {
//                                                             setState(() {
//                                                               _cart.updateProductQuantity(
//                                                                   product
//                                                                       .productId,
//                                                                   productQuantity);
//                                                               state
//                                                                       .products[
//                                                                           bindex]
//                                                                       .quantity =
//                                                                   productQuantity;

//                                                               totalCost1 =
//                                                                   calculateTotalAndQuantity1(
//                                                                       state.products[
//                                                                           bindex]);
//                                                             });
//                                                           },
//                                                           maxOfferQuantity: state
//                                                               .products[bindex]
//                                                               .maxOfferQuantity,
//                                                         ),
//                                                         InkWell(
//                                                           onTap: () {
//                                                             setState(() {
//                                                               isAddedToCartList1[
//                                                                       bindex] =
//                                                                   false;
//                                                               _cart.removeProduct(
//                                                                   state.products[
//                                                                       bindex]);
//                                                               _cart.isAddedToCartMap[
//                                                                       bindex] =
//                                                                   false;

//                                                               totalCost1 =
//                                                                   calculateTotalAndQuantity1(
//                                                                       state.products[
//                                                                           bindex]);
//                                                               // _cart
//                                                               //     .productQuantities
//                                                               //     .clear();

//                                                               // _cart
//                                                               //     .calculateTotalAndQuantity();
//                                                             });
//                                                           },
//                                                           child: Padding(
//                                                             padding: EdgeInsets
//                                                                 .symmetric(
//                                                                     horizontal:
//                                                                         paddingAllSides),
//                                                             child: Text(
//                                                               'الغاء',
//                                                               style: TextStyle(
//                                                                 color:
//                                                                     Colors.red,
//                                                                 fontSize:
//                                                                     getResponsiveFontSize(
//                                                                         20),
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     )
//                                                   : ElevatedButton(
//                                                       key: ValueKey(
//                                                           'buttn_${product.productId}'),
//                                                       onPressed: () {
//                                                         setState(() {
//                                                           isAddedToCartList1[
//                                                               bindex] = true;
//                                                           _cart.isAddedToCartMap[
//                                                               bindex] = true;
//                                                           _cart.addProduct(
//                                                               product,
//                                                               state.supplier!
//                                                                   .firstName);
//                                                           _cart.addSupplierInfo(
//                                                             state.supplier!
//                                                                 .firstName,
//                                                             state.supplier!
//                                                                 .minBillPrice,
//                                                             state.supplier!
//                                                                 .minSellingQuantity,
//                                                           );
//                                                           totalCost1 =
//                                                               calculateTotalAndQuantity1(
//                                                                   state.products[
//                                                                       bindex]);

//                                                           // _cart
//                                                           //     .calculateTotalAndQuantity();
//                                                           widget
//                                                               .onProductSelected(
//                                                                   product);
//                                                         });
//                                                       },
//                                                       style: ElevatedButton
//                                                           .styleFrom(
//                                                         foregroundColor:
//                                                             Colors.white,
//                                                         backgroundColor:
//                                                             Colors.blue,
//                                                         minimumSize: Size(
//                                                             buttonWidth,
//                                                             buttonHeight),
//                                                         shape:
//                                                             RoundedRectangleBorder(
//                                                           borderRadius:
//                                                               BorderRadius
//                                                                   .circular(5),
//                                                         ),
//                                                       ),
//                                                       child: Text(
//                                                         '+ إضافة ',
//                                                         style: Styles
//                                                                 .textStyle20(
//                                                                     context)
//                                                             .copyWith(
//                                                                 color: Colors
//                                                                     .white),
//                                                       ),
//                                                     ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ),
//                             ),
//                             const Divider(
//                               color: kPrimaryColorred,
//                               thickness: 1,
//                             ),
//                           ],
//                         );
//                       }

//                       return Container(
//                         height: 0,
//                       );
//                     },
//                   ),
//                   BlocConsumer<ProductCubitSupllier, ProductStateSupllier>(
//                     listener: (context, state) {
//                       if (state is ProductsError) {
//                         showCustomSnackBar(context, state.errorMessage,
//                             color: kPrimaryColorred);
//                       }
//                     },
//                     builder: (context, state) {
//                       if (state is ProductsLoaded &&
//                           state.categoryId == widget.categoryId) {
//                         isAddedToCartListH =
//                             List<bool>.filled(state.products.length, false);

//                         isAddedToCartListH =
//                             List<bool>.generate(state.products.length, (index) {
//                           return _cart.isAddedToCartMapH[
//                                   state.products[index].productId] ??
//                               false;
//                         });

//                         totalCost = totalCost1 + totalCostH;
//                         progressValue =
//                             totalCost >= state.supplier!.minBillPrice
//                                 ? 1
//                                 : totalCost / state.supplier!.minBillPrice;
//                         return ListView.builder(
//                           shrinkWrap: true,
//                           physics: const NeverScrollableScrollPhysics(),
//                           itemCount: state.products.length,
//                           itemBuilder: (context, index) {
//                             isAddedToCart = isAddedToCartListH[index];
//                             // final isAddedToCart =
//                             //     isAddedToCartMap2[index] ?? false;
//                             final product = state.products[index];
//                             final productQuantityH = _cart.productQuantitiesH[
//                                     state.products[index].id] ??
//                                 state.products[index].quantity;
//                             // var image = product.images!.first;
//                             return Card(
//                               child: Container(
//                                 color: Colors.white,
//                                 child: Padding(
//                                   padding: EdgeInsets.all(paddingAllSides),
//                                   child: Row(
//                                     children: [
//                                       // LayoutBuilder(
//                                       //     builder: (context, constraints) {
//                                       //   double screenHeight =
//                                       //       MediaQuery.of(context).size.height;
//                                       //   double screenWidth =
//                                       //       MediaQuery.of(context).size.width;
//                                       //   double imageHeight = screenHeight *
//                                       //       0.2; // 20% من ارتفاع الشاشة
//                                       //   double imageWidth =
//                                       //       screenWidth * 0.18; // 30% من

//                                       //   return SizedBox(
//                                       //       height: imageHeight,
//                                       //       width: imageWidth,
//                                       //       child: Image.network(
//                                       //         product.images!.first!,
//                                       //         errorBuilder: (context, error,
//                                       //                 stackTrace) =>
//                                       //             const Icon(Icons
//                                       //                 .image_not_supported_outlined),
//                                       //       ));
//                                       // }),
// //////////////////////////////////////////////////////////////////////////////////////
//                                       // LayoutBuilder(
//                                       //   builder: (context, constraints) {
//                                       //     double screenHeight =
//                                       //         MediaQuery.of(context)
//                                       //             .size
//                                       //             .height;
//                                       //     double screenWidth =
//                                       //         MediaQuery.of(context).size.width;

//                                       //     // تحديد الأبعاد بناءً على نسبة من حجم الشاشة
//                                       //     double imageHeight = screenHeight *
//                                       //         0.2; // 20% من ارتفاع الشاشة
//                                       //     double imageWidth = screenWidth *
//                                       //         0.18; // 18% من عرض الشاشة

//                                       //     // الحصول على رابط الصورة
//                                       //     String? imageUrl =
//                                       //         product.images?.first;

//                                       //     // تحقق من عدم وجود null
//                                       //     if (imageUrl == null) {
//                                       //       return const Icon(Icons
//                                       //           .image_not_supported_outlined);
//                                       //     }

//                                       //     return SizedBox(
//                                       //       width: imageWidth,
//                                       //       height: imageHeight,
//                                       //       child: Image.network(
//                                       //         imageUrl,
//                                       //         loadingBuilder: (context, child,
//                                       //             loadingProgress) {
//                                       //           if (loadingProgress == null) {
//                                       //             return child;
//                                       //           } else {
//                                       //             return Center(
//                                       //               child:
//                                       //                   CircularProgressIndicator(
//                                       //                 value: loadingProgress
//                                       //                             .expectedTotalBytes !=
//                                       //                         null
//                                       //                     ? loadingProgress
//                                       //                             .cumulativeBytesLoaded /
//                                       //                         (loadingProgress
//                                       //                                 .expectedTotalBytes ??
//                                       //                             1)
//                                       //                     : null,
//                                       //               ),
//                                       //             );
//                                       //           }
//                                       //         },
//                                       //         errorBuilder:
//                                       //             (context, error, stackTrace) {
//                                       //           if (_retryCount < _maxRetries) {
//                                       //             Future.delayed(
//                                       //                 const Duration(
//                                       //                     seconds: 2),
//                                       //                 _retryLoadingImage);
//                                       //             return const Center(
//                                       //               child:
//                                       //                   CircularProgressIndicator(),
//                                       //             );
//                                       //           } else {
//                                       //             return const Icon(Icons
//                                       //                 .image_not_supported_outlined);
//                                       //           }
//                                       //         },
//                                       //       ),
//                                       //     );
//                                       //   },
//                                       // ),
// //////////////////////////////////////////////////////////////////////////////
//                                       SizedBox(
//                                           width:
//                                               getResponsiveSizedBoxWidth(10)),
//                                       Expanded(
//                                         child: ListTile(
//                                           title: Text(
//                                             '${product.name}',
//                                             style: Styles.textStyle24(context),
//                                           ),
//                                           subtitle: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 product.discription,
//                                                 style:
//                                                     Styles.textStyle18(context),
//                                               ),
//                                               SizedBox(
//                                                   width:
//                                                       getResponsiveSizedBoxWidth(
//                                                           4)),
//                                               if (product.offerPrice > 0) ...[
//                                                 Row(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment
//                                                           .spaceAround,
//                                                   children: [
//                                                     Flexible(
//                                                       child: Text(
//                                                         "${product.price}ج",
//                                                         style: TextStyle(
//                                                           fontSize:
//                                                               getResponsiveFontSize(
//                                                                   20),
//                                                           decoration:
//                                                               TextDecoration
//                                                                   .lineThrough,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                     Flexible(
//                                                       child: Text(
//                                                         " ${product.offerPrice}ج",
//                                                         style: TextStyle(
//                                                           color: Colors.green,
//                                                           fontSize:
//                                                               getResponsiveFontSize(
//                                                                   20),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                     Text(
//                                                       textAlign: TextAlign.left,
//                                                       " عرض خاص",
//                                                       style: TextStyle(
//                                                         color: Colors.red,
//                                                         fontSize:
//                                                             getResponsiveFontSize(
//                                                                 20),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ] else ...[
//                                                 Text(
//                                                   "${product.price}ج",
//                                                   style: Styles.textStyle20(
//                                                       context),
//                                                 ),
//                                               ],
//                                               const SizedBox(height: 16),
//                                               AnimatedSwitcher(
//                                                 duration: const Duration(
//                                                     milliseconds: 500),
//                                                 transitionBuilder:
//                                                     (Widget child,
//                                                         Animation<double>
//                                                             animation) {
//                                                   return FadeTransition(
//                                                     opacity: animation,
//                                                     child: child,
//                                                   );
//                                                 },
//                                                 switchInCurve: Curves.easeIn,
//                                                 switchOutCurve: Curves.easeOut,
//                                                 child: isAddedToCart
//                                                     ? Row(
//                                                         mainAxisSize:
//                                                             MainAxisSize.min,
//                                                         children: [
//                                                           Flexible(
//                                                             child:
//                                                                 QuantitySelector(
//                                                               key: ValueKey(
//                                                                   'selector_${product.productId}'),
//                                                               initialValue: _cart.productQuantitiesH[state
//                                                                       .products[
//                                                                           index]
//                                                                       .productId] ??
//                                                                   productQuantityH,
//                                                               maxSillingQuantity:
//                                                                   state
//                                                                       .products[
//                                                                           index]
//                                                                       .maxSellingQuantity,
//                                                               onChanged:
//                                                                   (productQuantityH) {
//                                                                 setState(() {
//                                                                   _cart.updateProductQuantity(
//                                                                       product
//                                                                           .productId,
//                                                                       productQuantityH);
//                                                                   state
//                                                                       .products[
//                                                                           index]
//                                                                       .quantity = productQuantityH;
//                                                                   totalCostH = _cart
//                                                                       .calculateTotalForAddedProductsH(
//                                                                           state
//                                                                               .products,
//                                                                           isAddedToCartListH);
//                                                                   // _cart
//                                                                   //     .calculateTotalAndQuantity();
//                                                                 });
//                                                               },
//                                                               maxOfferQuantity:
//                                                                   state
//                                                                       .products[
//                                                                           index]
//                                                                       .maxOfferQuantity,
//                                                             ),
//                                                           ),
//                                                           InkWell(
//                                                             onTap: () {
//                                                               setState(() {
//                                                                 isAddedToCartListH[
//                                                                         index] =
//                                                                     false;
//                                                                 _cart.removeProduct(
//                                                                     product);
//                                                                 totalCostH = _cart
//                                                                     .calculateTotalForAddedProductsH(
//                                                                         state
//                                                                             .products,
//                                                                         isAddedToCartListH);
//                                                                 //  _cart
//                                                                 //     .calculateTotalAndQuantity();
//                                                                 _cart.isAddedToCartMapH[
//                                                                         index] =
//                                                                     false;
//                                                                 // _cart
//                                                                 //     .productQuantitiesH
//                                                                 //     .updateAll(
//                                                                 //         (key, value) =>
//                                                                 //             1);
//                                                               });
//                                                             },
//                                                             child: Padding(
//                                                               padding: EdgeInsets
//                                                                   .symmetric(
//                                                                       horizontal:
//                                                                           paddingAllSides),
//                                                               child: Text(
//                                                                 'الغاء',
//                                                                 style:
//                                                                     TextStyle(
//                                                                   color: Colors
//                                                                       .red,
//                                                                   fontSize:
//                                                                       getResponsiveFontSize(
//                                                                           20),
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       )
//                                                     : ElevatedButton(
//                                                         key: ValueKey(
//                                                             'button_${product.productId}'),
//                                                         onPressed: () {
//                                                           setState(() {
//                                                             isAddedToCartListH[
//                                                                 index] = true;
//                                                             _cart.addProduct(
//                                                                 product,
//                                                                 state.supplier!
//                                                                     .firstName);
//                                                             _cart
//                                                                 .addSupplierInfo(
//                                                               state.supplier!
//                                                                   .firstName,
//                                                               state.supplier!
//                                                                   .minBillPrice,
//                                                               state.supplier!
//                                                                   .minSellingQuantity,
//                                                             );
//                                                             totalCostH = _cart
//                                                                 .calculateTotalForAddedProductsH(
//                                                                     state
//                                                                         .products,
//                                                                     isAddedToCartListH);
//                                                             //  _cart
//                                                             //     .calculateTotalAndQuantity();
//                                                             widget
//                                                                 .onProductSelected(
//                                                                     product);
//                                                             _cart.isAddedToCartMapH[
//                                                                 index] = true;
//                                                           });
//                                                         },
//                                                         style: ElevatedButton
//                                                             .styleFrom(
//                                                           foregroundColor:
//                                                               Colors.white,
//                                                           backgroundColor:
//                                                               Colors.blue,
//                                                           minimumSize: Size(
//                                                               buttonWidth,
//                                                               buttonHeight),
//                                                           shape:
//                                                               RoundedRectangleBorder(
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                         5),
//                                                           ),
//                                                         ),
//                                                         child: Text(
//                                                           '+ إضافة ',
//                                                           style: Styles
//                                                                   .textStyle20(
//                                                                       context)
//                                                               .copyWith(
//                                                                   color: Colors
//                                                                       .white),
//                                                         ),
//                                                       ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                         );
//                       } else if (state is ProductsLoading) {
//                         return buildLoadingIndicator();
//                       } else if (state is ProductsError) {
//                         builError(state.errorMessage);
//                       }
//                       return Container(
//                         height: 0,
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           SizedBox(width: getResponsiveSizedBoxWidth(20)),
//           Align(
//             alignment: Alignment.topRight,
//             child: Text(
//               ' الإجمالي: ${totalCost = totalCost1 + totalCostH}',
//               style: Styles.textStyle20(context)
//                   .copyWith(fontWeight: FontWeight.bold)
//                   .copyWith(color: const Color.fromARGB(255, 77, 66, 66)),
//               textAlign: TextAlign.right,
//             ),
//           ),
//           Align(
//             alignment: Alignment.topRight,
//             child: Text(
//               ' الحد الأدنى  ${widget.supplier!.firstName}:  ${widget.supplier!.minBillPrice} ',
//               style: Styles.textStyle20(context)
//                   .copyWith(fontWeight: FontWeight.bold),
//               textAlign: TextAlign.right,
//             ),
//           ),
//           SizedBox(width: getResponsiveSizedBoxWidth(20)),
//           Stack(
//             children: [
//               LinearProgressIndicator(
//                 minHeight: 50,
//                 value: progressValue,
//                 backgroundColor: Colors.grey[200],
//                 valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
//               ),
//               // Positioned.fill(
//               //   child: Align(
//               //     alignment: Alignment.centerRight,
//               //     child: Padding(
//               //       padding:
//               //           EdgeInsets.symmetric(horizontal: paddingAllSides),
//               //       child:
//               //     ),
//               //   ),
//               // ),
//               Positioned(
//                 right: (MediaQuery.of(context).size.width * progressValue - 14)
//                     .clamp(0.0, MediaQuery.of(context).size.width - 60),
//                 top: 0,
//                 bottom: 0,
//                 left: 9,
//                 child: CircleAvatar(
//                   radius: 30, // حجم الدائرة
//                   backgroundColor: Colors.red, // لون الخلفية الدائري
//                   child: IconButton(
//                     color: Colors.white,
//                     onPressed: () {
//                       if (progressValue < 1) {
//                         showCustomAlertDialog(
//                           context: context,
//                           title: 'تنبيه',
//                           content:
//                               'يجب عليك استكمال الحد الأدنى للشراء للمتابعة. يرجى إضافة المزيد من المنتجات.',
//                         );
//                       } else {
//                         // resetAllButtons();
//                         // resetAllListButtons();
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => CartPage(
//                               supplier: widget.supplier,
//                               order: widget.order,
//                               supplierNames: widget.supplierNames,
//                               minBillPrice: widget.supplier!.minBillPrice,
//                               minSellingQuantity:
//                                   widget.supplier!.minSellingQuantity,
//                               totlepriceSupllier: totalCost,
//                             ),
//                           ),
//                         ).then((value) {
//                           if (value == true) {
//                             // قم بتحديث الصفحة هنا
//                             setState(() {
//                               // على سبيل المثال، يمكن تحديث البيانات أو إعادة بناء الواجهة
//                             });
//                           }
//                         });
//                       }
//                     },
//                     icon: const Icon(
//                       Icons.shopping_cart,
//                       size: 30, // تعيين حجم الأيقونة
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }

// //  double total = 0;

//   double calculateTotalAndQuantity1(Product product) {
//     if (product.hasOffer) {
//       int offerQuantity = product.maxOfferQuantity;
//       int restQuantity = product.quantity - offerQuantity;

//       if (restQuantity > 0) {
//         totalCost1 += (offerQuantity * product.offerPrice) +
//             (restQuantity * product.price);
//       } else {
//         totalCost1 += (product.quantity * product.offerPrice);
//       }
//     } else {
//       totalCost1 += (product.quantity * product.price);
//     }
//     return totalCost1;
//   }

//   // double calculateTotalForAddedProductsH(
//   //     List<Product> products, List<bool> isAddedToCartListH) {
//   //   double total = 0.0;

//   //   for (int i = 0; i < products.length; i++) {
//   //     if (isAddedToCartListH[i]) {
//   //       final item = products[i];
//   //       if (item.hasOffer) {
//   //         int offerQuantity = item.maxOfferQuantity;
//   //         int restQuantity = item.quantity - offerQuantity;
//   //         if (restQuantity > 0) {
//   //           total +=
//   //               (offerQuantity * item.offerPrice) + (restQuantity * item.price);
//   //         } else {
//   //           total += (item.quantity * item.offerPrice);
//   //         }
//   //       } else {
//   //         total += (item.quantity * item.price);
//   //       }
//   //     }
//   //   }

//   //   return total;
//   // }

//   // double calculateTotalForAddedProducts(
//   //     List<Product> products, List<bool> isAddedToCartList) {
//   //   double total = 0.0;

//   //   for (int i = 0; i < products.length; i++) {
//   //     if (isAddedToCartList[i]) {
//   //       final item = products[i];
//   //       if (item.hasOffer) {
//   //         int offerQuantity = item.maxOfferQuantity;
//   //         int restQuantity = item.quantity - offerQuantity;
//   //         if (restQuantity > 0) {
//   //           total +=
//   //               (offerQuantity * item.offerPrice) + (restQuantity * item.price);
//   //         } else {
//   //           total += (item.quantity * item.offerPrice);
//   //         }
//   //       } else {
//   //         total += (item.quantity * item.price);
//   //       }
//   //     }
//   //   }

//   //   return total;
//   // }

//   // void resetAllButtons() {
//   //   setState(() {
//   //     for (int i = 0; i < isAddedToCartList1.length; i++) {
//   //       isAddedToCartList1[i] = false;
//   //       isAddedToCartMap1[i] = false;
//   //     }
//   //     totalCost = _cart.calculateTotalAndQuantity();
//   //     progressValue = 0;
//   //   });
//   // }

//   // void resetAllListButtons() {
//   //   setState(() {
//   //     for (int i = 0; i < isAddedToCartList2.length; i++) {
//   //       isAddedToCartList2[i] = false;
//   //       isAddedToCartMap2[i] = false;
//   //     }
//   //     totalCost = _cart.calculateTotalAndQuantity();
//   //     progressValue = 0;
//   //   });
//   // }
// }
