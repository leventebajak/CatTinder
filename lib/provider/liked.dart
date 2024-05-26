import 'dart:collection' show UnmodifiableListView;

import 'package:cat_tinder/data/disk/liked_model.dart';
import 'package:flutter/material.dart';

/// Provider for the liked images.
class LikedProvider with ChangeNotifier {
  /// Model for liked images.
  final LikedModel _model;

  LikedProvider(this._model);

  /// Whether the liked images contain the given [imageId].
  bool contains(String imageId) => _model.contains(imageId);

  /// List of liked image ids.
  UnmodifiableListView<String> get ids => _model.ids;

  /// Adds the given [id] to the liked images.
  void add(String id) {
    _model.add(id);
    notifyListeners();
  }
}
