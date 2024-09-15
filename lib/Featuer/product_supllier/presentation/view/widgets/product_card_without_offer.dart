import 'package:cached_network_image/cached_network_image.dart';
import 'package:eghyptproject/Featuer/product_supllier/data/model/product_supllier_model.dart';
import 'package:eghyptproject/Featuer/product_supllier/presentation/manger/cubit/product_supllier_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCardWithoutOffer extends StatelessWidget {
  final ProductsWithOffer? productsWithoutOffer;

  const ProductCardWithoutOffer({
    super.key,
    this.productsWithoutOffer,
  });

  @override
  Widget build(BuildContext context) {
    final productId = productsWithoutOffer?.id;
    final imageUrl = productsWithoutOffer?.image.first;
    final name = productsWithoutOffer?.name;
    final description = productsWithoutOffer?.discription;
    final price = '${productsWithoutOffer?.price} جـ';

    return productsWithoutOffer != null
        ? SizedBox(
            height: 160,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              shadowColor: Colors.grey.shade100,
              elevation: 0,
              surfaceTintColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    CachedNetworkImage(
                      imageUrl: imageUrl!,
                      width: 100,
                      height: 100,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(
                          color: Colors.redAccent,
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Expanded(
                            child: Text(
                              name!,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Expanded(
                            child: Text(
                              description!,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ),
                          Text(
                            price,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(height: 5),
                          context
                                      .read<ProductSupplierCubit>()
                                      .checkStatusProductWithoutOffer(
                                          productsWithoutOffer!) ==
                                  -1
                              ? GestureDetector(
                                  onTap: () {
                                    context
                                        .read<ProductSupplierCubit>()
                                        .addProductWithoutOfferToCart(
                                            productsWithoutOffer!);
                                  },
                                  child: Container(
                                    height: 40,
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.blueAccent,
                                      borderRadius:
                                          BorderRadiusDirectional.circular(6),
                                    ),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 3),
                                        Text(
                                          'إضافة',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  height: 40,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          context
                                              .read<ProductSupplierCubit>()
                                              .addMoreProductWithoutOfferToCart(
                                                  productsWithoutOffer!);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: Colors.blueAccent,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: const Icon(
                                            Icons.add,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Text(
                                          '${context.read<ProductSupplierCubit>().productWithoutOfferCart['$productId']}',
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          context
                                              .read<ProductSupplierCubit>()
                                              .removeMoreProductWithoutOfferFromCart(
                                                  productsWithoutOffer!);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: Colors.redAccent,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: const Icon(
                                            Icons.remove,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        : const SizedBox(width: 0, height: 0);
  }
}
