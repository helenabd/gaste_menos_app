import 'package:flutter/material.dart';
import 'package:gaste_menos_app/domain/domain.dart';
import 'package:gaste_menos_app/services/services.dart';
import 'package:gaste_menos_app/ui/design/design.dart';
import 'package:gaste_menos_app/ui/screens/home/new_transaction.dart';
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
    super.initState();
    totalDesp = 0.0;
    totalGanho = 0.0;
    balanco = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    List monthList = [
      'Jan',
      'Fev',
      'Mar',
      'Abr',
      'Maio',
      'Jun',
      'Jul',
      'Ago',
      'Set',
      'Out',
      'Nov',
      'Dez'
    ];
    DateTime dateTime = DateTime.now();

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
                      InkWell(
                        child: Icon(Icons.arrow_back_ios),
                        onTap: () => print('Cliquei aqui'),
                      ),
                      Container(
                        child: InkWell(
                          child: Text(
                              '${monthList.elementAt(dateTime.month - 1).toString()}/${dateTime.year}'),
                          onTap: () {},
                        ),
                      ),
                      InkWell(
                        child: Icon(Icons.arrow_forward_ios),
                      ),
                    ],
                  ),
                  Container(
                    height: 300,
                    child: StreamBuilder<List<Desp>>(
                        stream: database.despStream(),
                        builder: (context, snapshot) {
                          totalDesp = 0.0;
                          totalGanho = 0.0;
                          balanco = 0.0;
                          if (snapshot.hasData) {
                            final desp = snapshot.data;
                            desp.forEach((des) {
                              if (des.data.month == 8) {
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
                                  child: InkWell(
                                    onTap: () => BalanceScreen.show(context, 8),
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
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 16.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons
                                                          .add_circle_outline),
                                                      Text(
                                                          'R\$ ${(totalGanho == null) ? 0.toStringAsFixed(2) : totalGanho.toStringAsFixed(2)}')
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons
                                                          .remove_circle_outline),
                                                      Text(
                                                          'R\$ ${(totalDesp == null) ? 0.toStringAsFixed(2) : totalDesp.toStringAsFixed(2)}')
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
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
                              Icons.add,
                              color: Colors.white,
                              size: 42,
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
