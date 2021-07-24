import 'package:flutter/material.dart';
import 'package:gaste_menos_app/ui/design/images.dart';
import '../../widgets/cupertino_picker_extended.dart' as CupertinoExtended;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
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
      body: SafeArea(
          minimum: EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Avatar(),
                      Avatar(),
                      Avatar(),
                      Avatar(),
                    ],
                  ),
                  Text('Olá Maria'),
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
                            Text('Balanço'),
                            Text('R\$ XXXX'),
                            Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        Icon(Icons.add_circle_outline),
                                        Text('R\$ XXXX')
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        Icon(Icons.remove_circle_outline),
                                        Text('R\$ XXXX')
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
                  Container(
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
                  ),
                ],
              ),
            ),
          )),
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

class Avatar extends StatelessWidget {
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
}
