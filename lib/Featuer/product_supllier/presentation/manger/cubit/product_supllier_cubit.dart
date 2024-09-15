import 'dart:convert';
import 'package:eghyptproject/Featuer/product_supllier/data/model/product_supllier_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/repository/product_supllier_repo.dart';

part 'product_supllier_state.dart';

class ProductSupplierCubit extends Cubit<ProductSupplierState> {
  ProductSupplierCubit() : super(ProductSupplierInitial());

  // final player = AudioPlayer();

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerState =
      GlobalKey<ScaffoldMessengerState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldSearchMessengerState =
      GlobalKey<ScaffoldMessengerState>();
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  TextEditingController searchController = TextEditingController();

  final ProductSupplierRepoImp productSupplierRepoImp =
      ProductSupplierRepoImp();

  ProductSupplierModelAA? productSupplierItems;

  /// Loads the product supplier data from the repository and emits states accordingly.
  void loadProductSupplier() async {
    emit(ProductSupplierLoading());

    final result = await productSupplierRepoImp.getProductSupplier(id: 94);
    if (result is ProductSupplierModelAA) {
      productSupplierItems = result;
      getTotalPrice(
        productSupplierItems!.productsWithOffer,
        productSupplierItems!.productsWithoutOffer,
      );
      selectCategory(
        productSupplierItems!.productCategories,
        productSupplierItems!.productsWithOffer,
        productSupplierItems!.productsWithoutOffer,
      );
      emit(ProductSupplierLoaded(productSupplierModel: productSupplierItems!));
    } else if (result is String) {
      emit(ProductSupplierError(message: result));
    }
  }

  Map<int, List<ProductsWithOffer>> product = {};
  List<ProductsWithOffer> productSearch = [];

  void searchForProducts(String nameProduct) {
    productSearch = [];
    productSearch.addAll(productSupplierItems!.productsWithOffer
        .where((e) => e.name.contains(nameProduct.trim()))
        .toList());
    productSearch.addAll(productSupplierItems!.productsWithoutOffer
        .where((e) => e.name.contains(nameProduct.trim()))
        .toList());
    if (nameProduct == '') {
      productSearch = [];
    }
    emit(ProductSupplierLoaded(productSupplierModel: productSupplierItems!));
  }
  //!-------------------------------------------------------

  void selectCategory(
    List<ProductCategory> categories,
    List<ProductsWithOffer> productsWithOfferItems,
    List<ProductsWithOffer> productsWithoutOfferItems,
  ) {
    for (var category in categories) {
      List<ProductsWithOffer> products = productsWithOfferItems
          .where((element) => element.productCategoryId == category.id)
          .toList();
      products.addAll(productsWithoutOfferItems
          .where((element) => element.productCategoryId == category.id)
          .toList());
      product.addAll({category.id: products});
    }
  }

  //!-------------------------------------------------------

  double totalPrice = 0;

  void getTotalPrice(
    List<ProductsWithOffer> productsWithOfferItems,
    List<ProductsWithOffer> productsWithoutOfferItems,
  ) {
    double totalPriceProductsWithOffer = productsWithOfferItems
        .where((product) =>
            productWithOfferCart.containsKey(product.id.toString()))
        .fold(0, (sum, product) {
      final int maxOfferQuantity = product.maxOfferQuantity;
      final int price = product.price;
      final int priceOffer = product.offerPrice;
      int quantity = int.parse(productWithOfferCart[product.id.toString()]);
      int maxOfferCount = maxOfferQuantity;

      for (int j = 0; j < quantity; j++) {
        if (maxOfferCount > 0) {
          maxOfferCount--;
          sum += priceOffer;
        } else {
          sum += price;
        }
      }
      return sum;
    });
    double totalPriceProductsWithoutOffer = productsWithoutOfferItems
        .where(
            (element) => productWithoutOfferCart.containsKey('${element.id}'))
        .fold(0, (sum, element) {
      return sum +
          element.price *
              int.parse(productWithoutOfferCart[element.id.toString()]);
    });

    totalPrice = totalPriceProductsWithOffer + totalPriceProductsWithoutOffer;
  }

  //!-------------------------------------------------------

  Map<String, dynamic> productWithOfferCart = {};

  /// Adds a product with an offer to the cart, showing appropriate messages based on the availability.
  void addProductWithOfferToCart(ProductsWithOffer productsWithOffer) async {
    final productId = productsWithOffer.id;
    final maxSellingQuantity = productsWithOffer.maxSellingQuantity;
    final maxOfferQuantity = productsWithOffer.maxOfferQuantity;
    final price = productsWithOffer.price;
    final offerPrice = productsWithOffer.offerPrice;

    clearAllSnackBar();

    if (maxSellingQuantity < 1) {
      snackBar('لا يوجد كميات لإضافة المنتج');
      return;
    } else if (maxOfferQuantity < 1) {
      totalPrice += price;
      snackBar(
        'تمت إضافة المنتج دون الحصول على العرض بسبب انتهاء الكمية المتوفرة من العرض',
      );
    } else if (maxOfferQuantity > 0 && maxSellingQuantity > 0) {
      totalPrice += offerPrice;

      snackBar('تمت إضافة المنتج مع الحصول على العرض');
    }

    // await player.play(AssetSource('music/add_product.mp3'));

    productWithOfferCart['$productId'] = '1';

    setProductWithOfferCart();

    emit(ProductSupplierLoaded(productSupplierModel: productSupplierItems!));
  }

  /// Removes a product with an offer from the cart.
  void removeProductWithOfferFromCart(int productId) {
    if (productWithOfferCart.containsKey('$productId')) {
      productWithOfferCart.remove('$productId');

      setProductWithOfferCart();

      emit(ProductSupplierLoaded(productSupplierModel: productSupplierItems!));
    }
  }

  /// Adds more of the same product with an offer to the cart, showing appropriate messages based on the availability.
  void addMoreProductWithOfferToCart(
      ProductsWithOffer productsWithOffer) async {
    final int productId = productsWithOffer.id;
    final int maxOfferQuantity = productsWithOffer.maxOfferQuantity;
    final int maxSellingQuantity = productsWithOffer.maxSellingQuantity;
    final int price = productsWithOffer.price;
    final int offerPrice = productsWithOffer.offerPrice;

    clearAllSnackBar();

    if (maxSellingQuantity <= int.parse(productWithOfferCart['$productId']!)) {
      snackBar('لا يوجد كميات متوفرة لإضافة المنتج');
      return;
    } else if (maxOfferQuantity <=
        int.parse(productWithOfferCart['$productId']!)) {
      totalPrice += price;

      snackBar(
        'تمت إضافة المنتج دون الحصول على العرض بسبب انتهاء الكمية المتوفرة من العرض',
      );
    } else if (maxOfferQuantity >
            int.parse(productWithOfferCart['$productId']!) &&
        maxSellingQuantity > int.parse(productWithOfferCart['$productId']!)) {
      totalPrice += offerPrice;

      snackBar('تمت إضافة المنتج مع الحصول على العرض');
    }

    // await player.play(AssetSource('music/add_more_product.mp3'));

    productWithOfferCart.update('$productId', (value) {
      return '${int.parse(value) + 1}';
    });

    setProductWithOfferCart();

    emit(ProductSupplierLoaded(productSupplierModel: productSupplierItems!));
  }

  /// Removes more of the same product with an offer from the cart.
  void removeMoreProductWithOfferFromCart(
      ProductsWithOffer productsWithOffer) async {
    final int productId = productsWithOffer.id;
    final int maxOfferQuantity = productsWithOffer.maxOfferQuantity;
    final int price = productsWithOffer.price;
    final int offerPrice = productsWithOffer.offerPrice;

    // await player.play(AssetSource('music/remove_product.mp3'));

    if (maxOfferQuantity >= int.parse(productWithOfferCart['$productId']!)) {
      totalPrice -= offerPrice;
    } else {
      totalPrice -= price;
    }

    if (int.parse(productWithOfferCart['$productId']!) == 1) {
      removeProductWithOfferFromCart(productId);
    } else {
      productWithOfferCart.update('$productId', (value) {
        return '${int.parse(value) - 1}';
      });
    }

    setProductWithOfferCart();

    emit(ProductSupplierLoaded(productSupplierModel: productSupplierItems!));
  }

  /// Checks the status of a product with an offer in the cart.
  /// Returns 1 if the product quantity is greater than 1,
  /// 0 if the product quantity is 1,
  /// and -1 if the product is not in the cart.
  int checkStatusProductWithOffer(ProductsWithOffer productsWithOffer) {
    final int productId = productsWithOffer.id;

    if (productWithOfferCart.containsKey('$productId')) {
      if (int.parse(productWithOfferCart['$productId']!) > 1) {
        return 1;
      } else {
        return 0;
      }
    } else {
      return -1;
    }
  }

  //!-------------------------------------------------------

  final String keyProductWithOffer = 'keyProductWithOffer';

  /// Saves the current state of the cart to shared preferences.
  void setProductWithOfferCart() async {
    final SharedPreferences pref = await _pref;

    String encodedMap = json.encode(productWithOfferCart);

    pref.setString(keyProductWithOffer, encodedMap);
  }

  /// Retrieves the current state of the cart from shared preferences.
  void getProductWithOfferCart() async {
    final SharedPreferences pref = await _pref;
    String? productWithOffer = pref.getString(keyProductWithOffer);
    if (productWithOffer != null) {
      productWithOfferCart = json.decode(productWithOffer);
    } else {
      productWithOfferCart = {};
    }
  }

  //!-------------------------------------------------------

  Map<String, dynamic> productWithoutOfferCart = {};

  /// Adds a product without an offer to the cart, showing appropriate messages based on the availability.
  void addProductWithoutOfferToCart(
      ProductsWithOffer productsWithoutOffer) async {
    final productId = productsWithoutOffer.id;
    final maxSellingQuantity = productsWithoutOffer.maxSellingQuantity;
    final int price = productsWithoutOffer.price;

    clearAllSnackBar();

    if (maxSellingQuantity < 1) {
      snackBar('لا يوجد كميات لإضافة المنتج');
      return;
    } else if (maxSellingQuantity > 0) {
      snackBar('تمت إضافة المنتج');
    }

    totalPrice += price;

    // await player.play(AssetSource('music/add_product.mp3'));

    productWithoutOfferCart['$productId'] = '1';

    setProductWithoutOfferCart();

    emit(ProductSupplierLoaded(productSupplierModel: productSupplierItems!));
  }

  /// Removes a product without an offer from the cart.
  void removeProductWithoutOfferFromCart(int productId) {
    if (productWithoutOfferCart.containsKey('$productId')) {
      productWithoutOfferCart.remove('$productId');

      setProductWithoutOfferCart();

      emit(ProductSupplierLoaded(productSupplierModel: productSupplierItems!));
    }
  }

  /// Adds more of the same product without an offer to the cart, showing appropriate messages based on the availability.
  void addMoreProductWithoutOfferToCart(
      ProductsWithOffer productsWithoutOffer) async {
    final int productId = productsWithoutOffer.id;
    final int maxSellingQuantity = productsWithoutOffer.maxSellingQuantity;
    final int price = productsWithoutOffer.price;

    clearAllSnackBar();

    if (maxSellingQuantity <=
        int.parse(productWithoutOfferCart['$productId']!)) {
      snackBar('لا يوجد كميات متوفرة لإضافة المنتج');
      return;
    } else if (maxSellingQuantity >
        int.parse(productWithoutOfferCart['$productId']!)) {
      snackBar('تمت إضافة المنتج');
    }

    totalPrice += price;

    // await player.play(AssetSource('music/add_more_product.mp3'));

    productWithoutOfferCart.update('$productId', (value) {
      return '${int.parse(value) + 1}';
    });

    setProductWithoutOfferCart();

    emit(ProductSupplierLoaded(productSupplierModel: productSupplierItems!));
  }

  /// Removes more of the same product without an offer from the cart.
  void removeMoreProductWithoutOfferFromCart(
      ProductsWithOffer productsWithoutOffer) async {
    final int productId = productsWithoutOffer.id;
    final int price = productsWithoutOffer.price;

    // await player.play(AssetSource('music/remove_product.mp3'));

    totalPrice -= price;

    if (int.parse(productWithoutOfferCart['$productId']!) == 1) {
      removeProductWithoutOfferFromCart(productId);
    } else {
      productWithoutOfferCart.update('$productId', (value) {
        return '${int.parse(value) - 1}';
      });
    }

    setProductWithoutOfferCart();

    emit(ProductSupplierLoaded(productSupplierModel: productSupplierItems!));
  }

  /// Checks the status of a product without an offer in the cart.
  /// Returns 1 if the product quantity is greater than 1,
  /// 0 if the product quantity is 1,
  /// and -1 if the product is not in the cart.
  int checkStatusProductWithoutOffer(ProductsWithOffer productsWithoutOffer) {
    final int productId = productsWithoutOffer.id;

    if (productWithoutOfferCart.containsKey('$productId')) {
      if (int.parse(productWithoutOfferCart['$productId']!) > 1) {
        return 1;
      } else {
        return 0;
      }
    } else {
      return -1;
    }
  }

  //!-------------------------------------------------------

  final String keyProductWithoutOffer = 'keyProductWithoutOffer';

  /// Saves the current state of the cart without offers to shared preferences.
  void setProductWithoutOfferCart() async {
    final SharedPreferences pref = await _pref;

    String encodedMap = json.encode(productWithoutOfferCart);

    pref.setString(keyProductWithoutOffer, encodedMap);
  }

  /// Retrieves the current state of the cart without offers from shared preferences.
  void getProductWithoutOfferCart() async {
    final SharedPreferences pref = await _pref;
    String? productWithoutOffer = pref.getString(keyProductWithoutOffer);

    if (productWithoutOffer != null) {
      productWithoutOfferCart = json.decode(productWithoutOffer);
    } else {
      productWithoutOfferCart = {};
    }
  }

  //!-------------------------------------------------------

  void buyProduct() {
    if (totalPrice < productSupplierItems!.supplier.minSellingQuantity) {
      snackBar('لا يمكنك شراء المنتجات بسبب عدم اكتمال الحد الادنى');
    } else {
      // totalPrice = 0;
    }
  }

  //!-------------------------------------------------------

  /// Displays a snackbar with the given message.
  void snackBar(String title) {
    scaffoldMessengerState.currentState!.showSnackBar(
      SnackBar(
        content: Text(title),
        duration: const Duration(milliseconds: 800),
      ),
    );
  }

  /// Clears all currently displayed snackbars.
  void clearAllSnackBar() {
    scaffoldMessengerState.currentState!.clearSnackBars();
  }
}
