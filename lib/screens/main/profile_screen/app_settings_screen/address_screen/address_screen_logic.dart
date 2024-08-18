import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheber_market/models/user_address.dart';
import 'package:sheber_market/providers/user_addresses_provider.dart';

class AddressLogic extends ChangeNotifier{
  final BuildContext context;
  AddressLogic(this.context);

  List<UserAddress> addresses = [];
  UserAddress? selectedAddress;
  final TextEditingController cityController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController houseController = TextEditingController();
  final TextEditingController apartmentController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    cityController.dispose();
    streetController.dispose();
    houseController.dispose();
    apartmentController.dispose();
  }

  Future<void> loadUserAddresses() async {
    final provider = Provider.of<UserAddressProvider>(context, listen: false);
    await provider.loadUserAddresses();
    addresses = provider.userAddresses;

    selectedAddress = null;

    // Обновляем состояние
    notifyListeners();
  }

  void showAddressModal({UserAddress? address}) {
    if (address != null) {
      cityController.text = address.city;
      streetController.text = address.street;
      houseController.text = address.house;
      apartmentController.text = address.apartment;
    } else {
      cityController.clear();
      streetController.clear();
      houseController.clear();
      apartmentController.clear();
    }

    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        final theme = Theme.of(context);
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.025),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    address == null ? 'Добавить новый адрес' : 'Обновить адрес',
                    textAlign: TextAlign.left,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                  _buildTextFormField(cityController, 'Город'),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                  _buildTextFormField(streetController, 'Улица'),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                  _buildTextFormField(houseController, 'Дом'),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                  _buildTextFormField(apartmentController, 'Квартира'),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      if (address != null)
                        _buildButton(
                          Colors.grey,
                          'Удалить',
                          () {
                            deleteAddress(address.id);
                            Navigator.pop(context);
                          },
                        ),
                      _buildButton(
                        Colors.deepOrange,
                        address == null ? 'Сохранить' : 'Обновить',
                        () {
                          if (address == null) {
                            addAddress();
                          } else {
                            updateAddress(address.id);
                          }
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextFormField(TextEditingController controller, String label) {
    final theme = Theme.of(context);
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: theme.inputDecorationTheme.border,
        focusedBorder: theme.inputDecorationTheme.focusedBorder,
        enabledBorder: theme.inputDecorationTheme.enabledBorder,
        hintStyle: theme.inputDecorationTheme.hintStyle,
        labelStyle: theme.inputDecorationTheme.labelStyle,
      ),
    );
  }

  Widget _buildButton(Color color, String text, VoidCallback onPressed) {
    final theme = Theme.of(context);
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.05,
      width: MediaQuery.of(context).size.width * 0.4,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(text, style: theme.textTheme.bodyMedium),
      ),
    );
  }

  void addAddress() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    final newAddress = UserAddress(
      id: DateTime.now().millisecondsSinceEpoch, // Unique ID
      userId: userId, // Firebase UID
      city: cityController.text,
      street: streetController.text,
      house: houseController.text,
      apartment: apartmentController.text,
    );
    final provider = Provider.of<UserAddressProvider>(context, listen: false);
    await provider.addUserAddress(newAddress);
    await loadUserAddresses(); // Refresh addresses
  }

  void updateAddress(int id) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    final updatedAddress = UserAddress(
      id: id,
      userId: userId, // Firebase UID
      city: cityController.text,
      street: streetController.text,
      house: houseController.text,
      apartment: apartmentController.text,
    );
    final provider = Provider.of<UserAddressProvider>(context, listen: false);
    await provider.updateUserAddress(updatedAddress);
    await loadUserAddresses(); // Refresh addresses
  }

  void deleteAddress(int id) async {
    final provider = Provider.of<UserAddressProvider>(context, listen: false);
    await provider.deleteUserAddress(id);
    await loadUserAddresses(); // Refresh addresses
  }

  void updateSelectedAddress(UserAddress address, bool isSelected) {
    selectedAddress = isSelected ? address : null;
  }
}
