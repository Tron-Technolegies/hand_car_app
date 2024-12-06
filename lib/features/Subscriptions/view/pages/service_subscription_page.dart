// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:hand_car/core/extension/theme_extension.dart';
// import 'package:hand_car/features/Subscriptions/view/widgets/duration_button_widget.dart';
// import 'package:hand_car/features/Subscriptions/view/widgets/popular_text_container_widegr.dart';
// import 'package:hand_car/features/Subscriptions/view/widgets/button_for_plan_selection_widget.dart';
// import 'package:hand_car/features/Subscriptions/view/widgets/plans_container_widget.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// class ServicePlanScreen extends HookConsumerWidget {
//   static const String route = '/service_plans';
//   const ServicePlanScreen({super.key});

//   @override
//   Widget build(BuildContext context, ref) {
//     final selectedIndex = useState(0);
//     final selectedDurationIndex =
//         useState(0); // 0 for '6 Months', 1 for '12 Months'
//     final scrollController = useScrollController();

//     // Plan Names
//     final planNames = ["Basic", "Premium", "Luxury"];
//     // Plan Prices
//     final planPrices = ["299", "599", "749"];
//     // Plan Features
//     final planFeatures = [
//       [
//         "Unlimited synthetic oil changes",
//         "Seasonal tire rotations",
//         "Priority scheduling"
//       ],
//       [
//         "All Basic Maintenance Plan services",
//         "Brake pad replacements",
//         "Battery check and replacement",
//         "Fluid top-offs"
//       ],
//       [
//         "All Premium Maintenance Plan services",
//         "Monthly diagnostics",
//         "24/7 roadside assistance",
//         "Complimentary detailing twice a year"
//       ]
//     ];

//     // Scroll to Plan
//     void scrollToPlan(int index) {
//       selectedIndex.value = index;
//       scrollController.animateTo(
//         index * 650.0, // Adjust height as needed
//         duration: const Duration(milliseconds: 500),
//         curve: Curves.easeInOut,
//       );
//     }

//     return Scaffold(
//       extendBody: true,
//       body: SingleChildScrollView(
//         controller: scrollController,
//         child: Container(
//           padding: EdgeInsets.all(context.space.space_200),
//           child: Column(
//             children: [
//               // Header Section
//               Text(
//                 'Plans for Maintenance Services',
//                 style: context.typography.h3,
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: context.space.space_100),
//               Text(
//                 'Explore our subscription plans for additional services and keep your car looking its best year-round. Enjoy exclusive benefits and regular maintenance with our comprehensive packages.',
//                 style: context.typography.bodyMedium
//                     .copyWith(color: context.colors.primaryTxt),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: context.space.space_150),

//               // Duration Buttons
//               DurationButtons(
//                 selectedIndex: selectedDurationIndex.value,
//                 onSelectPlan: (index) {
//                   selectedDurationIndex.value = index;
//                 },
//                 containerColor: context.colors.background,
//                 textColor1: context.colors.primaryTxt,
//                 textColor2: const Color(0xff787878),
//               ),
//               SizedBox(height: context.space.space_150),

//               // Plan Selection Buttons
//               PlanSelectionButtons(
//                 selectedIndex: selectedIndex.value,
//                 onSelectPlan: scrollToPlan,
//                 gradientColor: const LinearGradient(
//                   colors: [Color(0xff000000), Color(0xff787878)],
//                 ),
//                 textColor1: Colors.white,
//                 textColor2: const Color(0xff787878),
//                 containerColor: context.colors.background,
//               ),
//               SizedBox(height: context.space.space_250),

//               // Plan Details List (avoid nested scrolling)
//               Column(
//                 children: List.generate(planNames.length, (index) {
//                   return PlansContainer(
//                     planName: planNames[index],
//                     price: planPrices[index],
//                     planFeature1: planFeatures[index][0],
//                     planFeature2: planFeatures[index][1],
//                     planFeature3: index > 0 ? planFeatures[index][2] : null,
//                     planFeature4: index == 2 ? planFeatures[index][3] : null,
//                     color: context.colors.primaryTxt,
//                     containerColor: context.colors.background,
//                     textColor1: context.colors.primaryTxt,
//                     textColor2: const Color(0xff787878),
//                     selectedDuration: selectedDurationIndex.value,
//                     child:
//                         index == 2 ? const PopularTextConainerWidget() : null,
//                   );
//                 }),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:hand_car/features/Subscriptions/view/pages/base_plan_screen.dart';

class MaintenancePlanScreen extends BasePlanScreen {
  const MaintenancePlanScreen({super.key}) : super(serviceType: 'maintenance');

  @override
  String get screenTitle => 'Plans for Maintenance Services';

  @override
  String get screenDescription =>
      'Explore our subscription plans for additional services and keep your car looking its best year-round.';

  @override
  LinearGradient get backgroundGradient => const LinearGradient(
        colors: [Color(0xff000000), Color(0xff787878)],
      );

  @override
  Color get primaryColor => Colors.black;

  @override
  Color get secondaryColor => const Color(0xff787878);

  @override
  Color get containerColor => const Color(0xffF5F5F5);

  @override
  ///  implement durationButtonColor
  Color get durationButtonColor => Color(0xffEEEEEE);

  @override
  //implement durationButtonTextColor1
  Color get durationButtonTextColor1 => Colors.black;

  @override
  //  implement durationButtonTextColor2
  Color get durationButtonTextColor2 => const Color(0xff787878);
}
