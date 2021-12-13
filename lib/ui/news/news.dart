import 'package:flutter/material.dart';
import 'package:your_fuel_app/models/new_model.dart';
import 'package:your_fuel_app/models/staff.dart';
import 'package:your_fuel_app/ui/news/new_items.dart';
import 'package:your_fuel_app/utils/app_utils.dart';

class News extends StatefulWidget {
  const News({Key? key}) : super(key: key);

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> with AutomaticKeepAliveClientMixin {
  List<NewsModel> newsList = [];

  @override
  void initState() {
    newsList.add(NewsModel(
        1,
        22,
        "tran huynh tuan",
        "https://phunugioi.com/wp-content/uploads/2020/01/anh-avatar-supreme-dep-lam-dai-dien-facebook.jpg",
        "Dự đoán giá dầu tăng mạnh!!!",
        "https://f.thuongtruong.com.vn/IMAGES/2021/11/07/20211107070720-123209_010120-dau.jpg",
        "hôm nay",
        356));
    newsList.add(NewsModel(
        1,
        22,
        "Nguyễn Long",
        "https://i.pinimg.com/564x/76/37/ae/7637ae514349007d88a16c2d87dde927.jpg",
        "Hiện đại có hại điện?",
        "https://sc04.alicdn.com/kf/HTB1VjyEqH9YBuNjy0Fgq6AxcXXaZ.jpg",
        "1 tháng",
        356));
    newsList.add(NewsModel(
        1,
        22,
        "tran thanh hai",
        "https://bloganh.net/wp-content/uploads/2021/03/chup-anh-dep-anh-sang-min.jpg",
        "Thị trường xăng dầu bất ổn!",
        "https://businesstech.co.za/news/wp-content/uploads/2021/11/Petrol-1.jpg",
        "3 giờ",
        23));
    newsList.add(NewsModel(
        1,
        22,
        "tran huynh tuan",
        "https://anhdephd.com/wp-content/uploads/2019/10/anh-dai-dien-avatar-dep-facebook.jpg",
        "Chỉnh kê số liệu như thế nào là chuẩn?",
        "https://images.news18.com/ibnlive/uploads/2021/07/1626839139_petrol-image-3.jpg?im=FitAndFill,width=1200,height=675",
        "30p",
        57));
    newsList.add(NewsModel(
        1,
        22,
        "Rio Phan",
        "https://taimienphi.vn/tmp/cf/aut/hinh-dep-2.jpg",
        "Hướng dẫn đổ xăng dầu cho nhân viên mới.",
        "https://www.thesun.co.uk/wp-content/uploads/2021/11/NINTCHDBPICT000506294261.jpg",
        "22/10/1997",
        87));
    newsList.add(NewsModel(
        1,
        22,
        "Tú Nguyễn",
        "https://bloganh.net/wp-content/uploads/2021/03/chup-anh-dep-anh-sang-min.jpg",
        "Cảnh báo rò rĩ xăng dầu khi sử dụng!!",
        "https://www.dailyexcelsior.com/wp-content/uploads/2021/02/PETROL.png",
        "hôm qua",
        113));
    newsList.add(NewsModel(
        1,
        22,
        "Trần Thế Hổ",
        "https://bloganh.net/wp-content/uploads/2021/03/chup-anh-dep-anh-sang-min.jpg",
        "Có nên đầu tư cửa hàng xăng dầu?",
        "https://web.uta.com/fileadmin/user_upload/images/solutions/solution-drivers-stationfinder-petrolstation.jpg",
        "19/08/2022",
        79));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [AppColors.white, AppColors.pinkLightPurple],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter),
              ),
            ),
            Stack(
              children: [
                ListView.builder(
                    padding: EdgeInsets.only(top: 70, bottom: 80),
                    itemCount: newsList.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {},
                        child: NewsItem(
                          newsItem: newsList[index],
                        ),
                      );
                    }),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          "https://1.bp.blogspot.com/-n_bFzL9lPUU/Xp23H9Sk8yI/AAAAAAAAhyA/JYfvZhwguxc8vT_YS3w14Xi3YWf3hxqIQCLcBGAsYHQ/s1600/Hinh-Anh-Dep-Tren-Mang%2B%25282%2529.jpg",
                          fit: BoxFit.cover,
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(top: 10, left: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: AppColors.backgroundText,
                            borderRadius: BorderRadius.circular(15)),
                        child: const Text(
                          "New post here...",
                          style: TextStyle(color: AppColors.hintTextColors),
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      margin:
                          const EdgeInsets.only(top: 10, right: 10, left: 10),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.search,
                        color: AppColors.blueLight,
                        size: 40,
                      ),
                    )
                  ],
                ),
              ],
            )
          ],
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
