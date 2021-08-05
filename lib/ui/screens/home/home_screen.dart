import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gaste_menos_app/domain/domain.dart';
import 'package:gaste_menos_app/services/services.dart';
import 'package:gaste_menos_app/ui/design/images.dart';
import 'package:gaste_menos_app/ui/screens/home/new_transaction.dart';
import 'package:gaste_menos_app/ui/screens/screens.dart';
import 'package:gaste_menos_app/ui/widgets/widgets.dart';
import 'package:provider/provider.dart';
import '../../widgets/cupertino_picker_extended.dart' as CupertinoExtended;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  // Future<void> _createDesp(BuildContext context) async {
  //   try {
  //     final database = Provider.of<Database>(context, listen: false);
  //     await database.createDesp(Desp(
  //       categoria: 'Supermercado',
  //       data: DateTime.now(),
  //       nome: 'Brasil',
  //       valor: 23.45,
  //     ));
  //   } on FirebaseException catch (e) {
  //     showExceptionAlertDialog(
  //       context,
  //       title: 'Operação falha',
  //       exception: e,
  //     );
  //   }
  // }

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
    var totalDesp = 0.0;
    var totalGanho = 0.0;
    var balanco = 0.0;
    return Scaffold(
      body: SafeArea(
          minimum: EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    child: Text('Logout'),
                    onTap: () => _confirmSignOut(context),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //   children: [
                  //     Avatar(),
                  //     Avatar(),
                  //     Avatar(),
                  //     Avatar(),
                  //   ],
                  // ),
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
                          onTap: () => DatePicker(),
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
                          if (snapshot.hasData) {
                            final desp = snapshot.data;
                            List<Widget> despesa = [];
                            desp.forEach((des) {
                              if (des.data.month == 8) {
                                totalDesp += des.valor;
                                despesa.add(Container(
                                  padding: EdgeInsets.all(8),
                                  color: Colors.red,
                                  child: Text(des.nome),
                                ));
                              }
                            });
                            balanco = totalGanho - totalDesp;

                            return Column(
                              children: [
                                /*Container(
                                  height: 80,
                                  child: ListView(
                                    // children: children,
                                    children: despesa,
                                  ),
                                ),*/
                                Container(
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    // color: Colors.purple,
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
                                                          'R\$ ${totalGanho.toStringAsFixed(2)}')
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons
                                                          .remove_circle_outline),
                                                      Text(
                                                          'R\$ ${totalDesp.toStringAsFixed(2)}')
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

                  /*Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      // color: Colors.purple,
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: InkWell(
                      child: Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Metas'),
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Curto Prazo: '),
                                  Text('R\$ XXXX')
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Longo Prazo: '),
                                  Text('R\$ XXXX')
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),*/
                  Container(
                    height: 60,
                    width: 60,
                    child: ClipOval(
                      child: Material(
                        color: Colors.purple,
                        child: InkWell(
                            onTap: () => DespesasScreen.show(context),
                            // onTap: () => _startAddNewTransaction(context),
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
      /*bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.purple,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home')
        ],
      ),*/
    );
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }
}

class DatePicker extends StatefulWidget {
  const DatePicker({
    Key key,
  }) : super(key: key);

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: CupertinoExtended.CupertinoDatePicker(
        initialDateTime: DateTime.now(),
        onDateTimeChanged: (date) {
          setState(() {
            // dateTime = date;
            //   widget.presenter.validatePicker(dateTime);
          });
        },
        minimumYear: 1950,
        maximumYear: DateTime.now().year,
        use24hFormat: true,
        mode: CupertinoExtended.CupertinoDatePickerMode.date,
      ),
    );
  }
}

/*class Avatar extends StatelessWidget {
  const Avatar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: ClipOval(
        child: Material(
          child: InkWell(
            child: Image.asset(
              Images.kUrso,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ),
    );
  }
}*/
