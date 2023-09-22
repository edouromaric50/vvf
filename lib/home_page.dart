import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testproject/components/app_image.dart';
import 'package:testproject/components/app_text.dart';
import 'package:testproject/pages/auth/caisses/home_caisse.dart';
import 'package:testproject/pages/auth/categories/home_category.dart';
import 'package:testproject/utils/app_const.dart';
import 'package:testproject/utils/app_func.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  @override
  void initState() {
    // TODO: implement initState
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
    var menus = [
      ["money.png", "Caisses", AppColor.caisseColor, HomeCaisse()],
      ["closures.png", "Projets", AppColor.projeColor, Container()],
      [
        "categories.png",
        "Categories",
        AppColor.catgColor,
        const HomeCategory()
      ],
      ["settings.png", "Parametre", AppColor.settingColor, Container()],
    ];
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          "Solde caisse Epargne",
          color: AppColor.white,
        ),
        centerTitle: true,
        elevation: 0,
        leading: CircleAvatar(
            child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: const AppImage(
              url: "assets/img/logo.png",
              width: 35,
              fit: BoxFit.cover,
              height: 35),
        )),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.account_circle_rounded,
              size: 40,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: SingleChildScrollView(
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
                        color: AppColor.primary,
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

            // Menu
            Container(
              width: getSize(context).width,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.count(
                // alignment: WrapAlignment.spaceBetween,
                crossAxisCount: 2,
                shrinkWrap: true,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                physics: const NeverScrollableScrollPhysics(),
                children: menus.map((e) => buildMenu(e)).toList(),
                //  [
                //  buildMenu(menus),
                //   buildMenu(),
                //   buildMenu(),
                //  buildMenu(),
                // ],
              ),
            ),

            const SpacerHeight(
              height: 40,
            ),
            const Center(
              child: AppText("Version 1.0"),
            ),
            const SpacerHeight(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenu(var menu) {
    return InkWell(
      onTap: () {
        navigateToWidget(context, menu[3]);
      },
      child: Container(
        // width: getSize(context).width / 2 - 5,
        height: 180,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: menu[2], borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppImage(
              url: "assets/img/${menu[0]}",
              width: 60,
            ),
            const SpacerHeight(),
            AppText(
              menu[1],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              size: 20,
              weight: FontWeight.bold,
              color: AppColor.white,
            ),
            const SpacerHeight(),
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
                          return AppText("Entrée");
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
}
