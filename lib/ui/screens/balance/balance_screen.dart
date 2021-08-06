import 'package:flutter/material.dart';
import 'package:gaste_menos_app/domain/domain.dart';
import 'package:gaste_menos_app/domain/entities/category_icon_service.dart';

import 'package:gaste_menos_app/services/services.dart';
import 'package:gaste_menos_app/ui/design/design.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BalanceScreen extends StatefulWidget {
  final Database database;
  final int month;

  const BalanceScreen({
    Key key,
    @required this.database,
    @required this.month,
  }) : super(key: key);

  static Future<void> show(BuildContext context, int month) async {
    final database = Provider.of<Database>(context, listen: false);
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => BalanceScreen(database: database, month: month),
      fullscreenDialog: true,
    ));
  }

  @override
  _BalanceScreenState createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
  final CategoryIconService _categoryIconService = CategoryIconService();
  List<GDPData> _chartData = [];
  TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    // _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double totalWidth = Utils.totalWidth(context: context);
    return Scaffold(
      appBar: AppBar(
        // title: title,
        // centerTitle: true,
        backgroundColor: Colors.white,
        leading: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () => Navigator.of(context).pop(false),
            child: Icon(
              Icons.chevron_left,
              color: kColorPurple,
              size: 32,
            )),
        elevation: 0,
      ),
      body: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: StreamBuilder<List<Desp>>(
              stream: widget.database.despStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final desp = snapshot.data;
                  List<Widget> despesa = [];
                  List amount = [];
                  for (int i = 0;
                      i < _categoryIconService.expenseList.length;
                      i++) {
                    amount.add(0);
                  }
                  desp.forEach((des) {
                    if (des.data.month == widget.month) {
                      var icon;
                      var color;
                      _categoryIconService.expenseList.forEach((element) {
                        if (element.name == des.categoria) {
                          icon = element.icon;
                          color = element.color;
                          amount[element.index] += des.valor;
                        }
                      });
                      // print(amount.toString());

                      despesa.add(Container(
                        // color: Colors.red,
                        padding: EdgeInsets.all(8),
                        // height: 50,
                        width: totalWidth,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              child: ClipOval(
                                  child: Container(
                                color: color,
                                child: Icon(
                                  icon,
                                  size: 20,
                                ),
                              )),
                            ),
                            Container(
                              padding: EdgeInsets.all(8),
                              child: Text(des.nome),
                            ),
                            Container(
                              child:
                                  Text('-R\$ ${des.valor.toStringAsFixed(2)}'),
                            ),
                          ],
                        ),
                      ));
                    }
                  });
                  _categoryIconService.expenseList.forEach((element) {
                    _chartData.add(GDPData(
                      element.name,
                      amount.elementAt(element.index).round(),
                      element.color,
                    ));
                  });

                  return Column(
                    children: [
                      SfCircularChart(
                          legend: Legend(
                              isVisible: true,
                              overflowMode: LegendItemOverflowMode.scroll),
                          tooltipBehavior: _tooltipBehavior,
                          series: <CircularSeries>[
                            PieSeries<GDPData, String>(
                              dataSource: _chartData,
                              pointColorMapper: (GDPData data, _) => data.color,
                              xValueMapper: (GDPData data, _) => data.nome,
                              yValueMapper: (GDPData data, _) => data.amount,
                              dataLabelSettings:
                                  DataLabelSettings(isVisible: false),
                              enableTooltip: true,
                            )
                          ]),
                      Container(
                        height: 300,
                        child: ListView(
                          // children: children,
                          children: despesa,
                        ),
                      ),
                    ],
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Some error occurred'),
                  );
                }
                return Center(child: CircularProgressIndicator());
              }),
        ),
      ),
    );
  }

  // List<GDPData> getChartData() {
  //   final List<GDPData> chartData = [
  //     GDPData('Oceania', 1600),
  //     GDPData('Africa', 2490),
  //     GDPData('S America', 2900),
  //     GDPData('Europe', 23050),
  //     GDPData('N America', 24880),
  //     GDPData('Asia', 34390),
  //   ];
  //   return chartData;
  // }
}

class GDPData {
  GDPData(this.nome, this.amount, this.color);
  final String nome;
  final int amount;
  final Color color;
}
