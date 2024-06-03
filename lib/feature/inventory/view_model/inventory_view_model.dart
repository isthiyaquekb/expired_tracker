import 'dart:convert';

import 'package:expiry_track/core/local_db/local_database.dart';
import 'package:expiry_track/feature/home/viewmodel/home_viewmodel.dart';
import 'package:expiry_track/feature/inventory/model/inventory_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class InventoryViewModel extends ChangeNotifier {

  late LocalDatabase localDatabase;
  final barcodeController = TextEditingController();
  final nameController = TextEditingController();
  final dateController = TextEditingController();
  final quantityController = TextEditingController();
  final batchNoController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  var currentDate = DateTime.now();
  var dayLeft = 0;
  var nowDate = "";
  var selectedDate = "";


  void setBarCode(String barcode) {
    barcodeController.text = barcode;
    //calculateDaysRemaining("12/05/2024" as DateTime,DateTime.now());
    notifyListeners();
  }

  ///NAME VALIDATOR
  String? nameValidator(String value) {
    if (value.isEmpty) {
      return 'Please enter a name.';
    }
    return null;
  }

  ///DATE VALIDATOR
  String? dateValidator(String value) {
    if (value.isEmpty) {
      return 'Please enter a date.';
    }
    return null;
  }

  String? batchValidator(String value) {
    if (value.isEmpty) {
      return 'This field cannot be empty.';
    }
    return null;
  }

  void onSelectingDate() {
    print("PRINTING SELECTED DATE:${dateController.text}");
    final inputFormat = DateFormat("dd/MM/yyyy");
    // Parse the date string with the correct format
    DateTime parsedDate = inputFormat.parse(dateController.text);
    DateTime tempDate =
        DateFormat("yyyy-MM-dd hh:mm:ss").parse(parsedDate.toString());
    print("PRINTING FORMATTED DATE:$tempDate");
  }

  void pickDate(BuildContext context) async {
    var pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2040));
    if (pickedDate != null && pickedDate != currentDate) {
      currentDate = pickedDate;
    }

    nowDate = DateFormat('yyyy-MM-dd').format(currentDate).toString();

    selectedDate = DateFormat('dd/MM/yyyy').format(currentDate);
    calculateDaysRemaining(pickedDate!, DateTime.now());
    print("CURRENT DATE SELECTED :$selectedDate");

    notifyListeners();
  }

  void submit() {
    if (formKey.currentState!.validate()) {
      print("BARCODE NUMBER:${barcodeController.text}");
      print("PRODUCT NAME:${nameController.text}");
      print("QUANTITY NAME:${quantityController.text}");
      print("DATE EXPIRY:$currentDate");
      print("DAY LEFT:$dayLeft");
      print("BATCH EXPIRY:${batchNoController.text}");
      var data = InventoryModel(
          barcode: int.parse(barcodeController.text),
          productName: nameController.text,
          expiryDate: currentDate.toString(),
          batchNo: batchNoController.text,
          quantity: int.parse(quantityController.text),daysLeft: dayLeft);

      LocalDatabase.insertProduct(data);

      print("JSON TO DB:${jsonEncode(data.toMap())}");
    }
  }

  void calculateDaysRemaining(DateTime from, DateTime to) {
    var fromDate = DateTime(from.year, from.month, from.day);
    var toDate = DateTime(to.year, to.month, to.day);
    dayLeft = (fromDate.difference(toDate).inHours / 24).round();

    print("Calculated DATE IS $dayLeft");
  }

  void getAllProductFromDB() async {
    var productList=await LocalDatabase.queryAllProducts();

    notifyListeners();
    print("Product List invent $productList");
  }
}
