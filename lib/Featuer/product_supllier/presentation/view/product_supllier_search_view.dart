import 'package:eghyptproject/Featuer/product_supllier/presentation/manger/cubit/product_supllier_cubit.dart';
import 'package:eghyptproject/Featuer/product_supllier/presentation/view/widgets/product_card_with_offer.dart';
import 'package:eghyptproject/Featuer/product_supllier/presentation/view/widgets/product_card_without_offer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductSupllierSearchView extends StatelessWidget {
  const ProductSupllierSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ScaffoldMessenger(
        key: context.read<ProductSupplierCubit>().scaffoldSearchMessengerState,
        child: BlocBuilder<ProductSupplierCubit, ProductSupplierState>(
          builder: (context, state) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                appBar: AppBar(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.redAccent,
                  title: const Text(
                    'الأندلس للتجارة والتوزيع',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  centerTitle: true,
                  leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back)),
                ),
                floatingActionButton: FloatingActionButton(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.redAccent,
                  onPressed: () =>
                      context.read<ProductSupplierCubit>().buyProduct(),
                  child: const Icon(Icons.shopping_bag_outlined),
                ),
                body: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: CustomScrollView(
                        slivers: [
                          const SliverToBoxAdapter(child: SizedBox(height: 10)),
                          SliverToBoxAdapter(
                            child: TextFormField(
                              controller: context
                                  .read<ProductSupplierCubit>()
                                  .searchController,
                              cursorColor: Colors.redAccent.shade100,
                              autofocus: true,
                              onChanged: (name) => context
                                  .read<ProductSupplierCubit>()
                                  .searchForProducts(name),
                              decoration: InputDecoration(
                                label: const Text('بحث...'),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                hintStyle: const TextStyle(color: Colors.black),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                  vertical: 14.0,
                                ),
                                filled: true,
                                fillColor: Colors.white24,
                                prefixIcon: const Icon(Icons.search,
                                    color: Colors.black),
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.clear,
                                      color: Colors.black),
                                  onPressed: () {
                                    context
                                        .read<ProductSupplierCubit>()
                                        .searchForProducts('');
                                    context
                                        .read<ProductSupplierCubit>()
                                        .searchController
                                        .clear();
                                  },
                                ),
                              ),
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                          const SliverToBoxAdapter(child: SizedBox(height: 20)),
                          SliverToBoxAdapter(
                            child: SizedBox(
                              height: context
                                      .read<ProductSupplierCubit>()
                                      .productSearch
                                      .where((element) => element.hasOffer == 1)
                                      .toList()
                                      .isEmpty
                                  ? 0
                                  : 280,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) =>
                                    ProductCardWithOffer(
                                  productsWithOffer: context
                                              .read<ProductSupplierCubit>()
                                              .productSearch[index]
                                              .hasOffer ==
                                          1
                                      ? context
                                          .read<ProductSupplierCubit>()
                                          .productSearch[index]
                                      : null,
                                ),
                                separatorBuilder: (context, _) =>
                                    const SizedBox(width: 12),
                                itemCount: context
                                    .read<ProductSupplierCubit>()
                                    .productSearch
                                    .map((e) => e.hasOffer != 0)
                                    .length,
                              ),
                            ),
                          ),
                          SliverList.separated(
                              itemBuilder: (context, index) =>
                                  ProductCardWithoutOffer(
                                    productsWithoutOffer: context
                                                .read<ProductSupplierCubit>()
                                                .productSearch[index]
                                                .hasOffer ==
                                            0
                                        ? context
                                            .read<ProductSupplierCubit>()
                                            .productSearch[index]
                                        : null,
                                  ),
                              separatorBuilder: (context, _) => const Divider(),
                              itemCount: context
                                  .read<ProductSupplierCubit>()
                                  .productSearch
                                  .map((e) => e.hasOffer == 0)
                                  .length),
                        ],
                      ),
                    ),
                    FAProgressBar(
                      size: 75,
                      backgroundColor: Colors.redAccent.withOpacity(.3),
                      progressColor: Colors.redAccent,
                      maxValue: context
                              .read<ProductSupplierCubit>()
                              .productSupplierItems!
                              .supplier
                              .minBillPrice +
                          .0,
                      currentValue:
                          context.read<ProductSupplierCubit>().totalPrice,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'إجمالي الطلب: ${context.read<ProductSupplierCubit>().totalPrice} جـ',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'الحد الأدنى: ${context.read<ProductSupplierCubit>().productSupplierItems!.supplier.minBillPrice} جـ',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
