import 'dart:developer';

import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:expiry_track/core/local_db/local_database.dart';
import 'package:expiry_track/core/services/local_notification_services.dart';
import 'package:expiry_track/feature/home/model/product_model.dart';
import 'package:expiry_track/feature/inventory/model/inventory_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class HomeViewModel extends ChangeNotifier {
  var selectedCategoryIndex = 0;
  var selectedPopularIndex = 0;
  var dayLeft = 0;
  var productList = <InventoryModel>[];
  var productFilteredList = <InventoryModel>[];
  var easyDateController=EasyInfiniteDateTimelineController();
  var focusDate = DateTime.now();
  var pickedDate="";
  var dateFromDB="";

  List<InventoryModel> get getProductList => productList;

  void listenToNotification(){

  }
  void setCategory(int index) {
    selectedCategoryIndex = index;
    log("CATEGORY TAP INDEX:$index");
    notifyListeners();
  }

  void setSelectedDate(DateTime selectedDate){
    focusDate = selectedDate;
    pickedDate=DateFormat('dd-MMM-yyyy').format(
        selectedDate);
    // for (var element in productList) {
    //   dateFromDB=DateFormat('dd-MMM-yyyy').format(
    //       DateTime.parse(element.expiryDate));
    //   if(productList.contains(dateFromDB)){
    //
    //   }
    // }
    productFilteredList = productList.where((o) => DateFormat('dd-MMM-yyyy').format(DateTime.parse(o.expiryDate)) == pickedDate).toList();
    print("SELECT TIME DATE:$selectedDate");
    print("TIME DATE:${productFilteredList.length}");
    notifyListeners();
  }

  //GET ALL PRODUCT FROM DB
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
    var myDateTime=DateFormat("HH:mm").format(DateTime.parse(data.expiryDate
    ));
    print("DATE TIME IN HOURS AND MINUTE:${myDateTime}");
    LocalNotificationServices.showScheduleNotification(int.parse(myDateTime.split(":")[0]), int.parse(myDateTime.split(":")[1]), data.productName, data.expiryDate, data.daysLeft.toString());
  }


}