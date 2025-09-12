import 'package:flutter/material.dart';
import 'package:foodapp/address/model/address_model.dart';

class DefaultAddressResult {
  final AddressModel? address;
  final bool isLoading;
  final String? error;
  final VoidCallback refetch;

  DefaultAddressResult({
    required this.address,
    required this.isLoading,
    required this.error,
    required this.refetch,
  });
}
