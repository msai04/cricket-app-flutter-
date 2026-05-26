// ignore_for_file: unnecessary_null_comparison, invalid_null_aware_operator

import 'package:crickinfo/Hive/Hive.dart';
import 'package:crickinfo/models/model.dart';
import 'package:crickinfo/screens/lag.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Cicketcard extends StatefulWidget {
  final MatchModel matchmodel;

  const Cicketcard({super.key, required this.matchmodel});

  @override
  State<Cicketcard> createState() => _CicketcardState();
}

class _CicketcardState extends State<Cicketcard> {
  final box = Hive.box('Favorite');
  List getfavlist() {
    return List<String>.from(
      box.get('Favorite', defaultValue: ['invaild data']),
    );
  }

  @override
  Widget build(BuildContext context) {
    final match = widget.matchmodel;
    List favlist = getfavlist();
    bool isselected = favlist.contains(match.id);

    return Padding(
      padding: const EdgeInsets.all(20),
      child: GestureDetector(
        onTap: () => Navigator.push(
          (context),
          MaterialPageRoute(builder: (context) => cricet(matchMode: match)),
        ),
        child: Card(
          color: Colors.blueGrey[800],
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: Image.network(
                        (match.teamInfo.isNotEmpty == true&& match.teamInfo[0].img.isNotEmpty==true)
                            ? match.teamInfo[0].img
                            : '',
                      ),
                    ),
                    
                      Text(
                        (match?.teamInfo[0].shortname != null &&
                                match.teamInfo != null)
                            ? '${match?.teamInfo[0].shortname}'
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
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      (match?.teamInfo != null && match.teamInfo.length > 1)
                          // ignore: dead_null_aware_expression
                          ? (match.teamInfo[1].shortname ?? 'no name')
                          : 'no name',

                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: Image.network(
                        (match.teamInfo.isNotEmpty == true&& match.teamInfo[1].img.isNotEmpty==true)
                            ? match.teamInfo[1].img
                            : '',
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10),
                
                   Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      
                       Text(
                        
                          (match.score.length >= 1)
                              ? '${match.score[0].r}/${match.score[0].w} (${match.score[0].o})'
                              : (match.matchended == true)
                              ? ''
                              : 'yet to bat'
                             
                              ,
                          style: const TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                          ),
                        ),
                      
                  
                     Spacer(),
                  
                      Text(
                        
                        (match.score.length >= 2)
                            ? '${match.score[1].r}/${match.score[1].w} (${match.score[1].o})'
                            : (match.matchended == true )
                            ? ''
                            : 'yet to bat'
                            ,
                        style: const TextStyle(fontSize: 17, color: Colors.white),
                      ),
                    ],
                  ),
              

                const SizedBox(height: 20),

                Text(
                  (match.status.isNotEmpty)
                      ? match.status.toString()
                      : 'match not started yet',
                  style: const TextStyle(fontSize: 12, color: Colors.white70),
                  textAlign : TextAlign.center
                ),

                const SizedBox(height: 20),

                Text(
                  match?.matchType.toString() ?? 'N/A',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70,
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      (match.matchStarted == true && match.matchended == false)
                          ? '🔴 LIVE '
                          : (match.matchended == true)
                          ? '✅ FINISHED'
                          : 'upcoming',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white70,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        database().loadData(match.id);
                        setState(() {});
                      },
                      icon: Icon(
                        isselected ? Icons.favorite : Icons.favorite_border,
                        color: isselected ? Colors.red : Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
