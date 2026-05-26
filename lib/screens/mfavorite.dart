// ignore_for_file: unnecessary_null_comparison

import 'package:crickinfo/models/model.dart';
import 'package:crickinfo/screens/cardwid.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Favorite extends StatefulWidget {
  final List<MatchModel> matchmodel;
  const Favorite({super.key, required this.matchmodel});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  List<MatchModel>? matchMod;
  final box = Hive.box('Favorite');
  List favlist() {
    return box.get('Favorite', defaultValue: ['invaild data']);
  }

  @override
  Widget build(BuildContext context) {
    List getfavlist = favlist();
    List favmatches = widget.matchmodel
        .where((matches) => getfavlist.contains(matches.id))
        .toList();
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title: Text('Favorites', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[800],
      ),
      body: RefreshIndicator(
        onRefresh: () async => favlist(),
        child: favmatches.isNotEmpty
            ? ListView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: favmatches.length,
                itemBuilder: (context, index) {
                  final match = favmatches[index];
                  return Cicketcard(matchmodel: match);
                },
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.favorite_border, color: Colors.white),
                    Text(
                      'No Favorites Yet',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
