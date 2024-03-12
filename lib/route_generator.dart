import 'package:testban/screens/Splash.dart';
import 'package:testban/screens/balance_inquiry_page.dart';
import 'package:testban/screens/deposit_page.dart';
import 'package:testban/screens/error_page.dart';
import 'package:testban/screens/loan_payment.dart';
import 'package:testban/screens/login_page.dart';
import 'package:testban/screens/main_page.dart';
import 'package:testban/screens/passcode_reset_page.dart';
import 'package:testban/screens/service_page.dart';
import 'package:testban/screens/settings_page.dart';
import 'package:testban/screens/topup_page.dart';
import 'package:testban/screens/transaction_page.dart';
import 'package:testban/screens/withdraw_page.dart';
import 'package:flutter/material.dart';

import 'screens/widgets/transactions_widget.dart';
// import 'package:provider/provider.dart';

// import 'models/user.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      // if (args is String) {
      //   return MaterialPageRoute(
      //       builder: (_) => MainPage(
      //           // uid: args,
      //           ));
      // }
      // return MaterialPageRoute(
      //   builder: (_) => ErrorPage(),
      // );
      case '/':
        return MaterialPageRoute(
            builder: (_) => Splash(
                // uid: args,
                ));
      case '/home':
        return MaterialPageRoute(
            builder: (_) => MainPage(
                // uid: args,
                ));
      case '/login':
        return MaterialPageRoute(builder: (_) {
          // User user = Provider.of<User>(context);
          return LoginPage();
        });

      case '/settings':
        return MaterialPageRoute(builder: (_) {
          return SettingsPage();
        });

      case '/service':
        return MaterialPageRoute(builder: (_) {
          return ServicePage();
        });

      case '/withdraw':
        return MaterialPageRoute(builder: (_) {
          return WithdrawalPage();
        });

      case '/deposit':
        return MaterialPageRoute(builder: (_) {
          return DepositPage();
        });

      case '/transaction':
        return MaterialPageRoute(builder: (_) {
          //return TransactionPage();
        });
      case '/transaction_details':
        return MaterialPageRoute(builder: (_) {
          // return TransactionsWidget();
        });
      case '/topup':
        return MaterialPageRoute(builder: (_) {
          return AirtimePurchasePage();
        });
      case '/payloan':
        return MaterialPageRoute(builder: (_) {
          return PayLoanPage();
        });

      case '/balanceinquiry':
        return MaterialPageRoute(builder: (_) {
          return BalanceInquiryPage();
        });
      case '/passcodereset':
        return MaterialPageRoute(builder: (_) {
          return PasscodeResetPage();
        });
      default:
        return MaterialPageRoute(
          builder: (_) => LoginPage(),
        );
    }
  }
}
