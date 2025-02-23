// import 'package:flutter/material.dart';

// import '../helpers/post_login.dart';

// class SubscriptionProvider with ChangeNotifier {
//   bool _isSubscribed = false;

//   // Getters

//   bool get isSubscribed => _isSubscribed;

//   // Setters and update methods
//   void updateSubscriptionStatus({
//     required bool isSubscribed,
//   }) {
//     if (_isSubscribed != isSubscribed) {
//       _isSubscribed = isSubscribed;

//       notifyListeners();
//       performPostLoginActions();
//     }
//   }

//   void clearSubscriptionData() {
//     _isSubscribed = false;
//     notifyListeners();
//   }
// }
