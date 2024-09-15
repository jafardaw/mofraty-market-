import 'dart:convert';

ProductSupplierModelAA productSupplierModelFromJson(String str) =>
    ProductSupplierModelAA.fromJson(json.decode(str));

String productSupplierModelToJson(ProductSupplierModelAA data) =>
    json.encode(data.toJson());

class ProductSupplierModelAA {
  final Supplier supplier;
  final List<ProductCategory> productCategories;
  final List<SliderOffer> sliderOffers;
  final List<ProductsWithOffer> productsWithOffer;
  final List<ProductsWithOffer> productsWithoutOffer;

  ProductSupplierModelAA({
    required this.supplier,
    required this.productCategories,
    required this.sliderOffers,
    required this.productsWithOffer,
    required this.productsWithoutOffer,
  });

  factory ProductSupplierModelAA.fromJson(Map<String, dynamic> json) =>
      ProductSupplierModelAA(
        supplier: Supplier.fromJson(json["supplier"]),
        productCategories: List<ProductCategory>.from(
            json["product_categories"].map((x) => ProductCategory.fromJson(x))),
        sliderOffers: List<SliderOffer>.from(
            json["slider_offers"].map((x) => SliderOffer.fromJson(x))),
        productsWithOffer: List<ProductsWithOffer>.from(
            json["products_with_offer"]
                .map((x) => ProductsWithOffer.fromJson(x))),
        productsWithoutOffer: List<ProductsWithOffer>.from(
            json["products_without_offer"]
                .map((x) => ProductsWithOffer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "supplier": supplier.toJson(),
        "product_categories":
            List<dynamic>.from(productCategories.map((x) => x.toJson())),
        "slider_offers":
            List<dynamic>.from(sliderOffers.map((x) => x.toJson())),
        "products_with_offer":
            List<dynamic>.from(productsWithOffer.map((x) => x.toJson())),
        "products_without_offer":
            List<dynamic>.from(productsWithoutOffer.map((x) => x.toJson())),
      };
}

class ProductCategory {
  final int id;
  final String name;

  ProductCategory({
    required this.id,
    required this.name,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) =>
      ProductCategory(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class ProductsWithOffer {
  final int id;
  final int userId;
  final int productCategoryId;
  final String name;
  final String discription;
  final int size;
  final String sizeOf;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int price;
  final int maxSellingQuantity;
  final int hasOffer;
  final int offerPrice;
  final int maxOfferQuantity;
  final DateTime offerExpiresAt;
  final List<String> image;
  final String productCategory;

  ProductsWithOffer({
    required this.id,
    required this.userId,
    required this.productCategoryId,
    required this.name,
    required this.discription,
    required this.size,
    required this.sizeOf,
    required this.createdAt,
    required this.updatedAt,
    required this.price,
    required this.maxSellingQuantity,
    required this.hasOffer,
    required this.offerPrice,
    required this.maxOfferQuantity,
    required this.offerExpiresAt,
    required this.image,
    required this.productCategory,
  });

  factory ProductsWithOffer.fromJson(Map<String, dynamic> json) =>
      ProductsWithOffer(
        id: json["id"],
        userId: json["user_id"],
        productCategoryId: json["product_category_id"],
        name: json["name"],
        discription: json["discription"],
        size: json["size"],
        sizeOf: json["size_of"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        price: json["price"],
        maxSellingQuantity: json["max_selling_quantity"],
        hasOffer: json["has_offer"],
        offerPrice: json["offer_price"],
        maxOfferQuantity: json["max_offer_quantity"],
        offerExpiresAt: DateTime.parse(json["offer_expires_at"]),
        image: List<String>.from(json["image"].map((x) => x)),
        productCategory: json["product_category"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "product_category_id": productCategoryId,
        "name": name,
        "discription": discription,
        "size": size,
        "size_of": sizeOf,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "price": price,
        "max_selling_quantity": maxSellingQuantity,
        "has_offer": hasOffer,
        "offer_price": offerPrice,
        "max_offer_quantity": maxOfferQuantity,
        "offer_expires_at":
            "${offerExpiresAt.year.toString().padLeft(4, '0')}-${offerExpiresAt.month.toString().padLeft(2, '0')}-${offerExpiresAt.day.toString().padLeft(2, '0')}",
        "image": List<dynamic>.from(image.map((x) => x)),
        "product_category": productCategory,
      };
}

class SliderOffer {
  final int id;
  final int supplierId;
  final String image;
  final String supplierName;

  SliderOffer({
    required this.id,
    required this.supplierId,
    required this.image,
    required this.supplierName,
  });

  factory SliderOffer.fromJson(Map<String, dynamic> json) => SliderOffer(
        id: json["id"],
        supplierId: json["supplier_id"],
        image: json["image"],
        supplierName: json["supplier_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "supplier_id": supplierId,
        "image": image,
        "supplier_name": supplierName,
      };
}

class Supplier {
  final int id;
  final int supplierCategoryId;
  final int cityId;
  final String locationDetails;
  final String firstName;
  final String middleName;
  final String lastName;
  final String storeName;
  final String phoneNumber;
  final String deviceToken;
  final dynamic minBillPrice;
  final int minSellingQuantity;
  final String deliveryDuration;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String image;

  Supplier({
    required this.id,
    required this.supplierCategoryId,
    required this.cityId,
    required this.locationDetails,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.storeName,
    required this.phoneNumber,
    required this.deviceToken,
    required this.minBillPrice,
    required this.minSellingQuantity,
    required this.deliveryDuration,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.image,
  });

  factory Supplier.fromJson(Map<String, dynamic> json) => Supplier(
        id: json["id"],
        supplierCategoryId: json["supplier_category_id"],
        cityId: json["city_id"],
        locationDetails: json["location_details"],
        firstName: json["first_name"],
        middleName: json["middle_name"],
        lastName: json["last_name"],
        storeName: json["store_name"],
        phoneNumber: json["phone_number"],
        deviceToken: json["deviceToken"],
        minBillPrice: json["min_bill_price"],
        minSellingQuantity: json["min_selling_quantity"],
        deliveryDuration: json["delivery_duration"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "supplier_category_id": supplierCategoryId,
        "city_id": cityId,
        "location_details": locationDetails,
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
        "store_name": storeName,
        "phone_number": phoneNumber,
        "deviceToken": deviceToken,
        "min_bill_price": minBillPrice,
        "min_selling_quantity": minSellingQuantity,
        "delivery_duration": deliveryDuration,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "image": image,
      };
}
