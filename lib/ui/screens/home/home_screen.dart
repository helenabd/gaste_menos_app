import 'package:flutter/material.dart';
import 'package:gaste_menos_app/domain/domain.dart';
import 'package:gaste_menos_app/services/services.dart';
import 'package:gaste_menos_app/ui/design/design.dart';
import 'package:gaste_menos_app/ui/screens/ganhos/ganhos_screen.dart';
import 'package:gaste_menos_app/ui/screens/login/components/logo.dart';
import 'package:gaste_menos_app/ui/screens/screens.dart';
import 'package:gaste_menos_app/ui/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double totalDesp;
  double totalGanho;
  double balanco;
  DateTime _date;

  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await showAlertDialog(
      context,
      title: 'Logout',
      content: 'Are you sure that you want to logout?',
      defaultActionText: 'Logout',
      cancelActionText: 'Cancel',
    );

    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  @override
  void initState() {
    final start = DateTime.now();
    _date = DateTime(start.year, start.month, start.day);
    super.initState();
    totalDesp = 0.0;
    totalGanho = 0.0;
    balanco = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: InkWell(
              child: Text(
                'Sair',
                style: TextStyle(
                  color: kColorPurple,
                  fontSize: 18,
                ),
              ),
              onTap: () => _confirmSignOut(context),
            ),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
          minimum: EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Logo(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: MonthDatePicker(
                          labelText: 'Data',
                          selectedDate: _date,
                          selectDate: (date) => setState(() => _date = date),
                        ),
                      ),
                    ],
                  ),
                  StreamBuilder<List<Ganho>>(
                      stream: database.ganhoStream(),
                      builder: (context, snapshot) {
                        totalGanho = 0.0;
                        if (snapshot.hasData) {
                          final ganhos = snapshot.data;
                          ganhos.forEach((ganho) {
                            if (ganho.data.month == _date.month) {
                              (totalGanho == null)
                                  ? totalGanho = ganho.valor
                                  : totalGanho += ganho.valor;
                            }
                          });
                        }
                        return Container();
                      }),
                  Container(
                    height: 300,
                    child: StreamBuilder<List<Desp>>(
                        stream: database.despStream(),
                        builder: (context, snapshot) {
                          totalDesp = 0.0;
                          balanco = 0.0;
                          if (snapshot.hasData) {
                            final desp = snapshot.data;
                            desp.forEach((des) {
                              if (des.data.month == _date.month) {
                                (totalDesp == null)
                                    ? totalDesp = des.valor
                                    : totalDesp += des.valor;
                              }
                            });
                            (totalGanho == null)
                                ? balanco = 0 - totalDesp
                                : balanco = totalGanho - totalDesp;

                            return Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Container(
                                    height: 160,
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Balanço'),
                                        Text(
                                            'R\$ ${balanco.toStringAsFixed(2)}'),
                                        Text('Entradas'),
                                        Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              // Icon(Icons.add_circle_outline),
                                              Text(
                                                  'R\$ ${(totalGanho == null) ? 0.toStringAsFixed(2) : totalGanho.toStringAsFixed(2)}'),
                                              InkWell(
                                                  onTap: () =>
                                                      GanhosDetailScreen.show(
                                                          context, _date.month),
                                                  child: Text('detalhes')),
                                            ],
                                          ),
                                        ),
                                        Text('Despesas'),
                                        Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              // Icon(Icons
                                              //     .remove_circle_outline),
                                              Text(
                                                  'R\$ ${(totalDesp == null) ? 0.toStringAsFixed(2) : totalDesp.toStringAsFixed(2)}'),
                                              InkWell(
                                                onTap: () =>
                                                    DespesasDetailScreen.show(
                                                        context, _date.month),
                                                child: Text('detalhes'),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        child: ClipOval(
                          child: Material(
                            color: Colors.purple,
                            child: InkWell(
                                onTap: () => GanhosScreen.show(context,
                                    database: database),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 42,
                                )),
                          ),
                        ),
                      ),
                      Container(
                        height: 60,
                        width: 60,
                        child: ClipOval(
                          child: Material(
                            color: Colors.purple,
                            child: InkWell(
                                onTap: () => DespesasScreen.show(context,
                                    database: database),
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                  size: 42,
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
