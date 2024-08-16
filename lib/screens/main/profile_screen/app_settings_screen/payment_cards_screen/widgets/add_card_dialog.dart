
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sheber_market/screens/main/profile_screen/app_settings_screen/payment_cards_screen/payment_cards_screen_logic.dart';
import 'package:sheber_market/screens/main/profile_screen/app_settings_screen/payment_cards_screen/widgets/card_number_formatter.dart';
import 'package:sheber_market/screens/main/profile_screen/app_settings_screen/payment_cards_screen/widgets/expyri_date_format.dart';
import 'package:sheber_market/screens/main/profile_screen/app_settings_screen/payment_cards_screen/widgets/uppercase_text_input.dart';

void showAddCardDialog(BuildContext context, PaymentCardsLogic logic) {
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cardHolderNameController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {
      final MediaQueryData mediaQueryData = MediaQuery.of(context);
      return Padding(
        padding: mediaQueryData.viewInsets,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Добавить новую карту',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: cardNumberController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(19),
                      CardNumberInputFormatter(),
                    ],
                    decoration: InputDecoration(
                      labelText: 'Номер карты',
                      border: Theme.of(context).inputDecorationTheme.border,
                      focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
                      enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: cardHolderNameController,
                    inputFormatters: [
                      UpperCaseTextInputFormatter(),
                    ],
                    decoration: InputDecoration(
                      labelText: 'Имя владельца',
                      border: Theme.of(context).inputDecorationTheme.border,
                      focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
                      enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: expiryDateController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(5),
                            ExpiryDateInputFormatter(),
                          ],
                          decoration: InputDecoration(
                            labelText: 'Срок действия',
                            border: Theme.of(context).inputDecorationTheme.border,
                            focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
                            enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: cvvController,
                          keyboardType: TextInputType.number,
                          obscureText: true,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(3),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: InputDecoration(
                            labelText: 'CVV',
                            border: Theme.of(context).inputDecorationTheme.border,
                            focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
                            enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                      onPressed: () async {
                        // Вызов метода добавления карты
                        await logic.addCard(
                          cardNumberController.text,
                          cardHolderNameController.text,
                          expiryDateController.text,
                          cvvController.text,
                        );

                        // Закрытие BottomSheet после завершения асинхронной операции
                        Navigator.of(context).pop();
                      },
                      child: const Text('Сохранить'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
