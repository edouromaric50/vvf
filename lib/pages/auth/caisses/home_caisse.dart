import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testproject/components/app_image.dart';
// import 'package:testproject/components/app_image.dart';
import 'package:testproject/components/app_text.dart';
import 'package:testproject/controllers/caisse_controller.dart';
import 'package:testproject/controllers/category_controller.dart';
import 'package:testproject/models/caisse_model.dart';
import 'package:testproject/models/category_model.dart';
import 'package:testproject/pages/auth/caisses/add_caisse.dart';
import 'package:testproject/pages/auth/categories/add_category.dart';
import 'package:testproject/utils/app_const.dart';
import 'package:testproject/utils/app_func.dart';

class HomeCaisse extends ConsumerStatefulWidget {
  const HomeCaisse({super.key});

  @override
  HomeCaisseState createState() => HomeCaisseState();
}

class HomeCaisseState extends ConsumerState<HomeCaisse>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  var currentCaisseIndex = 0;
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
        backgroundColor: AppColor.caisseColor,
        title: AppText(
          "CAISSE PRINCIPALE ",
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
          children: [
            Expanded(
              child: SingleChildScrollView(
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
                                color: AppColor.caisseColor,
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
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(28),
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.2),
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

                    // translation  List

                    Container(
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //List translatiion
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Liste des caisses
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.2), blurRadius: 2),
                ],
              ),
              child: ref.watch(getMyCaisses).when(
                  data: (data) {
                    return SingleChildScrollView(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //List caisse

                          for (var i = 0; i < data.length; i++)
                            buildCaisse(data[i], i),
                          InkWell(
                            onTap: () {
                              navigateToWidget(context, AddCaisse());
                            },
                            child: Container(
                              height: 110,
                              width: 110,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border:
                                      Border.all(color: AppColor.caisseColor)),
                              child: const Icon(
                                Icons.add_circle_outline_rounded,
                                size: 40,
                                color: AppColor.caisseColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  error: errorLoading,
                  loading: loadingError),
            ),
            const SpacerHeight(height: 10),
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
                          return AppText("Entrées");
                        }
                        return AppText("Sorties");
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

  buildCaisse(Caisse caisse, int i) {
    return InkWell(
      onTap: () {
        currentCaisseIndex = i;
        setState(() {});
      },
      child: Container(
          height: 110,
          width: 110,
          margin: i == 0
              ? const EdgeInsets.only(right: 5)
              : const EdgeInsets.symmetric(horizontal: 5),
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: currentCaisseIndex == i
                  ? AppColor.caisseColor
                  : Colors.transparent,
              border: Border.all(color: AppColor.caisseColor)),
          child: Column(
            children: [
              AppImage(
                url: 'assets/img/money.png',
                width: 50,
              ),
              SpacerHeight(),
              AppText(
                "caisse ${caisse.name}",
                weight: FontWeight.w700,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                align: TextAlign.center,
                color: currentCaisseIndex == i ? Colors.white : Colors.black,
              ),
            ],
          )),
    );
  }
}
