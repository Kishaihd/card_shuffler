/* making an application that... shuffles cards! */

library card_shuffler;

import 'dart:html';
import 'package:web_ui/web_ui.dart';
import 'dart:async';
import 'dart:json' as JSON;
import 'package:card_shuffler/cards.dart';

//constants (paths are relative to "out" folder)
const String CARD_DECK_DATA = "../../data/card_deck.json";
@observable const String CARD_IMAGE_PATH = "../../images/cards";

// creating the deck here prevents the bindings from throwing "null" exceptions
@observable CardDeck cardDeck = new CardDeck();

void main() {
  print("main()");
  
//  //Future is for asyncronous programming, it's for calling a function that will do something/activate in the future.
//  Future httpFuture = HttpRequest.getString(CARD_DECK_DATA);
//  httpFuture.then(onValue, onError: );
  
  //HttpRequest is sending an http request to a server to get a String(CARD_DECK_DATA)
  // .then is saying, "WHEN the thing we've requested from the HttpRequest arrives, THEN(do this function!)"
    HttpRequest.getString(CARD_DECK_DATA).then(onJSONLoaded, onError: onJSONError);
}

void onJSONLoaded(String jsonStr) {
  print("onJSONLoaded()");
  
  cardDeck = new CardDeck.fromMap(JSON.parse(jsonStr)/*, includeJokers: true*/);
  
  print(cardDeck);
  
  cardDeck.shuffle();
  
  print("\nShuffled Deck: \n");
  print(cardDeck);
  
//  Map map = JSON.parse(jsonStr); 
//  
//  print(map);
//  
//  Card testCard = new Card.fromMap(map["cards"][52]);
//  print(testCard.toString()); //if you don't include the .toString, print() should still take care of it.

}

//debugging help. the ".type" function shows what TYPE of error!
void onJSONError(HttpRequestProgressEvent error) {
  print("Error: ${error.type}");
}










