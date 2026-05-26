// ignore_for_file: duplicate_ignore, unnecessary_null_comparison, prefer_is_empty

import 'package:crickinfo/models/model.dart';
import 'package:crickinfo/screens/carduc.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class cricet extends StatefulWidget {
  final MatchModel? matchMode;
  const cricet({super.key, required this.matchMode});

  @override
  State<cricet> createState() => _cricetState();
}

class _cricetState extends State<cricet> {
  @override
  Widget build(BuildContext context) {
    final matchModel = widget.matchMode;
    final date = DateTime.parse(matchModel!.datetimegmt.toString());
    final formatted = DateFormat('dd MMM yyy   hh:mm a').format(date);
    return Scaffold(
      appBar: AppBar(
        title: Text('Cricket[A]pp'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        backgroundColor: Colors.blueGrey[800],
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.blueGrey[900]),
        child: Padding(
          padding: EdgeInsets.all(20),

          child: Column(
            children: [
              Card(
                color: Colors.blueGrey[800],

                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 50,
                            width: 50,
                            child: Image.network(
                              (matchModel.teamInfo.isNotEmpty == true &&
                                      matchModel.teamInfo[0].img.isNotEmpty ==
                                          true)
                                  ? matchModel.teamInfo[0].img
                                  : '',
                            ),
                          ),
                          Text(
                            (matchModel.teamInfo != null &&
                                    matchModel.teamInfo.length > 1)
                                // ignore: dead_null_aware_expression
                                ? (matchModel.teamInfo[0].shortname)
                                : 'no name',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'VS',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),

                          Text(
                            (matchModel.teamInfo != null &&
                                    matchModel.teamInfo.length > 1)
                                // ignore: dead_null_aware_expression
                                ? (matchModel.teamInfo[1].shortname ??
                                      // ignore: dead_null_aware_expression
                                      'no name')
                                : 'no name',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            width: 50,
                            child: Image.network(
                              (matchModel.teamInfo.isNotEmpty == true &&
                                      matchModel.teamInfo[1].img.isNotEmpty ==
                                          true)
                                  ? matchModel.teamInfo[1].img
                                  : '',
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            (matchModel != null && matchModel.score.length >= 1)
                                ? '${matchModel.score[0].r}/${matchModel.score[0].w} (${matchModel.score[0].o})'
                                : (matchModel != null &&
                                      matchModel.matchended == true)
                                ? ''
                                : 'yet to bat',
                            style: const TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            
                            // ignore: unnecessary_null_comparison
                            (matchModel != null && matchModel.score.length >= 2)
                                ? '${matchModel.score[1].r}/${matchModel.score[1].w} (${matchModel.score[1].o})'
                                : (matchModel != null &&
                                      matchModel.matchended == true)
                                ? ''
                                : 'yet to bat',
                            style: const TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      Text(
                        (matchModel != null && matchModel.status.isNotEmpty)
                            ? matchModel.status.toString()
                            : 'match not started yet',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        (matchModel.matchStarted == true &&
                                matchModel.matchended == false)
                            ? '🔴 lIVE '
                            : (matchModel.matchended == true)
                            ? '✅ FINISHED'
                            : 'upcoming',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 25),

              Card(
                color: Colors.blueGrey[800],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    (matchModel.venue.isNotEmpty == true)
                        ? 'Venue 📌 :${matchModel.venue.toString()}'
                        : '-',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 25),
              Card(
                color: Colors.blueGrey[800],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    (matchModel.datetimegmt.isNotEmpty == true)
                        ? 'DateTime 📅⏰: ${formatted}'
                        : '-',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 25),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyCard()),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Scorecard',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}