import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gaste_menos_app/domain/domain.dart';

class CategoryIconService {
  //* FIRST : EXPENSE LIST
  final expenseList = {
    Category(0, "Comida", FontAwesomeIcons.pizzaSlice, Colors.green),
    Category(1, "Contas", FontAwesomeIcons.moneyBill, Colors.blue),
    Category(2, "Transporte", FontAwesomeIcons.bus, Colors.blueAccent),
    Category(3, "Casa", FontAwesomeIcons.home, Colors.brown),
    Category(4, "Entretenimento", FontAwesomeIcons.gamepad, Colors.cyanAccent),
    Category(5, "Shopping", FontAwesomeIcons.shoppingBag, Colors.deepOrange),
    Category(6, "Roupa", FontAwesomeIcons.tshirt, Colors.deepOrangeAccent),
    Category(7, "Manutenção", FontAwesomeIcons.hammer, Colors.indigo),
    Category(8, "Telefone", FontAwesomeIcons.phone, Colors.indigoAccent),
    Category(9, "Saúde", FontAwesomeIcons.briefcaseMedical, Colors.lime),
    Category(10, "Esporte", FontAwesomeIcons.footballBall, Colors.limeAccent),
    Category(11, "Beleza", FontAwesomeIcons.marker, Colors.pink),
    Category(12, "Educação", FontAwesomeIcons.book, Colors.teal),
    Category(13, "Presente", FontAwesomeIcons.gift, Colors.redAccent),
    Category(14, "Animal", FontAwesomeIcons.dog, Colors.deepPurpleAccent),
  };
  //* SECOND : INCOME LIST
  final incomeList = {
    Category(0, "Salary", FontAwesomeIcons.wallet, Colors.green),
    Category(1, "Awards", FontAwesomeIcons.moneyCheck, Colors.amber),
    Category(2, "Grants", FontAwesomeIcons.gifts, Colors.lightGreen),
    Category(3, "Rental", FontAwesomeIcons.houseUser, Colors.yellow),
    Category(4, "Investment", FontAwesomeIcons.piggyBank, Colors.cyanAccent),
    Category(5, "Lottery", FontAwesomeIcons.dice, Colors.deepOrange),
  };
}
