import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_front/handler/api_request_handler.dart';

abstract class MainNotifier<T> extends StateNotifier<T> {
  final ApiRequestHandler apiRequestHandler;

  MainNotifier(T state, this.apiRequestHandler) : super(state);

  /// Fetch data for a specific field
  Future<void> fetchField(String fieldName) async {
    try {
      final response = await apiRequestHandler.get('/fetch_field/$fieldName');
      if (response?.statusCode == 200) {
        final data = jsonDecode(response!.body);
        updateField(fieldName, data[fieldName]);
      }
    } catch (e) {
      print('Error fetching field $fieldName: $e');
    }
  }

  /// Update a specific field - To be implemented in derived classes
  void updateField(String fieldName, dynamic value);
}

