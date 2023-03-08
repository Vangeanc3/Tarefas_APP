import 'dart:ffi';

class Shuffle {
  bool sucess;
  String deck_id;
  bool shuffled;
  int remaining;

  Shuffle({
    required this.sucess,
    required this.deck_id,
    required this.shuffled,
    required this.remaining,
  });
}
