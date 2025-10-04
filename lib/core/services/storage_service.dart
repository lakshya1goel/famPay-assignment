import 'package:fam_assignment/core/errors/exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _dismissedCardsKey = 'dismissed_cards';
  static const String _remindLaterCardsKey = 'remind_later_cards';

  final SharedPreferences _prefs;

  StorageService(this._prefs);

  // initialise the storage service
  static Future<StorageService> init() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return StorageService(prefs);
    } catch (e) {
      throw CacheException(message: 'Failed to initialize storage service: ${e.toString()}');
    }
  }

  // get the list of ids of dismissed cards
  List<String> getDismissedCards() {
    try {
      return _prefs.getStringList(_dismissedCardsKey) ?? [];
    } catch (e) {
      throw CacheException(message: 'Failed to get dismissed cards: ${e.toString()}');
    }
  }

  // save the id of a card to be dismissed
  Future<bool> dismissCard(String cardId) async {
    try {
      final dismissedCards = getDismissedCards();
      if (!dismissedCards.contains(cardId)) {
        dismissedCards.add(cardId);
        return await _prefs.setStringList(_dismissedCardsKey, dismissedCards);
      }
      return true;
    } catch (e) {
      throw CacheException(message: 'Failed to dismiss card: ${e.toString()}');
    }
  }

  // get the list of ids of cards that are to be reminded later
  List<String> getRemindLaterCards() {
    try {
      return _prefs.getStringList(_remindLaterCardsKey) ?? [];
    } catch (e) {
      throw CacheException(message: 'Failed to get remind later cards: ${e.toString()}');
    }
  }

  // save the id of a card to be reminded later
  Future<bool> remindLater(String cardId) async {
    try {
      final remindLaterCards = getRemindLaterCards();
      if (!remindLaterCards.contains(cardId)) {
        remindLaterCards.add(cardId);
        return await _prefs.setStringList(_remindLaterCardsKey, remindLaterCards);
      }
      return true;
    } catch (e) {
      throw CacheException(message: 'Failed to remind later: ${e.toString()}');
    }
  }

  // clear the list of ids of cards that are to be reminded later
  Future<bool> clearRemindLaterCards() async {
    try {
      return await _prefs.remove(_remindLaterCardsKey);
    } catch (e) {
      throw CacheException(message: 'Failed to clear remind later cards: ${e.toString()}');
    }
  }
}
