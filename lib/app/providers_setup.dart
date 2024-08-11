import 'package:provider/provider.dart';
import 'package:sheber_market/providers/auth_provider.dart';
import 'package:sheber_market/providers/cart_provider.dart';
import 'package:sheber_market/providers/category_provider.dart';
import 'package:sheber_market/providers/favorite_provider.dart';
import 'package:sheber_market/providers/firebase_push_notification_provider.dart';
import 'package:sheber_market/providers/product_provider.dart';
import 'package:sheber_market/providers/user_addresses_provider.dart';
import 'package:sheber_market/providers/user_bank_card_provider.dart';
import 'package:sheber_market/screens/main/basket_screen/basket_screen_logic.dart';
import 'package:sheber_market/screens/main/category_screen/category_screen_logic.dart';
import 'package:sheber_market/screens/main/favorite_screen/favorites_screen_logic.dart';
import 'package:sheber_market/screens/main/home_screen/home_screen_logic.dart';
import 'package:sheber_market/screens/main/profile_screen/profile_screen/profile_screen_logic.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> getProviders() {
  return [
    ChangeNotifierProvider(create: (_) => FirebasePushNotificationProvider()),
    ChangeNotifierProvider(create: (_) => UserBankCardProvider()),
    ChangeNotifierProvider(create: (_) => UserAddressProvider()),
    ChangeNotifierProvider(create: (_) => FavoriteProvider()),
    ChangeNotifierProvider(create: (_) => CategoryProvider()), // Добавляем CategoryProvider
    ChangeNotifierProvider(create: (_) => ProductProvider()),  // Добавляем ProductProvider
    ChangeNotifierProxyProvider3<FavoriteProvider, CategoryProvider, ProductProvider, HomeScreenLogic>(
      create: (context) {
        final favoriteProvider = Provider.of<FavoriteProvider>(context, listen: false);
        final categoryProvider = Provider.of<CategoryProvider>(context, listen: false);
        final productProvider = Provider.of<ProductProvider>(context, listen: false);

        return HomeScreenLogic(favoriteProvider, categoryProvider, productProvider);
      },
      update: (context, favoriteProvider, categoryProvider, productProvider, previousLogic) {
        return HomeScreenLogic(favoriteProvider, categoryProvider, productProvider);
      },
    ),
    ChangeNotifierProvider(create: (_) => CategoryScreenLogic()),
    ChangeNotifierProvider(create: (_) => BasketLogic(_)),
    ChangeNotifierProvider(create: (context) => FavoritesLogic(context)),
    ChangeNotifierProvider(create: (context) => ProfileScreenLogic()),
    ChangeNotifierProvider(create: (_) => AuthProvider()),
    ChangeNotifierProvider(create: (_) => CartProvider()),
    // Добавьте другие провайдеры здесь, если нужно
  ];
}
