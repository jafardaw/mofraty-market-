import 'package:eghyptproject/Featuer/bill_view/presentation/modelbill/product.dart';
import 'package:eghyptproject/Featuer/bill_view/presentation/modelbill/supplier.dart';
import 'package:eghyptproject/Featuer/cart_edit/presentaotion/view/widget/quantity_selector_edit.dart';
import 'package:eghyptproject/core/styles.dart';
import 'package:flutter/material.dart';

class CartItemEdit extends StatelessWidget {
  final VoidCallback onDelete;
  final Function(num)? onQuantityChanged;
  final ProductBill bill;
  final Supplier? supplier;
  // final ProductBill? pivot;
  final num? quantity;
  final String image;
  const CartItemEdit({
    super.key,
    required this.onDelete,
    this.onQuantityChanged,
    required this.bill,
    required this.supplier,
    // required this.pivot,
    required this.quantity,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    double screenWidth = MediaQuery.of(context).size.width;

    // You can define your breakpoints and adjust sizes accordingly
    double imageWidth = screenWidth > 600 ? 120 : 100;
    double imageHeight = screenWidth > 600 ? 180 : 150;
    double paddingAllSides = screenWidth > 600 ? 16 : 8;
    double spaceBetweenItems = screenWidth > 600 ? 12 : 8;

    return Padding(
      padding: const EdgeInsets.all(2),
      child: Card(
        child: Container(
          color: Colors.white,
          child: Row(
            children: [
              Image.network(
                image,
                height: imageHeight,
                width: imageWidth,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.image_not_supported_outlined),
              ),
              Expanded(
                child: ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${bill.name}', style: Styles.textStyle20(context)),
                      Text(
                        '${bill.discription}',
                        style: Styles.textStyle20(context),
                      ),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: spaceBetweenItems),
                      if (bill.pivot!.hasOffer == true) ...[
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                "${bill.pivot!.price}ج",
                                style: Styles.textStyle18(context),
                              ),
                            ),
                            SizedBox(width: spaceBetweenItems),
                            Flexible(
                              child: Text(
                                "${bill.pivot!.offerPrice}ج",
                                style: Styles.textStyle18(context)
                                    .copyWith(color: Colors.green),
                              ),
                            ),
                            SizedBox(width: spaceBetweenItems),
                            Text(
                              "عرض خاص",
                              style: Styles.textStyle18(context).copyWith(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ] else ...[
                        Text(
                          "${bill.pivot!.price}ج",
                          style: Styles.textStyle18(context),
                        ),
                      ],
                      SizedBox(height: spaceBetweenItems),
                      QuantitySelectorEdit(
                        initialValue: quantity ?? 1,
                        onChanged: (newQuantity) {
                          if (onQuantityChanged != null) {
                            onQuantityChanged!(newQuantity);
                          }
                        },
                        maxSellingQuantity: supplier!.minSellingQuantity,
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: onDelete,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
