// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:hand_car/core/extension/theme_extension.dart';
// import 'package:hand_car/features/Subscriptions/view/widgets/button_for_plan_selection_widget.dart';
// import 'package:hand_car/features/Subscriptions/view/widgets/duration_button_widget.dart';
// import 'package:hand_car/features/Subscriptions/view/widgets/plans_container_widget.dart';
// import 'package:hand_car/features/Subscriptions/view/widgets/popular_text_container_widegr.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// /// This is the Car Wash Subscription Page
// class CarWashPlanScreen extends HookConsumerWidget {
//   const CarWashPlanScreen({super.key});

//   @override
//   Widget build(BuildContext context, ref) {
//     final selectedIndex = useState(0);
//     final scrollController = useScrollController();
//     final selectedDurationIndex = useState(0);
    
//     // Plan Names
//     final planNames = ["Basic", "Premium", "Luxury"];
//     //Plan Prices
//     final planPrices = ["299", "599", "749"];
//     //Plan Features
//     final planFeatures = [
//       ["Unlimited Exterior wash", "Interior vacuuming", "Window cleaning"],
//       [
//         "All Basic Wash services",
//         "Full interior shampoo",
//         "Wax application",
//         "Tire dressing"
//       ],
//       [
//         "All Premium services",
//         "Engine compartment wash",
//         "High-definition waxing",
//         "Leather conditioning"
//       ]
//     ];

//     // Scroll to Plan
//     void scrollToPlan(int index) {
//       selectedIndex.value = index;
//       scrollController.animateTo(
//         index * 650.0,
//         duration: const Duration(milliseconds: 500),
//         curve: Curves.easeInOut,
//       );
//     }

//     return Scaffold(
//       extendBody: true,
//       body: SingleChildScrollView(
//         controller: scrollController,
//         child: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               colors: [
//                 Color(0xffD50104),
//                 Color(0xffffffff),
//                 Color(0xffD50104),
//                 Color(0xffffffff),
//               ],
//             ),
//           ),
//           child: SafeArea(
//             child: Padding(
//               padding: EdgeInsets.all(context.space.space_250),
//               child: Column(
//                 children: [
//                   Text(
//                     'A Plan for Every Car Washing Need',
//                     style: context.typography.h3
//                         .copyWith(color: context.colors.white),
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(height: context.space.space_150),
//                   Text(
//                     'Customized services to meet every car washing need with our specialized care.',
//                     style: TextStyle(color: context.colors.white),
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(height: context.space.space_250),
//                   // Duration Buttons
//                   DurationButtons(
//                     selectedIndex: selectedDurationIndex.value,
//                     onSelectPlan: (index) {
//                       selectedDurationIndex.value = index;
//                     },
//                     containerColor: Color(0xffFFD9D9),
//                     textColor1: Color(0xffDA1E21),
//                     textColor2: const Color(0xffE7696B),
//                   ),
//                   SizedBox(height: context.space.space_250),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       // Plan Selection Buttons
//                       PlanSelectionButtons(
//                         selectedIndex: selectedIndex.value,
//                         onSelectPlan: scrollToPlan,
//                         gradientColor: const LinearGradient(
//                             colors: [Color(0xffDA1E21), Color(0xffF77577)]),
//                         containerColor: const Color(0xffF5E1E1),
//                         textColor1: context.colors.white,
//                         textColor2: const Color(0xffBE6A6B),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: context.space.space_250),
//                   // Plans Container
//                   ListView.separated(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemCount: planNames.length,
//                     separatorBuilder: (context, index) =>
//                         SizedBox(height: context.space.space_250),
//                     itemBuilder: (context, index) {
//                       // Plans Container
//                       return PlansContainer(
//                         planName: planNames[index],
//                         price: planPrices[index],
//                         planFeature1: planFeatures[index][0],
//                         planFeature2: planFeatures[index][1],
//                         planFeature3: index > 0 ? planFeatures[index][2] : null,
//                         planFeature4:
//                             index == 2 ? planFeatures[index][3] : null,
//                         color: context.colors.green,
//                         containerColor: const Color(0xffF5E1E1),
//                         textColor1: context.colors.primary,
//                         textColor2: const Color(0xffE7696B),
//                         selectedDuration: selectedDurationIndex.value,
//                         child: index == 2
//                             ? const PopularTextConainerWidget()
//                             : null,
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:hand_car/features/Subscriptions/view/pages/base_plan_screen.dart';

class CarWashPlanScreen extends BasePlanScreen {
  const CarWashPlanScreen({super.key}) : super(serviceType: 'car_wash');

  @override
  String get screenTitle => 'A Plan for Every Car Washing Need';

  @override
  String get screenDescription =>
      'Customized services to meet every car washing need with our specialized care.';

  @override
  LinearGradient get backgroundGradient => const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xffD50104),
          Color(0xffffffff),
          Color(0xffD50104),
          Color(0xffffffff),
        ],
      );

  @override
  Color get primaryColor => const Color(0xffDA1E21);

  @override
  Color get secondaryColor => const Color(0xffE7696B);

  @override
  Color get containerColor => const Color(0xffFFD9D9);
}
