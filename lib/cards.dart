library cards;

import 'dart:math';
import 'package:web_ui/web_ui.dart';

class Card {
  String _suit; //an underscore denotes that this variable is private to the library.
  String _rank;
  String _img;
 
  Card(); //we could put info into this constructor like "(this._suit, this._rank, this._img)"
  
  Card.fromMap(Map<String, String> map) {
    _suit = map["suit"];
    _rank = map["rank"];
    _img = map["img"];
  }
  
  String toString() {
    String suitStr = "";
    
    //jokers don't have a suit
    if(_suit != null) {
      suitStr = " of $_suit";
    }
    
    return "$_rank$suitStr"; //we put a space up above and NOT here, because otherwise Jokers would read as "Joker " (with a space)
  }
  
  String get suit => _suit;
  String get rank => _rank;
  String get img => _img;
}

class CardDeck {
  String _backImg;
  bool _includeJokers;
  @observable List<Card> cards = [];
  
  CardDeck({bool includeJokers: false}) {
    _includeJokers = includeJokers;  
  }
  
  CardDeck.fromMap(Map<String, Object> map, {bool includeJokers: false}) {
    _includeJokers = includeJokers;
    
    _backImg = map["backImg"];
    
    List<Map<String, String>> cardMaps = map["cards"]; //we're doing this so we can use functions on it! like .forEach
    List<Card> cardList = [];
    
    cardMaps.forEach((Map<String, String> card) {
      //jokers don't have a suit, bro.
      if (card["suit"] == null && !_includeJokers) { //if the card is a joker, and we aren't including jokers, return.
        return;                                      //otherwise we'll add the joker!
      }
      
      cardList.add(new Card.fromMap(card));
    });
    
    cards = toObservable(cardList);
  }

  void shuffle() {
    Card temp;
    int randomIndex;
    
    for (int i = 0; i < cards.length; i++) {
      //select random cards to swap with
      randomIndex = new Random().nextInt(cards.length);
      
      //do the swap
      temp = cards[i];
      cards[i] = cards[randomIndex];
      cards[randomIndex] = temp;
    }
  }
  
  String toString() {
    StringBuffer sb = new StringBuffer();
    
    cards.forEach((Card card) => sb.writeln(card));
  
    return sb.toString();
  }

}

  






