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

class DespesasDetailScreen extends StatefulWidget {
  final Database database;
  final int month;

  const DespesasDetailScreen({
    Key key,
    @required this.database,
    @required this.month,
  }) : super(key: key);

  static Future<void> show(BuildContext context, int month) async {
    final database = Provider.of<Database>(context, listen: false);
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) =>
          DespesasDetailScreen(database: database, month: month),
      fullscreenDialog: true,
    ));
  }

  @override
  _DespesasDetailScreenState createState() => _DespesasDetailScreenState();
}

class _DespesasDetailScreenState extends State<DespesasDetailScreen> {
  final CategoryIconService _categoryIconService = CategoryIconService();
  List<CategoryData> _chartData = [];
  TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _chartData = [];
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  Future<void> _delete(BuildContext context, Desp desp) async {
    try {
      await widget.database.deleteDesp(desp);
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
          'Despesas',
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

                      despesa.add(Dismissible(
                        key: Key('desp-${des.id}'),
                        background: Container(color: Colors.red),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) => _delete(context, des),
                        child: Container(
                          // color: Colors.red,
                          padding: EdgeInsets.all(8),
                          // height: 50,
                          width: totalWidth,
                          child: InkWell(
                            onTap: () => DespesasScreen.show(context,
                                desp: des, database: widget.database),
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
                                  child: Text(
                                      '-R\$ ${des.valor.toStringAsFixed(2)}'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ));
                    }
                  });
                  _chartData = [];
                  _categoryIconService.expenseList.forEach((element) {
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

class CategoryData {
  CategoryData(this.nome, this.amount, this.color);
  final String nome;
  final int amount;
  final Color color;
}
