// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:hand_car/features/Authentication/model/auth_model.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// class RouterRefreshStream extends ChangeNotifier {
//   RouterRefreshStream(AsyncValue<AuthModel?> authState) {
//     _subscription = Stream.fromIterable([authState])
//         .listen((_) => notifyListeners());
//   }

//   late final StreamSubscription _subscription;

//   @override
//   void dispose() {
//     _subscription.cancel();
//     super.dispose();
//   }
// }