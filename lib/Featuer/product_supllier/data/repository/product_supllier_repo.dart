import 'package:eghyptproject/core/network/crud.dart';

import '../model/product_supllier_model.dart';

abstract class ProductSupplierRepo {
  Future getProductSupplier({required int id});
}

class ProductSupplierRepoImp extends ProductSupplierRepo {
  @override
  Future getProductSupplier({required num id}) async {
    try {
      final result = await Crud().get(
          url: 'https://backend.almowafraty.com/api/v1/markets/suppliers/$id');
      print(result);

      return ProductSupplierModelAA.fromJson(result);
    } catch (_) {
      return 'حدث خطأ ما';
    }
  }
}
