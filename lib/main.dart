import 'package:flutter/material.dart';
import 'package:profile_app/screens/authentification/password.dart';
import 'package:profile_app/screens/product/product_variations_screen.dart';
import 'screens/main_screen.dart';
import 'package:provider/provider.dart';
import 'services/favorites_service.dart';
import 'screens/shop/shop_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/search/search_screen.dart';
import 'screens/search/search_results_screen.dart';
import 'screens/flash_sale/flash_sale_live_screen.dart';
import 'screens/flash_sale/flash_sale_screen.dart';
import 'screens/wishlist/wishlist_screen.dart';
import 'screens/wishlist/wishlist_entry_point.dart';
import 'screens/wishlist/wishlist_empty_screen.dart';
import 'screens/cart/cart_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/authentification/login.dart';
import 'screens/authentification/registration.dart';
import 'screens/cart/cart_empty_shown_from_wishlist_screen.dart';
import 'screens/recently_viewed/recently_viewed_screen.dart';
import 'screens/recently_viewed/recently_viewed_date_screen.dart';
import 'screens/recently_viewed/recently_viewed_date_chosen_screen.dart';
import 'screens/product/product_sale_screen.dart';
import 'screens/product/product_full_screen.dart';
import 'screens/filter/categories_filter_screen.dart';
import 'screens/filter/filter_screen.dart';
import 'screens/payment/payment_screen.dart';
import 'screens/payment/add_voucher_screen.dart';
import 'screens/payment/voucher_added_screen.dart';
import 'screens/payment/choose_payment_method_screen.dart';
import 'screens/payment/payment_in_progress_screen.dart';
import 'screens/payment/couldnt_proceed_payment_screen.dart';
import 'screens/payment/successful_payment_screen.dart';
import 'screens/cart/edit_shipping_address_screen.dart';
import 'screens/reviews/reviews_screen.dart';
import 'screens/to_receive/to_receive.dart';
import 'screens/activity/my_activity.dart';
import 'screens/history/history.dart';
import 'package:firebase_core/firebase_core.dart';

bool isCartEmpty = false; // или true для теста
bool isWishlistEmpty = false; // или true для теста

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoritesService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/welcome',
      routes: {
        '/': (context) => const MainScreen(),
        '/welcome': (context) => const WelcomeScreen(),
        '/authorization': (context) => const RegistrationScreen(),
        '/login': (context) => const LoginScreen(),
        '/shop': (context) => const ShopScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/search': (context) => const SearchScreen(),
        '/searchResults': (context) => const SearchResultsScreen(),
        '/flashSaleLive': (context) => const FlashSaleLiveScreen(),
        '/flashSale': (context) => const FlashSaleScreen(),
        '/password': (context) => const PasswordScreen(),
        '/productVariations': (context) => const ProductVariationsScreen(),
        '/wishlist': (context) => const WishlistEntryPoint(),
        '/cart': (context) => isCartEmpty
            ? const CartEmptyShownFromWishlistScreen()
            : const CartScreen(),
        '/recentlyViewed': (context) => const RecentlyViewedScreen(),
        '/recentlyViewedDate': (context) => const RecentlyViewedDateScreen(),
        '/recentlyViewedDateChosen': (context) =>
            const RecentlyViewedDateChosenScreen(),
        '/productSale': (context) => const ProductSaleScreen(),
        '/productFull': (context) => const ProductFullScreen(),
        '/categoriesFilter': (context) => const CategoriesFilterScreen(),
        '/filter': (context) => const FilterScreen(),
        '/payment': (context) => const PaymentScreen(),
        '/addVoucher': (context) => const AddVoucherScreen(),
        '/voucherAdded': (context) => const VoucherAddedScreen(),
        '/choosePayment': (context) => const ChoosePaymentMethodScreen(),
        '/paymentInProgress': (context) =>
            const PaymentInProgressScreen(isSuccess: true),
        '/paymentFailed': (context) => const CouldntProceedPaymentScreen(),
        '/paymentSuccess': (context) => const SuccessfulPaymentScreen(),
        '/editShipping': (context) => const EditShippingAddressScreen(),
        '/reviews': (context) => const ReviewsScreen(),
        '/toReceive': (context) => const ToReceiveScreen(),
        '/myActivity': (context) => MyActivityPage(),
        '/orderHistory': (context) => const OrderHistoryScreen(),
      },
    );
  }
}
