abstract class IPreferencesRepository {
  Future<bool> isDarkTheme();
  void saveTheme(bool isDarkTheme);
  Future<bool> biometricsLockEnabled();
  void saveBiometricsMode(bool enabled);
  Future<bool> bubbleAlignment();
  void saveBubbleAlignment(bool enabled);
  Future<bool> dateTimeModificationEnabled();
  void saveDateTimeModification(bool enabled);
  Future<int?> fontSize();
  void saveFontSize(int fontSize);
  void resetAll();
}