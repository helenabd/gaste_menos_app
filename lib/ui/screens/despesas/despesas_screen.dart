import 'package:flutter/material.dart';
import 'package:gaste_menos_app/domain/domain.dart';

import 'package:gaste_menos_app/services/services.dart';
import 'package:provider/provider.dart';

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

  String _name;
  String _category;
  DateTime _date = DateTime.now();
  double _value;

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
      final desp =
          Desp(categoria: _category, data: _date, nome: _name, valor: _value);
      await widget.database.createDesp(desp);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
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
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Categoria'),
                        validator: (value) => value.isNotEmpty
                            ? null
                            : 'Categoria não pode ser vazia',
                        onSaved: (newValue) => _category = newValue,
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Valor'),
                        onSaved: (newValue) =>
                            _value = double.tryParse(newValue) ?? 0,
                        keyboardType: TextInputType.number,
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
