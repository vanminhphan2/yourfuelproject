import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:your_fuel_app/utils/app_utils.dart';

class StoreFeature extends StatelessWidget {
  const StoreFeature({Key? key, this.icon,this.name}) : super(key: key);

  final String? icon;
  final String? name;

  @override
  Widget build(BuildContext context) {
    return
      Column(
        children: [
          SizedBox(width: AppHelper.screenWidth(context)*0.25,
            height: AppHelper.screenWidth(context)*0.25,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13.0),
              ),
              elevation: 5,
              color: AppColors.pink,
              shadowColor: AppColors.blue,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SvgPicture.asset(
                    icon??""
                ),
              ),
            ),
          ),
          SizedBox(height: 3,),
          Text(
            name ?? "",
            style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color: AppColors.white),
          )
        ],
      );
  }
}
