
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/Home/view/widgets/carousel_slider_widget.dart';
import 'package:hand_car/features/Home/view/widgets/container_for_home_page.dart';
import 'package:hand_car/features/Home/view/widgets/drawer_widget.dart';
import 'package:hand_car/features/Home/view/widgets/product_search_container_widget.dart';
import 'package:hand_car/gen/assets.gen.dart';

class HomePage extends StatelessWidget {
  
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SvgPicture.asset(Assets.icons.handCarIcon),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.shopping_cart_sharp)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> const DrawerWidget()),);

          }, icon: const Icon(Icons.menu)),
        ],

      ),
      drawer: const DrawerWidget(),
      endDrawerEnableOpenDragGesture: true,
      body: SingleChildScrollView(
        child: Column(
        
          children: [
            SizedBox(height: context.space.space_200,),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: context.space.space_200,vertical: context.space.space_100),
              child: const ProductSearchContainerWidget(
              
              ),
            ),
        
            SizedBox(height: context.space.space_200,),
          const CarouselSliderWidget(),
          SizedBox(height: context.space.space_200,),
         const ContainerForHomePage(text1: "Explore Best car Accessories  ", text2: "From Top Brands", text3: "View Products", image: "assets/images/accessories.png",),
          SizedBox(height: context.space.space_100,),
          const ContainerForHomePage(text1: 'Find best and cost effective',text2: 'Find Service',text3: "Find Service",image: 'assets/images/car.png',),
          SizedBox(height: context.space.space_100,),
           const ContainerForHomePage(text1: 'Find best in quality car spare',text2: 'Parts',text3: "Enquire Now",image: 'assets/images/spare_parts.png',),
          SizedBox(height: context.space.space_100,),
          
          ]
        ),
        

      ),
     
    );
  }
}