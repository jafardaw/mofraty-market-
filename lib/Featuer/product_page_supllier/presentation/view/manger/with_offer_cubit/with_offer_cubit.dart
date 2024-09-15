// // import 'package:eghyptproject/Featuer/product_page_supllier/presentation/view/manger/product_supllier_cubit.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:dio/dio.dart';
// // import 'package:eghyptproject/Featuer/Auth/cubit/user_cubit_cubit.dart';
// // import 'package:eghyptproject/Featuer/product_page_supllier/data/product_model.dart';
// // import 'package:equatable/equatable.dart';

// // part 'with_offer_state.dart';

// // class WithOfferCubit extends Cubit<WithOfferState> {
// //   final ApiProvider apiProvider;
// //   WithOfferCubit(this.apiProvider) : super(WithOfferInitial());
// //   void fetchProductWithOffer(int categoryId, int id) async {
// //     try {
// //       emit(WithOfferLoading());
// //       await apiProvider.ensureDataFetched(id);
// //       final response = apiProvider.getResponse();

// //       if (response == null ||
// //           response['supplier'] == null ||
// //           response['products_with_offer'] == null) {
// //         print("No products with offer found.");
// //         // emit(WithOfferError("No products with offer found."));
// //         return;
// //       }

// //       final supplier = SupplierModel.fromJson(response['supplier']);
// //       final List<dynamic> productsJson = response['products_with_offer'];
// //       final List<Product> products = productsJson
// //           .where((json) =>
// //               categoryId == 0 || json['product_category_id'] == categoryId)
// //           .map((json) => Product.fromJson(json))
// //           .toList();

// //       emit(WithOfferSuccess(products, supplier, categoryId));
// //     } on DioException catch (e) {
// //       String errorMessage = ErrorHandler.handleDioError(e);
// //       emit(WithOfferError(errorMessage));
// //     } catch (e) {
// //       emit(WithOfferError("An unexpected error occurred: ${e.toString()}"));
// //     }
// //   }
// // }

// import 'package:eghyptproject/Featuer/product_page_supllier/presentation/view/manger/product_supllier_cubit.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:dio/dio.dart';
// import 'package:eghyptproject/Featuer/Auth/cubit/user_cubit_cubit.dart';
// import 'package:eghyptproject/Featuer/product_page_supllier/data/product_model.dart';
// import 'package:equatable/equatable.dart';

// part 'with_offer_state.dart';

// class WithOfferCubit extends Cubit<WithOfferState> {
//   final ApiProvider apiProvider;
//   WithOfferCubit(this.apiProvider) : super(WithOfferInitial());

//   void fetchProductWithOffer(int categoryId, int id) async {
//     try {
//       if (isClosed) return; // تحقق من أن الكيوبت لم يتم إغلاقه
//       emit(WithOfferLoading());
//       await apiProvider.ensureDataFetched(id);
//       final response = apiProvider.getResponse();

//       if (response == null ||
//           response['supplier'] == null ||
//           response['products_with_offer'] == null) {
//         print("No products with offer found.");
//         if (!isClosed) {
//           emit(const WithOfferError("No products with offer found."));
//         }
//         return;
//       }

//       final supplier = SupplierModel.fromJson(response['supplier']);
//       final List<dynamic> productsJson = response['products_with_offer'];
//       final List<Product> products = productsJson
//           .where((json) =>
//               categoryId == 0 || json['product_category_id'] == categoryId)
//           .map((json) => Product.fromJson(json))
//           .toList();

//       if (!isClosed) {
//         emit(WithOfferSuccess(products, supplier, categoryId));
//       }
//     } on DioException catch (e) {
//       String errorMessage = ErrorHandler.handleDioError(e);
//       if (!isClosed) {
//         emit(WithOfferError(errorMessage));
//       }
//     } catch (e) {
//       if (!isClosed) {
//         emit(WithOfferError("An unexpected error occurred: ${e.toString()}"));
//       }
//     }
//   }
// }
