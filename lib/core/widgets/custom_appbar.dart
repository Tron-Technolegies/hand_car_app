// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:hand_car/core/extension/theme_extension.dart';
// import 'package:hand_car/core/widgets/search_bar_widget.dart';
// import 'package:hand_car/gen/assets.gen.dart';

// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final String title;
//   final bool showLeading;
//   final bool showActions;
//   final PreferredSizeWidget? bottom;
//   final GlobalKey<ScaffoldState>? scaffoldKey;

//   const CustomAppBar({
//     super.key,
//     required this.title,
//     this.showLeading = true,
//     this.showActions = true,
//     this.bottom,
//     this.scaffoldKey,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       leading: showLeading
//           ? Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: SvgPicture.asset(
//                 Assets.icons.handCarIcon,
//                 height: 30,
//                 width: 30,
//               ),
//             )
//           : null,
//       title: Text(
//         title,
//         style: context.typography.bodyLarge.copyWith(
//           color: context.colors.primaryTxt,
//         ),
//       ),
//       centerTitle: true,
//       actions: showActions
//           ? [
//               // Search Icon
//               IconButton(
//                 icon: Icon(Icons.search, color: context.colors.primaryTxt),
//                 onPressed: () {
                  
//                   showSearch(
//                       context: context, delegate: CustomSearchDelegate());
//                 },
//               ),
//               // Cart Icon
//               IconButton(
//                 icon: Icon(Icons.shopping_cart_outlined,
//                     color: context.colors.primaryTxt),
//                 onPressed: () {
                  
//                   Navigator.pushNamed(context, '/cart');
//                 },
//               ),
//               // Drawer Menu Icon
//               if (scaffoldKey != null)
//                 IconButton(
//                   icon: Icon(Icons.menu, color: context.colors.primaryTxt),
//                   onPressed: () {
//                     scaffoldKey!.currentState?.openDrawer();
//                   },
//                 ),
//             ]
//           : null,
//       backgroundColor: Colors.white,
//       elevation: 1,
//       shadowColor: context.colors.containerShadow,
//     );
//   }

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }
