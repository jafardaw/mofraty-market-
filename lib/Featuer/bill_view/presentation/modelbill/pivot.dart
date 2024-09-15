// class Pivot {
//   num? billId;
//   num? productId;
//   num? quantity;

//   Pivot({this.billId, this.productId, this.quantity});

//   factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
//         billId: num.tryParse(json['bill_id'].toString()),
//         productId: num.tryParse(json['product_id'].toString()),
//         quantity: num.tryParse(json['quantity'].toString()),
//       );

//   Map<String, dynamic> toJson() => {
//         if (billId != null) 'bill_id': billId,
//         if (productId != null) 'product_id': productId,
//         if (quantity != null) 'quantity': quantity,
//       };
// }

class Pivot {
  num? billId;
  num? productId;
  num? quantity;
  num? supplierId;
  num price;
  bool? hasOffer;
  num offerPrice;
  num? maxOfferQuantity;
  String? offerExpiresAt;
  num? maxSellingQuantity;
  bool? isAvailable;

  Pivot({
    this.billId,
    this.productId,
    this.quantity,
    this.supplierId,
    required this.price,
    this.hasOffer,
    required this.offerPrice,
    this.maxOfferQuantity,
    this.offerExpiresAt,
    this.maxSellingQuantity,
    this.isAvailable,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        billId: num.tryParse(json['bill_id']?.toString() ?? ''),
        productId: num.tryParse(json['product_id']?.toString() ?? ''),
        quantity: num.tryParse(json['quantity']?.toString() ?? ''),
        supplierId: num.tryParse(json['supplier_id']?.toString() ?? ''),
        // price: num.tryParse(json['buying_price']?.toString() ?? ''),
        price: num.tryParse(json['buying_price']?.toString() ?? '') ?? 0,
        hasOffer: json['has_offer'] == 1,
        offerPrice:
            num.tryParse(json['offer_buying_price']?.toString() ?? '') ?? 0,
        maxOfferQuantity:
            num.tryParse(json['max_offer_quantity']?.toString() ?? ''),
        offerExpiresAt: json['offer_expires_at'],
        maxSellingQuantity:
            num.tryParse(json['max_selling_quantity']?.toString() ?? ''),
        isAvailable: json['is_available'] == 1,
      );

  Map<String, dynamic> toJson() => {
        if (billId != null) 'bill_id': billId,
        if (productId != null) 'product_id': productId,
        if (quantity != null) 'quantity': quantity,
        if (supplierId != null) 'supplier_id': supplierId,
        'price': price,
        if (hasOffer != null) 'has_offer': hasOffer! ? 1 : 0,
        'offer_price': offerPrice,
        if (maxOfferQuantity != null) 'max_offer_quantity': maxOfferQuantity,
        if (offerExpiresAt != null) 'offer_expires_at': offerExpiresAt,
        if (maxSellingQuantity != null)
          'max_selling_quantity': maxSellingQuantity,
        if (isAvailable != null) 'is_available': isAvailable! ? 1 : 0,
      };
}
