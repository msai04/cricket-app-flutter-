import 'dart:convert';

import 'package:crickinfo/models/model.dart';
import 'package:http/http.dart' as http;
class cricinfo {
  Future<List<MatchModel>> fetchdata() async {
    final url = Uri.parse(
      "https://api.cricapi.com/v1/currentMatches?apikey=3e5f2d6c-3a58-4a79-804f-d9808c899b1a&offset=0",
    );
    final response = await http.get(url);
    if(response.statusCode ==200){
      final decoded = json.decode(response.body);
      final List data = decoded['data'];
      return data.map((e)=> MatchModel.fromJson(e)).toList();
    }else{
      throw Exception('failed to load data');
    }
  }
}