import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gaste_menos_app/domain/domain.dart';

class CategoryIconService {
  //* FIRST : EXPENSE LIST
  final expenseList = {
    Category(0, "Comida", FontAwesomeIcons.pizzaSlice, Color(0xFF4587BB)),
    Category(1, "Contas", FontAwesomeIcons.moneyBill, Color(0xFFBF6B84)),
    Category(2, "Transporte", FontAwesomeIcons.bus, Color(0xFFFD6D7A)),
    Category(3, "Casa", FontAwesomeIcons.home, Color(0xFFF4B38E)),
    Category(4, "Entretenimento", FontAwesomeIcons.gamepad, Color(0xFF7FFFD4)),
    Category(5, "Shopping", FontAwesomeIcons.shoppingBag, Color(0xFF09A7B1)),
    Category(6, "Roupa", FontAwesomeIcons.tshirt, Color(0xFF464B9B)),
    Category(7, "Manutenção", FontAwesomeIcons.hammer, Color(0xFFDAA520)),
    Category(8, "Telefone", FontAwesomeIcons.phone, Color(0xFFADFF2F)),
    Category(9, "Saúde", FontAwesomeIcons.briefcaseMedical, Color(0xFFB22222)),
    Category(10, "Esporte", FontAwesomeIcons.footballBall, Color(0xFF7091AF)),
    Category(11, "Beleza", FontAwesomeIcons.marker, Color(0xFFFF7F50)),
    Category(12, "Educação", FontAwesomeIcons.book, Color(0xFFC71585)),
    Category(13, "Presente", FontAwesomeIcons.gift, Color(0xFFFCB096)),
    Category(14, "Animal", FontAwesomeIcons.dog, Color(0xFF008B8B)),
  };
  //* SECOND : INCOME LIST
  final incomeList = {
    Category(0, "Salário", FontAwesomeIcons.wallet, Color(0xFFFD6D7A)),
    Category(1, "Prêmio", FontAwesomeIcons.moneyCheck, Color(0xFF464B9B)),
    Category(2, "Bolsa", FontAwesomeIcons.gifts, Color(0xFF7FFFD4)),
    Category(3, "Aluguel", FontAwesomeIcons.houseUser, Color(0xFFADFF2F)),
    Category(4, "Investimento", FontAwesomeIcons.piggyBank, Color(0xFFDAA520)),
    Category(5, "Loteria", FontAwesomeIcons.dice, Color(0xFFC71585)),
  };
}
