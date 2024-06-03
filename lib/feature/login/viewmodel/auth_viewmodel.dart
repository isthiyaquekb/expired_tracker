import 'package:expiry_track/core/local_db/local_database.dart';
import 'package:expiry_track/feature/login/model/user_model.dart';
import 'package:flutter/cupertino.dart';

class AuthViewModel extends ChangeNotifier{

  // void addPlace(String title, File selectedImage) {
  //   if (dbHelper.db != null) { // do not execute if db is not instantiate
  //     final newPlace = Place(
  //         id: DateTime.now().millisecondsSinceEpoch.toString(),
  //         title: title,
  //         location: null,
  //         image: selectedImage
  //     );
  //     _items.add(newPlace);
  //     notifyListeners();
  //     dbHelper.insert(tableName,
  //         {'id': newPlace.id, 'title': newPlace.title, 'image': newPlace.image.path});
  //   }
  // }

}