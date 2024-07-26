import 'package:flutter/material.dart';
import 'package:sheber_market/screens/main/profile_screen/app_settings_screen/address_screen/widgets/address_list.dart';
import 'address_screen_logic.dart';

class AddressScreen extends StatefulWidget {
  static String route() => '/address-settings';
  const AddressScreen({super.key});

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
      appBar: AppBar(
        title: const Text('Мои адреса'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              addressLogic.showAddressModal();
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: AddressList(
          addresses: addressLogic.addresses,
          selectedAddress: addressLogic.selectedAddress,
          onAddressSelected: (address, isSelected) {
            addressLogic.updateSelectedAddress(address, isSelected);
          },
          onAddressEdit: (address) {
            addressLogic.showAddressModal(address: address);
          },
        ),
      ),
    );
  }
}
