import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _dismissedCardsKey = 'dismissed_cards';
  static const String _remindLaterCardsKey = 'remind_later_cards';

  final SharedPreferences _prefs;

  StorageService(this._prefs);

  static Future<StorageService> init() async {
    final prefs = await SharedPreferences.getInstance();
    return StorageService(prefs);
  }

  List<String> getDismissedCards() {
    return _prefs.getStringList(_dismissedCardsKey) ?? [];
  }

  Future<bool> dismissCard(String cardId) async {
    final dismissedCards = getDismissedCards();
    if (!dismissedCards.contains(cardId)) {
      dismissedCards.add(cardId);
      return await _prefs.setStringList(_dismissedCardsKey, dismissedCards);
    }
    return true;
  }

  List<String> getRemindLaterCards() {
    return _prefs.getStringList(_remindLaterCardsKey) ?? [];
  }

  Future<bool> remindLater(String cardId) async {
    final remindLaterCards = getRemindLaterCards();
    if (!remindLaterCards.contains(cardId)) {
      remindLaterCards.add(cardId);
      return await _prefs.setStringList(_remindLaterCardsKey, remindLaterCards);
    }
    return true;
  }

  Future<bool> clearRemindLaterCards() async {
    return await _prefs.remove(_remindLaterCardsKey);
  }

  bool isCardHidden(String cardId) {
    return getDismissedCards().contains(cardId) ||
        getRemindLaterCards().contains(cardId);
  }
}
