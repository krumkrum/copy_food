part of 'shop_bloc.dart';



abstract class ShopState {}

class ShopInitial extends ShopState {}

class ShopLoaded extends ShopState {

  final List<ShopModel> shopList;

  double oneItemHeight = 0;

  void fillListPositionValues(double val) {
    if (oneItemHeight == 0) {
      oneItemHeight = val;
      shopList.asMap().forEach((key, value) {
        if (key == 0) {
          shopList[key].position = 0;
        } else {
          shopList[key].position = getShopListPosition(val, key);
        }
      });
    }
  }

  double getShopListPosition(double val, int index) =>
      val * (shopList[index].products.length / 2) +
          shopList[index - 1].position;

  ShopLoaded(this.shopList);
}


