import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hba_management/core/routing/route_path.dart';
import 'package:hba_management/layers/view/hotel/widgets/hotel_item.dart';

import '../../data/model/hotel_model.dart';

class HotelsScreen extends StatefulWidget {
  const HotelsScreen({super.key});

  @override
  State<HotelsScreen> createState() => _HotelsScreenState();
}

class _HotelsScreenState extends State<HotelsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () =>
            Navigator.of(context).pushNamed(RoutePaths.CreateHotelScreen),
      ),
      body: AnimationLimiter(
        child: GridView.builder(
            key: PageStorageKey("hotels"),
            physics: const ScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 7,
                mainAxisSpacing: 7,
                mainAxisExtent: 320.0),
            itemCount: 0,
            itemBuilder: (context, index) {
              //HotelModel hotel = state.hotels[index];
              return AnimationConfiguration.staggeredGrid(
                position: index,
                columnCount: 2,
                duration: Duration(milliseconds: 500),
                child: SlideAnimation(
                  delay: Duration(milliseconds: 275),
                  child: SizedBox(),
                  // child: HotelItem(
                  //   onTapFavorite: () {
                  //     // setState(() {
                  //     //   features[index]["is_favorited"] =
                  //     //       !features[index]["is_favorited"];
                  //     // });
                  //   },
                  //   onTap: () {
                  //     // Navigator.push(
                  //     //   context,
                  //     //   MaterialPageRoute(
                  //     //     builder: (BuildContext context) => HotelDetailScreen(
                  //     //         hotelModel: state.hotels[index]),
                  //     //   ),
                  //     // );
                  //   },
                  //   hotelModel: state.hotels[index],
                  // )
                ),
              );
            }),
      ),
    );
  }
}
