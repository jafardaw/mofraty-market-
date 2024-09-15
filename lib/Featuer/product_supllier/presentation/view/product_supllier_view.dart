import 'package:eghyptproject/Featuer/product_supllier/presentation/manger/cubit/product_supllier_cubit.dart';
import 'package:eghyptproject/Featuer/product_supllier/presentation/view/product_supllier_search_view.dart';
import 'package:eghyptproject/Featuer/product_supllier/presentation/view/widgets/product_card_with_offer.dart';
import 'package:eghyptproject/Featuer/product_supllier/presentation/view/widgets/product_card_without_offer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductSupllierView extends StatelessWidget {
  final num id;
  const ProductSupllierView({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    // return BlocProvider(
    // create: (context) => ProductSupplierCubit()
    //   ..loadProductSupplier()
    //   ..getProductWithOfferCart()
    //   ..getProductWithoutOfferCart(),
    // child:

    return SafeArea(
      child: ScaffoldMessenger(
        key: context.read<ProductSupplierCubit>().scaffoldMessengerState,
        child: BlocBuilder<ProductSupplierCubit, ProductSupplierState>(
          builder: (context, state) {
            return state is ProductSupplierLoaded
                ? DefaultTabController(
                    length:
                        state.productSupplierModel.productCategories.length + 1,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Scaffold(
                        bottomNavigationBar: SizedBox(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ProductSupllierView(id: id))),
                                  child: const Text('Page 1')),
                              const Text('Page 2'),
                            ],
                          ),
                        ),
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
                          bottom: TabBar(
                              isScrollable: true,
                              overlayColor: const WidgetStatePropertyAll(
                                  Colors.transparent),
                              labelColor: Colors.white,
                              dividerColor: Colors.white,
                              indicatorColor: Colors.white,
                              automaticIndicatorColorAdjustment: true,
                              unselectedLabelColor: Colors.white,
                              tabAlignment: TabAlignment.start,
                              tabs: [
                                const Tab(text: 'الكل'),
                                ...state.productSupplierModel.productCategories
                                    .map(
                                  (e) => Tab(text: e.name),
                                )
                              ]),
                          actions: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ProductSupllierSearchView(),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.search),
                            ),
                            IconButton(
                              onPressed: () => {},
                              icon: const Icon(Icons.notifications),
                            )
                          ],
                          leading: IconButton(
                              onPressed: () {},
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
                            TabBarView(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: CustomScrollView(
                                    slivers: [
                                      const SliverToBoxAdapter(
                                          child: SizedBox(height: 10)),
                                      SliverToBoxAdapter(
                                        child: SizedBox(
                                          height: state.productSupplierModel
                                                  .sliderOffers.isEmpty
                                              ? 0
                                              : 200,
                                          child: PageView.builder(
                                            itemCount: state
                                                .productSupplierModel
                                                .sliderOffers
                                                .length,
                                            itemBuilder: (context, index) =>
                                                Image.network(
                                              'https://backend.almowafraty.com/storage/${state.productSupplierModel.sliderOffers[index].image}',
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SliverToBoxAdapter(
                                          child: SizedBox(height: 20)),
                                      SliverToBoxAdapter(
                                        child: SizedBox(
                                          height: state.productSupplierModel
                                                  .productsWithOffer.isEmpty
                                              ? 0
                                              : 280,
                                          child: ListView.separated(
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) =>
                                                ProductCardWithOffer(
                                              productsWithOffer: state
                                                  .productSupplierModel
                                                  .productsWithOffer[index],
                                            ),
                                            separatorBuilder: (context, _) =>
                                                const SizedBox(width: 12),
                                            itemCount: state
                                                .productSupplierModel
                                                .productsWithOffer
                                                .length,
                                          ),
                                        ),
                                      ),
                                      const SliverToBoxAdapter(
                                          child: SizedBox(height: 20)),
                                      const SliverToBoxAdapter(
                                          child: Divider()),
                                      SliverList.separated(
                                        itemBuilder: (context, index) =>
                                            ProductCardWithoutOffer(
                                          productsWithoutOffer: state
                                              .productSupplierModel
                                              .productsWithoutOffer[index],
                                        ),
                                        separatorBuilder: (context, _) =>
                                            const Divider(),
                                        itemCount: state.productSupplierModel
                                            .productsWithoutOffer.length,
                                      ),
                                    ],
                                  ),
                                ),
                                for (var entry in context
                                    .read<ProductSupplierCubit>()
                                    .product
                                    .entries)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: CustomScrollView(
                                      slivers: [
                                        const SliverToBoxAdapter(
                                            child: SizedBox(height: 10)),
                                        SliverToBoxAdapter(
                                          child: SizedBox(
                                            height: state.productSupplierModel
                                                    .sliderOffers.isEmpty
                                                ? 0
                                                : 200,
                                            child: PageView.builder(
                                              itemCount: state
                                                  .productSupplierModel
                                                  .sliderOffers
                                                  .length,
                                              itemBuilder: (context, index) =>
                                                  Image.network(
                                                'https://backend.almowafraty.com/storage/${entry.value[index].image}',
                                                width: double.infinity,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SliverToBoxAdapter(
                                          child: SizedBox(
                                            height: entry.value
                                                    .where((element) =>
                                                        element.hasOffer == 1)
                                                    .toList()
                                                    .isEmpty
                                                ? 0
                                                : 280,
                                            child: ListView.separated(
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) =>
                                                  ProductCardWithOffer(
                                                productsWithOffer: entry
                                                            .value[index]
                                                            .hasOffer ==
                                                        1
                                                    ? entry.value[index]
                                                    : null,
                                              ),
                                              separatorBuilder: (context, _) =>
                                                  const SizedBox(width: 12),
                                              itemCount: entry.value
                                                  .map((e) => e.hasOffer != 0)
                                                  .length,
                                            ),
                                          ),
                                        ),
                                        SliverList.separated(
                                            itemBuilder: (context, index) =>
                                                ProductCardWithoutOffer(
                                                  productsWithoutOffer: entry
                                                              .value[index]
                                                              .hasOffer ==
                                                          0
                                                      ? entry.value[index]
                                                      : null,
                                                ),
                                            separatorBuilder: (context, _) =>
                                                const Divider(),
                                            itemCount: entry.value
                                                .map((e) => e.hasOffer == 0)
                                                .length),
                                      ],
                                    ),
                                  ),
                              ],
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
                              currentValue: context
                                  .read<ProductSupplierCubit>()
                                  .totalPrice,
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
                    ),
                  )
                : state is ProductSupplierError
                    ? Scaffold(body: Center(child: Text(state.message)))
                    : const Scaffold(
                        body: Center(child: CircularProgressIndicator()));
          },
        ),
      ),
    );
    // );
  }
}
