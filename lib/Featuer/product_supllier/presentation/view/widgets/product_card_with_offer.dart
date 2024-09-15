import 'package:cached_network_image/cached_network_image.dart';
import 'package:eghyptproject/Featuer/product_supllier/data/model/product_supllier_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../manger/cubit/product_supllier_cubit.dart';

class ProductCardWithOffer extends StatelessWidget {
  final ProductsWithOffer? productsWithOffer;

  const ProductCardWithOffer({
    super.key,
    this.productsWithOffer,
  });

  @override
  Widget build(BuildContext context) {
    final productId = productsWithOffer?.id;
    final imageUrl = productsWithOffer?.image.first;
    final name = productsWithOffer?.name;
    final description = productsWithOffer?.discription;
    final price = '${productsWithOffer?.price} جـ';
    final newPrice = '${productsWithOffer?.offerPrice} جـ';

    return productsWithOffer != null
        ? SizedBox(
            width: 180,
            child: Card(
              shadowColor: Colors.grey.shade100,
              elevation: 6,
              surfaceTintColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
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
                    const SizedBox(height: 10),
                    Text(
                      name!,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      description!,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    const SizedBox(height: 5),
                    FittedBox(
                      child: Row(
                        children: [
                          Text(
                            newPrice,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            price,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              decorationColor: Colors.grey.shade500,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade400,
                            ),
                          ),
                          const SizedBox(width: 15),
                          Container(
                            padding: const EdgeInsets.all(2),
                            color: Colors.greenAccent.shade700,
                            child: const Text(
                              'عرض خاص',
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    context
                                .read<ProductSupplierCubit>()
                                .checkStatusProductWithOffer(
                                    productsWithOffer!) ==
                            -1
                        ? GestureDetector(
                            onTap: () {
                              context
                                  .read<ProductSupplierCubit>()
                                  .addProductWithOfferToCart(
                                      productsWithOffer!);
                            },
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius:
                                    BorderRadiusDirectional.circular(6),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    context
                                        .read<ProductSupplierCubit>()
                                        .addMoreProductWithOfferToCart(
                                            productsWithOffer!);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Colors.blueAccent,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    '${context.read<ProductSupplierCubit>().productWithOfferCart['$productId']}',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    context
                                        .read<ProductSupplierCubit>()
                                        .removeMoreProductWithOfferFromCart(
                                            productsWithOffer!);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Colors.redAccent,
                                      borderRadius: BorderRadius.circular(8),
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
                  ],
                ),
              ),
            ),
          )
        : const SizedBox(height: 0, width: 0);
  }
}
