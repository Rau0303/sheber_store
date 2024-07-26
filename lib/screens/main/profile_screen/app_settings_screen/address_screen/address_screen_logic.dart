import 'package:flutter/material.dart';
import 'package:sheber_market/models/user_address.dart';


class AddressLogic {
  final BuildContext context;
  AddressLogic(this.context);

  List<UserAddress> addresses = [];
  UserAddress? selectedAddress;
  final TextEditingController cityController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController houseController = TextEditingController();
  final TextEditingController apartmentController = TextEditingController();

  void dispose() {
    cityController.dispose();
    streetController.dispose();
    houseController.dispose();
    apartmentController.dispose();
  }

  Future<void> loadUserAddresses() async {
    // Здесь должен быть код для загрузки адресов
    // Например:
    // addresses = await fetchAddresses();
    // if (selectedAddress == null && addresses.isNotEmpty) {
    //   selectedAddress = addresses.last;
    // }
  }

  void showAddressModal({UserAddress? address}) {
    if (address != null) {
      cityController.text = address.city;
      streetController.text = address.street ?? '';
      houseController.text = address.house ?? '';
      apartmentController.text = address.apartment ?? '';
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
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
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
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
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
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildButton(Color color, String text, VoidCallback onPressed) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.05,
      width: MediaQuery.of(context).size.width * 0.4,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(color),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }

  void addAddress() {
    final newAddress = UserAddress(
      id: DateTime.now().millisecondsSinceEpoch, // Используйте уникальный идентификатор
      userId: 1, // Пример userId, замените на актуальное значение
      city: cityController.text,
      street: streetController.text,
      house: houseController.text,
      apartment: apartmentController.text,
    );
    addresses.add(newAddress);
  }

  void updateAddress(int id) {
    final index = addresses.indexWhere((address) => address.id == id);
    if (index != -1) {
      addresses[index] = UserAddress(
        id: id,
        userId: addresses[index].userId,
        city: cityController.text,
        street: streetController.text,
        house: houseController.text,
        apartment: apartmentController.text,
      );
    }
  }

  void deleteAddress(int id) {
    addresses.removeWhere((address) => address.id == id);
  }

  void updateSelectedAddress(UserAddress address, bool isSelected) {
    selectedAddress = isSelected ? address : null;
  }
}
