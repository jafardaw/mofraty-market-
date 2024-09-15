part of 'product_supllier_cubit.dart';

abstract class ProductSupplierState {}

class ProductSupplierInitial extends ProductSupplierState {}

class ProductSupplierLoading extends ProductSupplierState {}

class ProductSupplierLoaded extends ProductSupplierState {
  final ProductSupplierModelAA productSupplierModel;

  ProductSupplierLoaded({required this.productSupplierModel});
}

class ProductSupplierError extends ProductSupplierState {
  final String message;

  ProductSupplierError({required this.message});
}
