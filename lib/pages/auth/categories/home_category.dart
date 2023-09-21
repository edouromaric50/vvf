import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:testproject/components/app_image.dart';
import 'package:testproject/components/app_text.dart';
import 'package:testproject/controllers/category_controller.dart';
import 'package:testproject/models/category_model.dart';
import 'package:testproject/pages/auth/categories/add_category.dart';
import 'package:testproject/utils/app_const.dart';
import 'package:testproject/utils/app_func.dart';

class HomeCategory extends ConsumerStatefulWidget {
  const HomeCategory({super.key});

  @override
  HomeCategoryState createState() => HomeCategoryState();
}

class HomeCategoryState extends ConsumerState<HomeCategory>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 5, vsync: this);
    controller.addListener(() {
      log("Move to tab ${controller.index}");
      changerPeriode(controller.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    double hCard = 0.50 * getSize(context).height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.catgColor,
        title: AppText(
          "Dépense en Restauration",
          color: AppColor.white,
          size: 18,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        height: getSize(context).height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // histogram of caisse
            Container(
              width: getSize(context).width,
              height: hCard - 40,
              child: Stack(
                children: [
                  Container(
                    width: getSize(context).width,
                    height: 100,
                    decoration: const BoxDecoration(
                        color: AppColor.catgColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(48),
                          bottomRight: Radius.circular(48),
                        )),
                  ),
                  Positioned(
                      left: 0,
                      right: 0,
                      child: Column(
                        children: [
                          const AppText(
                            "100000 €",
                            color: Colors.white,
                            size: 35,
                            weight: FontWeight.bold,
                          ),
                          const SpacerHeight(),
                          Container(
                            height: hCard - 100,
                            width: getSize(context).width,
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(28),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 2),
                              ],
                            ),
                            child: buildHistograms(),
                          ),
                        ],
                      ))
                ],
              ),
            ),

            // Categories  List

            Expanded(
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.2), blurRadius: 2),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //List catégories
                    Expanded(
                        child: SingleChildScrollView(
                      child: ref.watch(getAllCats).when(
                          data: (data) {
                            log(data);
                            return Wrap(
                              children: data.map((e) => singleCat(e)).toList(),
                            );
                          },
                          error: errorLoading,
                          loading: loadingError),
                    )),

                    Divider(),
                    Center(
                      child: IconButton(
                          onPressed: () {
                            navigateToWidget(context, AddCategory());
                          },
                          icon: const Icon(
                            Icons.add_circle_outline_rounded,
                            size: 40,
                            color: AppColor.catgColor,
                          )),
                    ),
                    const SpacerHeight(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildHistograms() {
    final List<double> data = [18, 45];
    controller.addListener(() {
      log("Move to tab ${controller.index}");
    });

    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          TabBar(
            tabs: const [
              Tab(
                text: "Jour",
              ),
              Tab(
                text: "Semaine",
              ),
              Tab(
                text: "Mois",
              ),
              Tab(
                text: "Année",
              ),
              Tab(
                text: "Période",
              ),
            ],
            controller: controller,
            labelColor: Colors.black,
          ),
          AppText("Aujourd'hui xxxx/xx/xx"),
          Expanded(
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.center,
                barTouchData: BarTouchData(enabled: false),

                //gridData: const FlGridData(show: false),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: ((d, data) {
                        log(d);
                        if (d == 0) {
                          return AppText("Principal");
                        }
                        return AppText("Entreprise");
                      }),
                    ),
                  ),
                  // leftTitles: Null,
                  //rightTitles: Null,
                ),

                borderData: FlBorderData(
                  show: false,
                  // border: Border.all(
                  //   color: const Color(0xff37434d),
                  //   width: 1,
                  // ),
                ),
                barGroups: data
                    .asMap()
                    .map((index, value) => MapEntry(
                          index,
                          BarChartGroupData(
                            x: index,
                            barRods: [
                              BarChartRodData(
                                  toY: value.toDouble(),
                                  color: index == 1 ? Colors.red : Colors.green,
                                  width: 40,
                                  borderRadius: BorderRadius.circular(2)),
                            ],
                          ),
                        ))
                    .values
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void changerPeriode(int index) {}

  Widget singleCat(Category e) {
    return Container(
      width: 60,
      height: 60,
      margin: const EdgeInsets.all(8),
      child: CircleAvatar(
        backgroundColor: Color.fromARGB(e.colorA, e.colorR, e.colorG, e.colorB),
        child: Icon(
          IconData(
            e.iconData,
            fontFamily: "MaterialIcons",
          ),
          color: Colors.white,
          size: 38,
        ),
      ),
    );
  }
}
