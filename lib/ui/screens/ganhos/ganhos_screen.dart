import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:gaste_menos_app/domain/domain.dart';
import 'package:gaste_menos_app/domain/entities/category_icon_service.dart';
import 'package:gaste_menos_app/services/services.dart';
import 'package:gaste_menos_app/ui/design/design.dart';
import 'package:gaste_menos_app/ui/widgets/widgets.dart';

class GanhosScreen extends StatefulWidget {
  final Database database;
  final Ganho ganho;

  const GanhosScreen({
    Key key,
    @required this.database,
    this.ganho,
  }) : super(key: key);

  static Future<void> show(BuildContext context,
      {Database database, Ganho ganho}) async {
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => GanhosScreen(
        database: database,
        ganho: ganho,
      ),
      fullscreenDialog: true,
    ));
  }

  @override
  _GanhosScreenState createState() => _GanhosScreenState();
}

class _GanhosScreenState extends State<GanhosScreen> {
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
    if (widget.ganho != null) {
      _name = widget.ganho.nome;
      _category = widget.ganho.categoria;
      _date = widget.ganho.data;
      _value = widget.ganho.valor;
    }
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
      try {
        final data = DateTime(
            _date.year, _date.month, _date.day, _date.hour, _date.minute);
        final id = widget.ganho?.id ?? documentIdFromCurrentDate();
        final ganho = Ganho(
            id: id,
            categoria: _category,
            data: data,
            nome: _name,
            valor: _value);
        await widget.database.setGanho(ganho);
        Navigator.of(context).pop();
      } on FirebaseException catch (e) {
        showExceptionAlertDialog(context,
            title: 'Operação falhou', exception: e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double totalHeight = Utils.totalHeight(context: context);
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Text(widget.ganho == null ? 'Novo Ganho' : 'Edite Ganho'),
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
                        initialValue: _name,
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
                              initialValue:
                                  (_value == null) ? null : _value.toString(),
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
                        height: totalHeight * 0.32,
                        child: GridView.count(
                          primary: false,
                          padding: EdgeInsets.symmetric(vertical: 8),
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 16,
                          crossAxisCount: 3,
                          children: _categoryIconService.incomeList
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
