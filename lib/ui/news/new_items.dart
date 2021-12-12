import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:your_fuel_app/models/new_model.dart';
import 'package:your_fuel_app/utils/app_utils.dart';

class NewsItem extends StatelessWidget {
  const NewsItem({Key? key, this.newsItem}) : super(key: key);

  final NewsModel? newsItem;

  @override
  Widget build(BuildContext context) {
    Color rdColor = listRandomColor[Random().nextInt(listRandomColor.length)];
    return (newsItem != null)
        ? Container(
            width: AppHelper.screenWidth(context),
            height: AppHelper.screenWidth(context),
            margin: const EdgeInsets.all(10),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 5,
              color: AppColors.blueLight,
              shadowColor: AppColors.blue,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      newsItem!.image,
                      fit: BoxFit.cover,
                      width: AppHelper.screenWidth(context),
                      height: AppHelper.screenWidth(context),
                    ),
                  ),
                  Container(
                    width: AppHelper.screenWidth(context),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: const LinearGradient(
                            colors: [
                              AppColors.halfTransparent,
                              AppColors.transparent
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter)),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          newsItem!.title,
                          style: TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                              shadows: [
                                Shadow(
                                    // bottomRight
                                    offset: const Offset(1.5, -1.5),
                                    color: rdColor),
                                Shadow(
                                    // topRight
                                    offset: const Offset(1.5, 1.5),
                                    color: rdColor),
                              ]),
                          maxLines: 3,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.network(
                                newsItem!.posterAvatar,
                                fit: BoxFit.cover,
                                width: 30,
                                height: 30,
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 3.0, right: 8),
                                child: Text(
                                  newsItem!.posterName,
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                  maxLines: 1,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Text(
                                newsItem!.time,
                                style: const TextStyle(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                                maxLines: 1,
                              ),
                            ),
                            const Expanded(
                              flex: 2,
                              child: Icon(
                                Icons.comment,
                                color: AppColors.white,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                newsItem!.totalComment.toString(),
                                style: const TextStyle(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15),
                                maxLines: 1,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: SvgPicture.asset(
                                'assets/icons/icon_heart_red.svg',
                                width: 30.0,
                                height: 30.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        : Container();
  }
}
