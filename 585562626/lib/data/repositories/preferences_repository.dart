import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/data_interfaces/i_preferences_repository.dart';
import '../../../shared/utils.dart';

class PreferencesRepository extends IPreferencesRepository {
  static SharedPreferences? _prefs;
  static final String themeKey = 'app_theme';
  static final String biometricsLockKey = 'biometrics_lock';
  static final String bubbleAlignmentKey = 'bubble_alignment';
  static final String dateTimeModificationKey = 'date_time_modification';
  static final String fontSizeKey = 'font_size';

  Future<SharedPreferences> get prefs async {
    if (_prefs != null) {
      return _prefs!;
    }
    _prefs = await SharedPreferences.getInstance();
    return _prefs!;
  }

  @override
  Future<bool> isDarkTheme() async {
    final prefs = await this.prefs;
    return prefs.getBool(themeKey) ?? false;
  }

  @override
  void saveTheme(bool isDarkTheme) async {
    final prefs = await this.prefs;
    prefs.setBool(themeKey, isDarkTheme);
  }

  @override
  Future<bool> biometricsLockEnabled() async {
    final prefs = await this.prefs;
    return prefs.getBool(biometricsLockKey) ?? false;
  }

  @override
  void saveBiometricsMode(bool enabled) async {
    final prefs = await this.prefs;
    prefs.setBool(biometricsLockKey, enabled);
  }

  @override
  Future<bool> bubbleAlignment() async {
    final prefs = await this.prefs;
    return prefs.getBool(bubbleAlignmentKey) ?? false;
  }

  @override
  void saveBubbleAlignment(bool enabled) async {
    final prefs = await this.prefs;
    prefs.setBool(bubbleAlignmentKey, enabled);
  }

  @override
  Future<bool> dateTimeModificationEnabled() async {
    final prefs = await this.prefs;
    return prefs.getBool(dateTimeModificationKey) ?? false;
  }

  @override
  void saveDateTimeModification(bool enabled) async {
    final prefs = await this.prefs;
    prefs.setBool(dateTimeModificationKey, enabled);
  }

  @override
  Future<int?> fontSize() async {
    final prefs = await this.prefs;
    return prefs.getInt(fontSizeKey);
  }

  @override
  void saveFontSize(int fontSize) async {
    final prefs = await this.prefs;
    prefs.setInt(fontSizeKey, fontSize);
  }

  @override
  void resetAll() async {
    final prefs = await this.prefs;
    prefs.setBool(themeKey, false);
    prefs.setBool(bubbleAlignmentKey, false);
    prefs.setBool(dateTimeModificationKey, false);
    prefs.setInt(fontSizeKey, defaultFontSizeIndex);
    prefs.setBool(biometricsLockKey, false);
  }
}
