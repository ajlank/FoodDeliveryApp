import 'package:flutter/material.dart';
import 'package:foodapp/address/model/address_model.dart';

class AddressListResult {
  final List<AddressModel> addressList;
  final bool isLoading;
  final String? error;
  final VoidCallback refetch;

  AddressListResult({
    required this.addressList,
    required this.isLoading,
    required this.error,
    required this.refetch,
  });
}
