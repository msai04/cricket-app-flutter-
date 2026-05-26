
import 'package:hive/hive.dart';

class database {
  final box = Hive.box('Favorite');
  List favlist() {
    return box.get('Favorite', defaultValue: []);
  }

  void loadData(String match) {
    List favlist = box.get('Favorite', defaultValue: []);

    if (favlist.contains(match)) {
      favlist.remove(match);
    } else {
      favlist.add(match);
    }
    box.put('Favorite', favlist);
  }
}
