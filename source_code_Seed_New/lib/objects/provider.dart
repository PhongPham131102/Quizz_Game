import 'dart:convert';
import 'package:flutter/services.dart';
import 'querries.dart';

class HistoryProvider {
  static Future<List<dynamic>> readJsonData() async {
    var jsonText = await rootBundle.loadString('data/history.json');
    var data = json.decode(jsonText);
    return data['level'];
  }
  static Future<List<Level>> getAllQuerries() async {
    List<Level> lsresult = [];
    List<dynamic> data = await readJsonData();
    lsresult = data.map((e) => Level.fromJson(e)).toList();
    return lsresult;
  }
}
class ProgrammingProvider {
  static Future<List<dynamic>> readJsonData() async {
    var jsonText = await rootBundle.loadString('data/programming.json');
    var data = json.decode(jsonText);
    return data['level'];
  }
  static Future<List<Level>> getAllQuerries() async {
    List<Level> lsresult = [];
    List<dynamic> data = await readJsonData();
    lsresult = data.map((e) => Level.fromJson(e)).toList();
    return lsresult;
  }
}class GeographyProvider {
  static Future<List<dynamic>> readJsonData() async {
    var jsonText = await rootBundle.loadString('data/geography.json');
    var data = json.decode(jsonText);
    return data['level'];
  }
  static Future<List<Level>> getAllQuerries() async {
    List<Level> lsresult = [];
    List<dynamic> data = await readJsonData();
    lsresult = data.map((e) => Level.fromJson(e)).toList();
    return lsresult;
  }
}class LiteratureProvider {
  static Future<List<dynamic>> readJsonData() async {
    var jsonText = await rootBundle.loadString('data/literature.json');
    var data = json.decode(jsonText);
    return data['level'];
  }
  static Future<List<Level>> getAllQuerries() async {
    List<Level> lsresult = [];
    List<dynamic> data = await readJsonData();
    lsresult = data.map((e) => Level.fromJson(e)).toList();
    return lsresult;
  }
}class MusicProvider {
  static Future<List<dynamic>> readJsonData() async {
    var jsonText = await rootBundle.loadString('data/mucsic.json');
    var data = json.decode(jsonText);
    return data['level'];
  }
  static Future<List<Level>> getAllQuerries() async {
    List<Level> lsresult = [];
    List<dynamic> data = await readJsonData();
    lsresult = data.map((e) => Level.fromJson(e)).toList();
    return lsresult;
  }
}
class OnlineProvider {
  static Future<List<dynamic>> readJsonData() async {
    var jsonText = await rootBundle.loadString('data/online.json');
    var data = json.decode(jsonText);
    return data['queries'];
  }
  static Future<List<Querriess>> getAllQuerries() async {
    List<Querriess> lsresult = [];
    List<dynamic> data = await readJsonData();
    lsresult = data.map((e) => Querriess.fromJson(e)).toList();
    return lsresult;
  }
}