import 'product_model.dart';

class CartItemModel {
  CartItemModel({
    required this.product,
    required this.quantity,
  });

  final ProductModel product;
  final int quantity;

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      product: ProductModel.fromJson(json['product']),
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'quantity': quantity,
    };
  }
}
