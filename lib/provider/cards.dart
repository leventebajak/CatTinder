import 'package:flutter/material.dart';

import '../data/disk/disliked_model.dart';
import '../data/disk/liked_model.dart';
import '../data/network/network_service.dart';

/// Provider for the cards.
class CardsProvider with ChangeNotifier {
  /// Number of cards.
  final int count;

  /// List of image ids.
  final List<String?> _ids;

  /// Model for liked images.
  final LikedModel likedModel;

  /// Model for disliked images.
  final DislikedModel dislikedModel;

  /// Index of the current card.
  int _currentIndex = 0;

  CardsProvider(
    this.count,
    this.likedModel,
    this.dislikedModel,
  ) : _ids = List<String?>.filled(count, null) {
    _initCards();
  }

  /// Fetches new image ids for all cards.
  void _initCards() async {
    for (var i = 0; i < _ids.length; i++) {
      final newImageId = await fetchId();
      setIdAt(i, newImageId);
    }
  }

  /// Gets the index of the current card.
  int get currentIndex => _currentIndex;

  /// Sets the [index] of the current card and notifies listeners.
  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  /// The id of the image at the [_currentIndex].
  String? get currentId => _ids[_currentIndex];

  /// Sets the id at the current index and notifies listeners.
  void setIdAt(int index, String? newId) {
    _ids[index] = newId;
    notifyListeners();
  }

  /// The id of the image at the given [index].
  String? getIdAt(int index) => _ids[index];

  /// Fetches a new image id.
  Future<String> fetchId() async {
    String newId;
    do {
      newId = await NetworkService.fetchRandomImageId();
    } while (_ids.contains(newId) ||
        likedModel.contains(newId) ||
        dislikedModel.contains(newId));
    return newId;
  }

  /// Updates the card at the [index].
  void updateAt(int index) async {
    setIdAt(index, null);
    final newId = await fetchId();
    setIdAt(index, newId);
  }
}
