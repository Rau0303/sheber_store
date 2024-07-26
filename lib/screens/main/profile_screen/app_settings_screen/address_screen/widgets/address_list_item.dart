import 'package:flutter/material.dart';
import 'package:sheber_market/models/user_address.dart';

class AddressListItem extends StatelessWidget {
  final UserAddress address;
  final bool isSelected;
  final void Function(bool?)? onAddressSelected;
  final VoidCallback onAddressEdit;

  const AddressListItem({
    super.key,
    required this.address,
    required this.isSelected,
    required this.onAddressSelected,
    required this.onAddressEdit,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: isSelected,
        onChanged: onAddressSelected,
        activeColor: Colors.deepOrange,
      ),
      title: Text(address.street ?? 'Не указана улица'),
      subtitle: Text('Дом ${address.house ?? 'Не указан дом'}'),
      trailing: IconButton(
        onPressed: onAddressEdit,
        icon: const Icon(Icons.edit),
      ),
    );
  }
}
