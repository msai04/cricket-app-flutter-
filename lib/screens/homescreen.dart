// ignore_for_file: invalid_null_aware_operator, unused_local_variable
import 'dart:async';
import 'package:crickinfo/firebase/reusableWidgets.dart';
import 'package:crickinfo/firebase/firebaselogin.dart';
import 'package:crickinfo/main.dart';
import 'package:crickinfo/models/model.dart';
import 'package:crickinfo/screens/cardwid.dart';
import 'package:crickinfo/screens/mfavorite.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  

  int mynum = 0;
  List<MatchModel>? matchMod;
  Timer? timer;
  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  void initState() {
    super.initState();
    loadData();
    autorefresh();
  }

  void autorefresh() {
    timer = Timer.periodic(Duration(minutes: 1), (timer) {
      loadData();
    });
  }

  bool iswaiting = false;

  Future<void> loadData() async {
    if (iswaiting) return;

    try {
      ref.read(fetchApi);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load Data Or Internet Issue')),
      );
    }
  }

  SignOut() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Logout'),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            uiheler.button(() async {
              try {
                await FirebaseAuth.instance.signOut();
                Navigator.pop(context); // close dialog
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => Criclogin()),
                );
              } catch (e) {
                Navigator.pop(context);
                uiheler.alertbox("Logout failed", context);
              }
            }, 'Yes'),
            SizedBox(width: 10),
            uiheler.button(() async => Navigator.pop(context), 'No'),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    
    final match = ref.watch(fetchApi);
    
    return ref
        .watch(fetchApi)
        .when(
          data: (data) {
            final matchMode = data;
            final MyMatches =
    mynum==0
    ?matchMode
    :matchMode.where((m){
      final type = m.matchType.toLowerCase();
      if(mynum == 1)
      return type.contains('odi');
      if(mynum == 2)
      return type.contains('t20');
      if(mynum == 3)
      return type.contains('test');
      return true;
    }).toList()
    ;
            if (MyMatches.isEmpty) {
              return Scaffold(
                backgroundColor: Colors.blueGrey[900],
                appBar: AppBar(
                  title: const Text('Cricket[A]pp'),
                  centerTitle: true,
                  backgroundColor: Colors.blueGrey[800],
                  iconTheme: IconThemeData(color: Colors.white),
                ),
                 endDrawer: Drawer(
                backgroundColor: Colors.blueGrey[800],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: 
                      ListView(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            child: Icon(Icons.person, size: 39),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Email',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color.fromARGB(155, 255, 255, 255),
                            ),
                          ),
                          Text(
                            (FirebaseAuth.instance.currentUser?.email.toString() ??
                                'No Emai'),
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(height: 10),
                          Divider(color: const Color.fromARGB(57, 255, 255, 255)),
                          ListTile(
                            title: Text(
                              '💗  Favorites',
                              style: TextStyle(color: Colors.white),
                            ),
                            onTap: () {
                              if (matchMode.isNotEmpty) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        Favorite(matchmodel: matchMode),
                                  ),
                                );
                              }
                            },
                          ),
                          Divider(color: const Color.fromARGB(57, 255, 255, 255)),
                          
                          ListTile(
                            title: Row(
                              children: [
                                Text('All Matches',style: TextStyle(
                                  color: Colors.white
                                ),),
                                Spacer(),
                                Icon(
                                 mynum == 0
                                 ?Icons.check
                                 : null,color: Colors.white,
                                )
                              ],
                            ),
                            onTap: (){
                              setState(() {
                                mynum=0;
                              });
                               loadData();
                            },
                          ),
                          Divider(color: const Color.fromARGB(57, 255, 255, 255)),
                          ListTile(
                            title: Row(
                              children: [
                                Text('ODI Matches',style: TextStyle(
                                  color: Colors.white
                                ),),
                                Spacer(),
                                Icon(
                                 mynum == 1
                                 ?Icons.check
                                 : null,color: Colors.white,
                                )
                              ],
                            ),
                            onTap: (){
                              setState(() {
                                mynum=1;
                              });
                               loadData();
                            },
                          ),
                          Divider(color: const Color.fromARGB(57, 255, 255, 255)),
                          ListTile(
                            title: Row(
                              children: [
                                Text('T20 Matches',style: TextStyle(
                                  color: Colors.white
                                ),),
                                Spacer(),
                                Icon(
                                 mynum == 2
                                 ?Icons.check
                                 : null,color: Colors.white,
                                )
                              ],
                            ),
                            onTap: (){
                              setState(() {
                                mynum=2;
                              });
                              loadData();
                            },
                          ),
                        Divider(color: const Color.fromARGB(57, 255, 255, 255)),
                          ListTile(
                            title: Row(
                              children: [
                                Text('Test Matches',style: TextStyle(
                                  color: Colors.white
                                ),),
                                Spacer(),
                                Icon(
                                 mynum == 3
                                 ?Icons.check
                                 : null,color: Colors.white,
                                )
                              ],
                            ),
                            onTap: (){
                              setState(() {
                                mynum=3;
                              });
                              loadData();
                            },
                          ),
                           Divider(color: const Color.fromARGB(57, 255, 255, 255)),
                          ListTile(
                            title: Row(
                              children: [
                                Icon(Icons.logout, color: Colors.white),
                                SizedBox(width: 5,),
                                Text(
                                  'Logout',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            onTap: () => SignOut(),
                          ),
                          Divider(color: const Color.fromARGB(57, 255, 255, 255)),
                           SizedBox(height: 100,),
                            
                          Text('version 1.0.0',textAlign: TextAlign.center,)
                       
                    ],
                  ),
                ),
              ),
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.sports_cricket,
                        color: Colors.white,
                        size: 40,
                      ),
                      const Text(
                        'No Matches Available',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 15),
                      uiheler.button(() {
                        ref.invalidate(fetchApi);
                      }, 'Retry'),
                    ],
                  ),
                ),
              );
            }
            return Scaffold(
              backgroundColor: Colors.blueGrey[900],
              appBar: AppBar(
                title: const Text('Cricket[A]pp'),
                centerTitle: true,
                backgroundColor: Colors.blueGrey[800],
                iconTheme: IconThemeData(color: Colors.white),
              ),
              endDrawer: Drawer(
                backgroundColor: Colors.blueGrey[800],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: 
                      ListView(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            child: Icon(Icons.person, size: 39),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Email',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color.fromARGB(155, 255, 255, 255),
                            ),
                          ),
                          Text(
                            (FirebaseAuth.instance.currentUser?.email.toString() ??
                                'No Emai'),
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(height: 10),
                          Divider(color: const Color.fromARGB(57, 255, 255, 255)),
                          ListTile(
                            title: Text(
                              '💗  Favorites',
                              style: TextStyle(color: Colors.white),
                            ),
                            onTap: () {
                              if (matchMode.isNotEmpty) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        Favorite(matchmodel: matchMode),
                                  ),
                                );
                              }
                            },
                          ),
                          Divider(color: const Color.fromARGB(57, 255, 255, 255)),
                          
                          ListTile(
                            title: Row(
                              children: [
                                Text('All Matches',style: TextStyle(
                                  color: Colors.white
                                ),),
                                Spacer(),
                                Icon(
                                 mynum == 0
                                 ?Icons.check
                                 : null,color: Colors.white,
                                )
                              ],
                            ),
                            onTap: (){
                              setState(() {
                                mynum=0;
                              });
                               loadData();
                            },
                          ),
                          Divider(color: const Color.fromARGB(57, 255, 255, 255)),
                          ListTile(
                            title: Row(
                              children: [
                                Text('ODI Matches',style: TextStyle(
                                  color: Colors.white
                                ),),
                                Spacer(),
                                Icon(
                                 mynum == 1
                                 ?Icons.check
                                 : null,color: Colors.white,
                                )
                              ],
                            ),
                            onTap: (){
                              setState(() {
                                mynum=1;
                              });
                               loadData();
                            },
                          ),
                          Divider(color: const Color.fromARGB(57, 255, 255, 255)),
                          ListTile(
                            title: Row(
                              children: [
                                Text('T20 Matches',style: TextStyle(
                                  color: Colors.white
                                ),),
                                Spacer(),
                                Icon(
                                 mynum == 2
                                 ?Icons.check
                                 : null,color: Colors.white,
                                )
                              ],
                            ),
                            onTap: (){
                              setState(() {
                                mynum=2;
                              });
                              loadData();
                            },
                          ),
                        Divider(color: const Color.fromARGB(57, 255, 255, 255)),
                          ListTile(
                            title: Row(
                              children: [
                                Text('Test Matches',style: TextStyle(
                                  color: Colors.white
                                ),),
                                Spacer(),
                                Icon(
                                 mynum == 3
                                 ?Icons.check
                                 : null,color: Colors.white,
                                )
                              ],
                            ),
                            onTap: (){
                              setState(() {
                                mynum=3;
                              });
                              loadData();
                            },
                          ),
                           Divider(color: const Color.fromARGB(57, 255, 255, 255)),
                          ListTile(
                            title: Row(
                              children: [
                                Icon(Icons.logout, color: Colors.white),
                                SizedBox(width: 5,),
                                Text(
                                  'Logout',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            onTap: () => SignOut(),
                          ),
                          Divider(color: const Color.fromARGB(57, 255, 255, 255)),
                           SizedBox(height: 100,),
                            
                          Text('version 1.0.0',textAlign: TextAlign.center,)
                       
                    ],
                  ),
                ),
              ),

              body: Container(
                child: RefreshIndicator(
                  onRefresh: loadData,
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: MyMatches.length,
                    itemBuilder: (context,index){
                      return Cicketcard(matchmodel:MyMatches[index]);
                    },
                  ),
                ),
              ),
            );
          },
          error: (error, stackTrace) {
            if (error is SocketException) {
              return Scaffold(
                backgroundColor: Colors.blueGrey[900],
                appBar: AppBar(
                  title: const Text('Cricket[A]pp'),
                  centerTitle: true,
                  backgroundColor: Colors.blueGrey[800],
                  iconTheme: IconThemeData(color: Colors.white),
                ),
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.wifi_off, color: Colors.white, size: 40),
                      const Text(
                        'Check Your Internet Connection',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 15),
                      uiheler.button(() {
                        ref.invalidate(fetchApi);
                      }, 'Retry'),
                    ],
                  ),
                ),
              );
            } else {
              return Scaffold(
                backgroundColor: Colors.blueGrey[900],
                appBar: AppBar(
                  title: const Text('Cricket[A]pp'),
                  centerTitle: true,
                  backgroundColor: Colors.blueGrey[800],
                  iconTheme: IconThemeData(color: Colors.white),
                ),
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.cloud_off, color: Colors.white, size: 41),
                      Text(
                        'Faied to loadData',
                        style: TextStyle(color: Colors.white),
                      ),
                      uiheler.button(() {
                        loadData();
                      }, 'Retry'),
                    ],
                  ),
                ),
              );
            }
          },
          loading: () {
            return Scaffold(
              backgroundColor: Colors.blueGrey[900],
              appBar: AppBar(
                title: const Text('Cricket[A]pp'),
                centerTitle: true,
                backgroundColor: Colors.blueGrey[800],
                iconTheme: IconThemeData(color: Colors.white),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 9),
                    Text('Please Wait', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            );
          },
        );
  }
}
