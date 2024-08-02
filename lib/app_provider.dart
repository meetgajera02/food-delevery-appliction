// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:foody/Model/product_model.dart';



class AppProvider with ChangeNotifier {
  //// Cart Work
  final List<ProductModel> _cartProductList = [];
  final List<ProductModel> _buyProductList = [];

  List<ProductModel> get getCartProductList => _cartProductList;
  List<ProductModel> get getFavouriteProductList => _favouriteProductList;

  void addCartProduct(ProductModel product) {
    _cartProductList.add(product);
    notifyListeners();
  }

  void removeCartProduct(ProductModel productModel) {
    _cartProductList.remove(productModel);
    notifyListeners();
  }

  void updateQty(ProductModel product, int qty) {
    int index = _cartProductList.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      _cartProductList[index] = product.copyWith(qty: qty);
      notifyListeners();
    }
  }

  ///// Favourite ///////
  final List<ProductModel> _favouriteProductList = [];

  void addFavouriteProduct(ProductModel productModel) {
    _favouriteProductList.add(productModel);
    notifyListeners();
  }

  void removeFavouriteProduct(ProductModel productModel) {
    _favouriteProductList.remove(productModel);
    notifyListeners();
  }

  //////// TOTAL PRICE / // / // / / // / / / // /

  double totalPrice() {
    double totalPrice = 0.0;
    for (var element in _cartProductList) {
      totalPrice += element.price * element.qty;
    }
    return totalPrice;
  }

  double totalPriceBuyProductList() {
    double totalPrice = 0.0;
    for (var element in _buyProductList) {
      totalPrice += element.price * element.qty;
    }
    return totalPrice;
  }
  ///////// BUY Product  / / // / / // / / / // /

  void addBuyProduct(ProductModel model) {
    _buyProductList.add(model);
    notifyListeners();
  }

  void addBuyProductCartList() {
    _buyProductList.addAll(_cartProductList);
    notifyListeners();
  }

  void clearCart() {
    _cartProductList.clear();
    notifyListeners();
  }

  void clearBuyProduct() {
    _buyProductList.clear();
    notifyListeners();
  }

  List<ProductModel> get getBuyProductList => _buyProductList;
}
