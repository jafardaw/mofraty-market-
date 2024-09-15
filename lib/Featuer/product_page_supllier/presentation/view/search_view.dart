import 'package:dio/dio.dart';
import 'package:eghyptproject/Featuer/Auth/cubit/user_cubit_cubit.dart';
import 'package:eghyptproject/Featuer/product_page_supllier/presentation/view/product_list.dart';
import 'package:eghyptproject/constant.dart';
import 'package:eghyptproject/core/styles.dart';
import 'package:eghyptproject/core/widget/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductSearch {
  final num id;
  final num productCategoryId;
  final String description;
  final String name;
  final String storeName;
  final num supplierId;
  final num price;
  final num offerPrice;
  final num hasOffer;
  final num maxSellingQuantity;
  final num minSellingQuantity;
  final List<String> image;
  final String productCategory;

  ProductSearch({
    required this.id,
    required this.productCategoryId,
    required this.description,
    required this.name,
    required this.storeName,
    required this.supplierId,
    required this.price,
    required this.hasOffer,
    required this.offerPrice,
    required this.maxSellingQuantity,
    required this.minSellingQuantity,
    required this.image,
    required this.productCategory,
  });

  factory ProductSearch.fromJson(Map<String, dynamic> json) {
    return ProductSearch(
      id: json['id'],
      productCategoryId: json['product_category_id'],
      description: json['discription'],
      name: json['name'],
      storeName: json['store_name'],
      supplierId: json['supplier_id'],
      price: json['price'],
      hasOffer: json['has_offer'],
      offerPrice: json['offer_price'],
      maxSellingQuantity: json['max_selling_quantity'],
      minSellingQuantity: json['min_selling_quantity'],
      image: List<String>.from(json['image']),
      productCategory: json['product_category'],
    );
  }
}

abstract class ProductStateSearch {}

class ProductSearchInitial extends ProductStateSearch {}

class ProductSearchLoading extends ProductStateSearch {}

class ProductSearchLoaded extends ProductStateSearch {
  final List<ProductSearch> products;
  final int currentPage;
  final int lastPage;

  ProductSearchLoaded(this.products, this.currentPage, this.lastPage);
}

class ProductSearchError extends ProductStateSearch {
  final String message;

  ProductSearchError(this.message);
}

class ProductSearchCubit extends Cubit<ProductStateSearch> {
  final Dio _dio = Dio(
    BaseOptions(
      headers: {
        'Accept': 'application/json',
      },
    ),
  );
  int currentPage = 1;
  int lastPage = 1;
  bool isFetching = false;
  String lastQuery = '';

  ProductSearchCubit() : super(ProductSearchInitial());

  void fetchProducts(String query, int page, String token) async {
    if (isFetching) return;
    emit(ProductSearchLoading());
    try {
      isFetching = true;
      final response = await _dio.get(
        'https://backend.almowafraty.com/api/v1/markets/products',
        queryParameters: {'search': query, 'page': page},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      final data = response.data['products'];
      final products = List<ProductSearch>.from(
        data['data'].map((x) => ProductSearch.fromJson(x)),
      );
      currentPage = data['current_page'];
      lastPage = data['last_page'];
      if (page == 1) {
        emit(ProductSearchLoaded(products, currentPage, lastPage));
      } else {
        final currentState = state;
        if (currentState is ProductSearchLoaded) {
          final updatedProducts = currentState.products + products;
          emit(ProductSearchLoaded(updatedProducts, currentPage, lastPage));
        }
      }
      isFetching = false;
    } on DioException catch (e) {
      String errorMessage = ErrorHandler.handleDioError(e);
      emit(ProductSearchError(errorMessage));
      isFetching = false;
    } catch (e) {
      emit(ProductSearchError("An unexpected error occurred: ${e.toString()}"));
      isFetching = false;
    }
  }

  void fetchInitialProducts(String token) async {
    currentPage = 1;
    lastQuery = '';
    fetchProducts('', 1, token);
  }

  void fetchMoreProducts(String query) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    if (currentPage < lastPage) {
      fetchProducts(query, currentPage + 1, token!);
    }
  }
}

// استبدل هذا بمسار ملف ProductCubit الخاص بك
//////////////////////////////////////////////////////////////////////////////////////////////////
///
///
class ProductSearchDelegate22 extends SearchDelegate<void> {
  final int id;
  final String type;
  ProductSearchDelegate22(this.id, this.type);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.grey,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  void _loadTokenAndInitProduct(ProductSearchCubit cubit) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(
        'access_token'); // 'token' هو المفتاح الذي تم استخدامه لحفظ الرمز المميز
    if (token != null) {
      cubit.fetchProducts(query, 1, token); // استدعاء الدالة مع الـ token
    } else {
      // يمكنك التعامل مع حالة عدم وجود الرمز المميز هنا
      // مثلاً بإظهار رسالة خطأ أو بالانتقال إلى صفحة تسجيل الدخول
    }
  }

  @override
  Widget buildResults(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = ProductSearchCubit();
        _loadTokenAndInitProduct(cubit);
        return cubit;
      },
      child: BlocBuilder<ProductSearchCubit, ProductStateSearch>(
        builder: (context, state) {
          if (state is ProductSearchLoading) {
            return buildLoadingIndicator();
          } else if (state is ProductSearchLoaded) {
            if (state.products.isEmpty) {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'لا توجد منتجات بهذا الاسم الرجاء التأكد',
                    style:
                        Styles.textStyle24(context).copyWith(color: Colors.red),
                  ),
                  SvgPicture.asset(
                      width: 150,
                      height: 150,
                      'assets/images/No data-pana (2).svg'),
                ],
              ));
            }
            return NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent &&
                    !context.read<ProductSearchCubit>().isFetching) {
                  final cubit = context.read<ProductSearchCubit>();
                  _loadTokenAndInitProduct(cubit);
                  cubit.fetchMoreProducts(query); // Pass the token here
                  return true;
                }
                return false;
              },
              child: ListView.builder(
                itemCount: state.products.length + 1,
                itemBuilder: (context, index) {
                  if (index == state.products.length) {
                    return state.currentPage < state.lastPage
                        ? buildLoadingIndicator()
                        : const SizedBox.shrink();
                  }
                  var image = state.products[index].image.first;
                  return ProductCardSearch(
                    image: image,
                    product: state.products[index],
                    id: id,
                    type: type,
                  );
                },
              ),
            );
          } else if (state is ProductSearchError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('ابدأ البحث'));
          }
        },
      ),
    );
  }

  void _loadTokenAndInit(ProductSearchCubit cubit) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(
        'access_token'); // 'token' هو المفتاح الذي تم استخدامه لحفظ الرمز المميز
    if (token != null) {
      cubit.fetchInitialProducts(token); // استخدام الـ token هنا
    } else {
      // يمكنك التعامل مع حالة عدم وجود الرمز المميز هنا
      // مثلاً بإظهار رسالة خطأ أو بالانتقال إلى صفحة تسجيل الدخول
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = ProductSearchCubit();
        _loadTokenAndInit(cubit);
        return cubit;
      },
      child: BlocBuilder<ProductSearchCubit, ProductStateSearch>(
        builder: (context, state) {
          if (state is ProductSearchLoading) {
            return buildLoadingIndicator();
          } else if (state is ProductSearchLoaded) {
            if (state.products.isEmpty) {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'لا توجد منتجات',
                    style:
                        Styles.textStyle24(context).copyWith(color: Colors.red),
                  ),
                  SvgPicture.asset(
                      width: 150,
                      height: 150,
                      'assets/images/No data-pana (2).svg'),
                ],
              ));
            }
            return NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent &&
                    !context.read<ProductSearchCubit>().isFetching) {
                  final cubit = context.read<ProductSearchCubit>();
                  _loadTokenAndInitProduct(cubit);
                  cubit.fetchMoreProducts(query); // Pass the token here
                  return true;
                }
                return false;
              },
              child: ListView.builder(
                itemCount: state.products.length + 1,
                itemBuilder: (context, index) {
                  if (index == state.products.length) {
                    return state.currentPage < state.lastPage
                        ? buildLoadingIndicator()
                        : const SizedBox.shrink();
                  }
                  var image = state.products[index].image.first;
                  return ProductCardSearch(
                    image: image,
                    product: state.products[index],
                    id: id,
                    type: type,
                  );
                },
              ),
            );
          } else if (state is ProductSearchError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('ابدأ البحث'));
          }
        },
      ),
    );
  }
}

class ProductCardSearch extends StatelessWidget {
  final ProductSearch product;
  final dynamic image;
  final int id;
  final String type;
  const ProductCardSearch({
    super.key,
    required this.product,
    required this.image,
    required this.id,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isTablet = screenSize.width >= 600;

    final double horizontalPadding = screenSize.width * 0.02;
    final double verticalPadding = screenSize.height * 0.02;
    final double spacing = screenSize.height * 0.01;
    final double titleSize = isTablet ? 24 : 18;
    final double bodySize = isTablet ? 18 : 14;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Card(
        elevation: 2.0,
        child: Container(
          color: Colors.white,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    width: screenSize.width * 0.24,
                    height: screenSize.height * 0.20,
                    // child: const Icon(
                    //   Icons.image,
                    //   size: 50,
                    // ),بيسي

                    child: Image.network(
                      image,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons
                          .image_not_supported_outlined), // يحافظ على نسب الأبعاد ويملأ المساحة المتاحة
                    )),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: verticalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.storeName,
                        style: Styles.textStyle24(context)
                            .copyWith(color: kPrimaryColorred),
                        // softWrap: true,
                        overflow: TextOverflow.visible,
                      ),
                      SizedBox(
                        height: spacing + 3,
                      ),

                      Text(":${product.name}",
                          style: Styles.textStyle20(context)
                              .copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(width: 16),
                      SizedBox(height: spacing),
                      // Text(
                      //   product.description,
                      //   style: Styles.textStyle20(context)
                      //       .copyWith(fontWeight: FontWeight.bold),
                      //   // softWrap: true,
                      //   overflow: TextOverflow.visible,
                      // ),
                      // SizedBox(height: spacing),
                      Text(
                        product.productCategory,
                        style: Styles.textStyle20(context)
                            .copyWith(fontWeight: FontWeight.bold),
                        // softWrap: true,
                        overflow: TextOverflow.visible,
                      ),
                      if (product.offerPrice > 0) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Flexible(
                              child: Text("ج${product.price}",
                                  style: Styles.textStyle20(context).copyWith(
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.lineThrough,
                                  )),
                            ),
                            Flexible(
                              child: Text(" ${product.offerPrice}ج",
                                  style: Styles.textStyle20(context)
                                      .copyWith(color: Colors.green)),
                            ),
                            Text(
                                textAlign: TextAlign.left,
                                " عرض خاص",
                                style: Styles.textStyle20(context)
                                    .copyWith(color: Colors.red)),
                          ],
                        ),
                      ] else ...[
                        Text(
                          "${product.price}ج",
                          style: Styles.textStyle20(context),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
