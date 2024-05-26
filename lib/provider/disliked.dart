import 'dart:collection' show UnmodifiableListView;

import 'package:flutter/material.dart';

import '../data/disk/disliked_model.dart';

/// Provider for the disliked images.
class DislikedProvider with ChangeNotifier {
  /// Model for disliked images.
  final DislikedModel _model;

  DislikedProvider(this._model);

  /// Whether the disliked images contain the given [imageId].
  bool contains(String imageId) => _model.contains(imageId);

  /// List of disliked image ids.
  UnmodifiableListView<String> get ids => _model.ids;

  /// Adds the [id] to the disliked images.
  void add(String id) {
    _model.add(id);
    notifyListeners();
  }
}
