import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheber_market/providers/user_addresses_provider.dart';
import 'package:sheber_market/screens/main/profile_screen/app_settings_screen/address_screen/widgets/address_list.dart';
import 'package:sheber_market/widgets/add_app_bar.dart';
import 'address_screen_logic.dart';

class AddressScreen extends StatefulWidget {
  static String route() => '/address-settings';
  
  final bool isSelectionMode; // Новый параметр

  const AddressScreen({super.key, this.isSelectionMode = false}); // По умолчанию false

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  late AddressLogic addressLogic;

  @override
  void initState() {
    super.initState();
    addressLogic = AddressLogic(context);
    addressLogic.loadUserAddresses();
  }

  @override
  void dispose() {
    addressLogic.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AddAppBar(onActionPressed: () {
        addressLogic.showAddressModal();
      }, text: 'Мои адреса'),
      body: Consumer<UserAddressProvider>(
        builder: (context, userAddressProvider, child) {
          addressLogic.addresses = userAddressProvider.userAddresses;
          return Padding(
            padding: const EdgeInsets.all(10),
            child: AddressList(
              addresses: addressLogic.addresses,
              selectedAddress: addressLogic.selectedAddress,
              onAddressSelected: (address, isSelected) {
                addressLogic.updateSelectedAddress(address, isSelected);
                if (isSelected && widget.isSelectionMode) {
                  Navigator.pop(context, address);
                  print('Selected address from AddressScreen: $address');
                }
              },
              onAddressEdit: (address) {
                addressLogic.showAddressModal(address: address);
              },
            ),
          );
        },
      ),
    );
  }
}
