import 'dart:developer';

import 'package:expiry_track/core/local_db/local_database.dart';
import 'package:expiry_track/feature/home/model/product_model.dart';
import 'package:expiry_track/feature/inventory/model/inventory_model.dart';
import 'package:flutter/cupertino.dart';

class HomeViewModel extends ChangeNotifier {
  var selectedCategoryIndex = 0;
  var selectedPopularIndex = 0;
  var dayLeft = 0;
  var productList = <InventoryModel>[];

  List<InventoryModel> get getProductList => productList;

  void setCategory(int index) {
    selectedCategoryIndex = index;
    log("CATEGORY TAP INDEX:$index");
    notifyListeners();
  }

  void getAllProductFromDB() async {
    var dataList = await LocalDatabase.queryAllProducts();
    productList.clear();
    for (var element in dataList!) {
      var data = InventoryModel.fromMap(element);
      calculateDaysRemaining(DateTime.parse(data.expiryDate), DateTime.now(),data);
    }
    print("Product List home view $productList");
    notifyListeners();
  }


  void calculateDaysRemaining(DateTime from, DateTime to, InventoryModel data,) {
    var fromDate = DateTime(from.year, from.month, from.day);
    var toDate = DateTime(to.year, to.month, to.day);
    dayLeft = (fromDate
        .difference(toDate)
        .inHours / 24).round();
    var inventoryData=InventoryModel(barcode: data.barcode,
        productName: data.productName,
        expiryDate: data.expiryDate,
        batchNo: data.batchNo,
        quantity: data.quantity,
        daysLeft: dayLeft);
    productList.add(inventoryData);
    print("HOW MANY DAYS LEFT IS $dayLeft");
  }


}