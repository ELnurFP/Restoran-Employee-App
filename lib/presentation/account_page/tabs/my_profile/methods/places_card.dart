import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/constants/constants.dart';
import 'package:template/presentation/account_page/tabs/my_profile/methods/select_place.dart';

import '../../../../../models/map_place_model.dart';
import 'map_button.dart';

InkWell placesCard(BuildContext context, String places, String isMain,
    ValueNotifier<List<MapPlacesModel>> selectedMap) {
  return InkWell(
    onTap: () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SelectPlace(
            mapList: selectedMap,
            isMain: isMain,
          ),
        ),
      );
    },
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              places,
              style: FontConst.font
                  .px14()
                  .w400()
                  .copyWith(color: ColorConst.softTextColor),
            ),
            mapButton(
              () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        SelectPlace(mapList: selectedMap, isMain: isMain),
                  ),
                );
              },
            )
          ],
        ),
        Divider(color: ColorConst.dviderColor, height: 1.h),
      ],
    ),
  );
}
