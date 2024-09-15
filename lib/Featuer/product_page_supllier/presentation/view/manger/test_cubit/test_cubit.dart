// import 'package:bloc/bloc.dart';
// import 'package:eghyptproject/Featuer/Auth/cubit/user_cubit_cubit.dart';
// import 'package:eghyptproject/Featuer/home/presentation/view/widget/move_photo.dart';
// import 'package:eghyptproject/Featuer/product_page_supllier/data/product_model.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:dio/dio.dart';

// class ApiProvider {
//   final Dio dio = Dio();

//   ApiProvider();

//   Future<Map<String, dynamic>> fetchData(
//     String endpoint,
//   ) async {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('access_token');
//     dio.options.headers['Authorization'] = 'Bearer $token';
//     final response = await dio.get(endpoint);
//     return response.data;
//   }
// }

// class SupplierCubitAll extends Cubit<SupplierStateAll> {
//   final ApiProvider apiProvider;
//   // final int supplierId;

//   SupplierCubitAll({
//     required this.apiProvider,
//     // required this.supplierId,
//   }) : super(SupplierInitialAll());

//   void fetchAllData(int supplierId) async {
//     try {
//       emit(SupplierLoadingAll());

//       final supplierData = await apiProvider.fetchData(
//           'https://backend.almowafraty.com/api/v1/markets/suppliers/$supplierId');

//       final supplier = SupplierModel.fromJson(supplierData['supplier']);
//       final categoriesJson = supplierData['product_categories'] as List;
//       final categories =
//           categoriesJson.map((json) => ProductCategory.fromJson(json)).toList();

//       final productsJson = supplierData['products_without_offer'] as List;
//       final products =
//           productsJson.map((json) => Product.fromJson(json)).toList();

//       final productsWithOfferJson = supplierData['products_with_offer'] as List;
//       final productsWithOffer =
//           productsWithOfferJson.map((json) => Product.fromJson(json)).toList();

//       final offersJson = supplierData['slider_offers'] as List;
//       final offers = offersJson.map((json) => Offer.fromJson(json)).toList();

//       emit(SupplierLoadedAll(
//         supplier: supplier,
//         categories: [ProductCategory(id: 0, name: 'الكل'), ...categories],
//         products: products,
//         productsWithOffer: productsWithOffer,
//         offers: offers,
//       ));
//     } on DioException catch (e) {
//       String errorMessage = ErrorHandler.handleDioError(e);
//       emit(SupplierErrorAll(errorMessage));
//     } catch (e) {
//       emit(SupplierErrorAll("An unexpected error occurred: ${e.toString()}"));
//     }
//   }
// }

// abstract class SupplierStateAll {}

// class SupplierInitialAll extends SupplierStateAll {}

// class SupplierLoadingAll extends SupplierStateAll {}

// class SupplierLoadedAll extends SupplierStateAll {
//   final SupplierModel supplier;
//   final List<ProductCategory> categories;
//   final List<Product> products;
//   final List<Product> productsWithOffer;
//   final List<Offer> offers;
//   final int selectedCategoryId;

//   SupplierLoadedAll({
//     required this.supplier,
//     required this.categories,
//     required this.products,
//     required this.productsWithOffer,
//     required this.offers,
//     this.selectedCategoryId = 0,
//   });
// }

// class SupplierErrorAll extends SupplierStateAll {
//   final String errorMessage;

//   SupplierErrorAll(this.errorMessage);
// }
