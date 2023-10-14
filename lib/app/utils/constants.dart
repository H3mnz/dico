import 'package:flutter/material.dart';

const String dbName = 'en_to_fa.db';
String sqlQuery(String keyword) => "SELECT * FROM Table1 WHERE en LIKE '$keyword%' OR fa LIKE '$keyword%'";
const String logo = 'assets/image/dico.png';
const String logoWhite = 'assets/image/dico_white.png';
double appBarHeight(BuildContext context) => kToolbarHeight * 2 + MediaQuery.of(context).viewPadding.top * 2;

enum TtsState { playing, stopped, paused, continued }
