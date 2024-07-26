import 'package:flutter/material.dart';
import 'package:sheber_market/models/user_address.dart';
import 'address_list_item.dart'; // Импортируем виджет элемента списка

class AddressList extends StatelessWidget {
  final List<UserAddress> addresses;
  final UserAddress? selectedAddress;
  final void Function(UserAddress, bool) onAddressSelected;
  final void Function(UserAddress) onAddressEdit;

  const AddressList({
    super.key,
    required this.addresses,
    required this.selectedAddress,
    required this.onAddressSelected,
    required this.onAddressEdit,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(color: Colors.white),
      itemCount: addresses.length,
      itemBuilder: (context, index) {
        final address = addresses[index];
        return AddressListItem(
          address: address,
          isSelected: selectedAddress == address,
          onAddressSelected: (isSelected) {
            onAddressSelected(address, isSelected!);
          },
          onAddressEdit: () {
            onAddressEdit(address);
          },
        );
      },
    );
  }
}
