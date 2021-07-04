//import 'dart:io';
import 'dart:math';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sell/models/place.dart';
import 'package:sell/utils/db_util.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];
  
  Future<void> loadPlaces() async{
    final dataList = await DbUtil.getData('products');
    _items = dataList.map(
      (item) => Place(
        id: item['id'],
        title: item['title'],
        image: File(item['image']),
        description: item['description'],
        price: item['price'],
        location: null,

      ),
    ).toList();
  notifyListeners();

  }

  List<Place> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Place itemByIndex(int index) {
    return _items[index];
  }
/*
String description = null;
  final double price;
*/
  void addPlace(String title, File image, String description, String price){
      final newPlace = Place(
      id: Random().nextDouble().toString(),
      title: title,
      image: image,
      location:null,
      description: description,
      price: price,
      );

      _items.add(newPlace);
      DbUtil.inset('products', {
        'id': newPlace.id,
        'title': newPlace.title,
        'image': newPlace.image.path,
        'description': newPlace.description,
        'price': newPlace.price,
      });
      notifyListeners();
    }
  
  }
  

/*
  Future<void> loadPlaces() async {
    
    final dataList = await DbUtil.getData('places');
    _items = dataList
        .map(
          (item) => Place(
            id: item['id'],
            title: item['title'],
            image: File(item['image']),
            location: PlaceLocation(
              latitude: item['latitude'],
              longitude: item['longitude'],
              address: item['address'],
            ),
          ),
        )
        .toList();
    notifyListeners();
  }

  List<Place> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Place itemByIndex(int index) {
    return _items[index];
  }

  Future<void> addPlace(
    String title,
    File image,
    LatLng position,
  ) async {
    String address = await LocationUtil.getAddressFrom(position);

    final newPlace = Place(
      id: Random().nextDouble().toString(),
      title: title,
      image: image,
      location: PlaceLocation(
        latitude: position.latitude,
        longitude: position.longitude,
        address: address,
      ),
    );

    _items.add(newPlace);
    DbUtil.insert('places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'latitude': position.latitude,
      'longitude': position.longitude,
      'address': address,
    });
    notifyListeners();
  }*/

