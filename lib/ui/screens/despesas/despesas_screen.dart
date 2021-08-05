import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:gaste_menos_app/domain/domain.dart';
import 'package:gaste_menos_app/domain/entities/category_icon_service.dart';
import 'package:gaste_menos_app/services/services.dart';
import 'package:gaste_menos_app/ui/design/design.dart';
import 'package:gaste_menos_app/ui/widgets/widgets.dart';

class DespesasScreen extends StatefulWidget {
  final Database database;

  const DespesasScreen({
    Key key,
    @required this.database,
  }) : super(key: key);

  static Future<void> show(BuildContext context) async {
    final database = Provider.of<Database>(context, listen: false);
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => DespesasScreen(database: database),
      fullscreenDialog: true,
    ));
  }

  @override
  _DespesasScreenState createState() => _DespesasScreenState();
}

class _DespesasScreenState extends State<DespesasScreen> {
  final _formKey = GlobalKey<FormState>();
  final CategoryIconService _categoryIconService = CategoryIconService();

  String _name;
  String _category;
  DateTime _date;
  double _value;

  @override
  void initState() {
    super.initState();
    final start = DateTime.now();
    _date = DateTime(start.year, start.month, start.day);
  }

  bool _validateAndSaveForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> _submit() async {
    if (_validateAndSaveForm()) {
      final data = DateTime(
          _date.year, _date.month, _date.day, _date.hour, _date.minute);
      final desp =
          Desp(categoria: _category, data: data, nome: _name, valor: _value);
      await widget.database.createDesp(desp);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    double totalHeight = Utils.totalHeight(context: context);
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Text('Nova Despesa'),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: _submit,
              child: Text(
                'Salvar',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ))
        ],
      ),
      backgroundColor: Colors.grey[200],
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Card(
            child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Descrição'),
                        validator: (value) => value.isNotEmpty
                            ? null
                            : 'Descrição não pode ser vazia',
                        onSaved: (newValue) => _name = newValue,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(labelText: 'Valor'),
                              onSaved: (newValue) =>
                                  _value = double.tryParse(newValue) ?? 0,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          SizedBox(width: 12.0),
                          Expanded(
                            child: DateTimePicker(
                              labelText: 'Data',
                              selectedDate: _date,
                              selectDate: (date) =>
                                  setState(() => _date = date),
                            ),
                          )
                        ],
                      ),
                      /*TextFormField(
                        decoration: InputDecoration(labelText: 'Categoria'),
                        validator: (value) => value.isNotEmpty
                            ? null
                            : 'Categoria não pode ser vazia',
                        onSaved: (newValue) => _category = newValue,
                      ),*/
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Categorias',
                        style: TextStyle(color: Colors.grey[800], fontSize: 14),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: totalHeight * 0.52,
                        child: GridView.count(
                          primary: false,
                          padding: EdgeInsets.symmetric(vertical: 8),
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 16,
                          crossAxisCount: 3,
                          children: _categoryIconService.expenseList
                              .map((category) => InkWell(
                                    onTap: () {
                                      setState(() {
                                        _category = category.name;
                                      });
                                    },
                                    overlayColor:
                                        MaterialStateProperty.all<Color>(
                                            Theme.of(context).primaryColor),
                                    child: Container(
                                      // padding: EdgeInsets.all(16),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Icon(
                                            category.icon,
                                            size: 20,
                                            color: (category.name == _category)
                                                ? kColorPurple
                                                : Colors.grey,
                                          ),
                                          Text(
                                            category.name,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color:
                                                    (category.name == _category)
                                                        ? kColorPurple
                                                        : Colors.black,
                                                fontWeight:
                                                    (category.name == _category)
                                                        ? FontWeight.bold
                                                        : FontWeight.normal),
                                            textAlign: TextAlign.center,
                                          )
                                        ],
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        ),
      )),
    );
  }
}
