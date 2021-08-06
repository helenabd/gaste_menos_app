import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gaste_menos_app/domain/domain.dart';
import 'package:gaste_menos_app/domain/entities/category_icon_service.dart';

import 'package:gaste_menos_app/services/services.dart';
import 'package:gaste_menos_app/ui/design/design.dart';
import 'package:gaste_menos_app/ui/screens/screens.dart';
import 'package:gaste_menos_app/ui/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GanhosDetailScreen extends StatefulWidget {
  final Database database;
  final int month;

  const GanhosDetailScreen({
    Key key,
    @required this.database,
    @required this.month,
  }) : super(key: key);

  static Future<void> show(BuildContext context, int month) async {
    final database = Provider.of<Database>(context, listen: false);
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) =>
          GanhosDetailScreen(database: database, month: month),
      fullscreenDialog: true,
    ));
  }

  @override
  _GanhosDetailScreenState createState() => _GanhosDetailScreenState();
}

class _GanhosDetailScreenState extends State<GanhosDetailScreen> {
  final CategoryIconService _categoryIconService = CategoryIconService();
  List<CategoryData> _chartData = [];
  TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _chartData = [];
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  Future<void> _delete(BuildContext context, Ganho ganho) async {
    try {
      await widget.database.deleteGanho(ganho);
    } on FirebaseException catch (e) {
      showExceptionAlertDialog(
        context,
        title: 'Operation failed',
        exception: e,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double totalWidth = Utils.totalWidth(context: context);
    double totalHeight = Utils.totalHeight(context: context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ganhos',
          style: TextStyle(color: kColorDarkPurple),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () => Navigator.of(context).pop(false),
            child: Icon(
              Icons.chevron_left,
              color: kColorDarkPurple,
              size: 32,
            )),
        elevation: 0,
      ),
      body: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: StreamBuilder<List<Ganho>>(
              stream: widget.database.ganhoStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final ganhos = snapshot.data;
                  List<Widget> despesa = [];
                  List amount = [];
                  for (int i = 0;
                      i < _categoryIconService.incomeList.length;
                      i++) {
                    amount.add(0);
                  }
                  ganhos.forEach((ganho) {
                    if (ganho.data.month == widget.month) {
                      var icon;
                      var color;
                      _categoryIconService.incomeList.forEach((element) {
                        if (element.name == ganho.categoria) {
                          icon = element.icon;
                          color = element.color;
                          amount[element.index] += ganho.valor;
                        }
                      });
                      // print(amount.toString());

                      despesa.add(Dismissible(
                        key: Key('ganho-${ganho.id}'),
                        background: Container(color: Colors.red),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) => _delete(context, ganho),
                        child: Container(
                          // color: Colors.red,
                          padding: EdgeInsets.all(8),
                          // height: 50,
                          width: totalWidth,
                          child: InkWell(
                            onTap: () => GanhosScreen.show(context,
                                ganho: ganho, database: widget.database),
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
                                  child: Text(ganho.nome),
                                ),
                                Container(
                                  child: Text(
                                      '+R\$ ${ganho.valor.toStringAsFixed(2)}'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ));
                    }
                  });
                  _chartData = [];
                  _categoryIconService.incomeList.forEach((element) {
                    _chartData.add(CategoryData(
                      element.name,
                      amount.elementAt(element.index).round(),
                      element.color,
                    ));
                  });

                  return Column(
                    children: [
                      SfCircularChart(
                          legend: Legend(
                              isVisible: false,
                              overflowMode: LegendItemOverflowMode.scroll),
                          tooltipBehavior: _tooltipBehavior,
                          series: <CircularSeries>[
                            PieSeries<CategoryData, String>(
                              dataSource: _chartData,
                              pointColorMapper: (CategoryData data, _) =>
                                  data.color,
                              xValueMapper: (CategoryData data, _) => data.nome,
                              yValueMapper: (CategoryData data, _) =>
                                  data.amount,
                              dataLabelSettings:
                                  DataLabelSettings(isVisible: false),
                              enableTooltip: true,
                            )
                          ]),
                      Container(
                        height: totalHeight * 0.52,
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
}
