import 'dart:collection' show UnmodifiableListView;

import 'package:hive_flutter/hive_flutter.dart';

/// A model to manage disliked images.
class DislikedModel {
  /// The box to store the disliked image IDs in.
  final Box<List<String>> _box;

  DislikedModel(this._box);

  List<String> get _ids => _box.get('ids', defaultValue: []) ?? [];

  /// Checks if the [imageId] is in the disliked list.
  bool contains(String imageId) => _ids.contains(imageId);

  /// Adds the [id] to the disliked list.
  void add(String id) {
    final ids = _ids;
    ids.add(id);
    _box.put('ids', ids);
  }

  /// Provides an unmodifiable view of the disliked image IDs.
  UnmodifiableListView<String> get ids => UnmodifiableListView(_ids);
}