import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/models/kyc/upload_model.dart';

class DashboardModel {
  final bool isLoading;

  DashboardModel({
    this.isLoading = false,
  });

  @override
  DashboardModel copyWith({
    bool? isLoading,
  }) {
    return DashboardModel(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
