import '../data_interfaces/i_preferences_repository.dart';

class SettingsUseCase {
  final IPreferencesRepository preferencesRepository;

  SettingsUseCase(this.preferencesRepository);

  Future<bool> isDarkTheme() async {
    return preferencesRepository.isDarkTheme();
  }

  void saveTheme(bool isDarkTheme) async {
    preferencesRepository.saveTheme(isDarkTheme);
  }

  Future<bool> biometricsLockEnabled() async {
    return preferencesRepository.biometricsLockEnabled();
  }

  void saveBiometricsMode(bool enabled) async {
    preferencesRepository.saveBiometricsMode(enabled);
  }

  Future<bool> bubbleAlignment() async {
    return preferencesRepository.bubbleAlignment();
  }

  void saveBubbleAlignment(bool enabled) async {
    preferencesRepository.saveBubbleAlignment(enabled);
  }

  Future<bool> dateTimeModificationEnabled() async {
    return preferencesRepository.dateTimeModificationEnabled();
  }

  void saveDateTimeModification(bool enabled) async {
    preferencesRepository.saveDateTimeModification(enabled);
  }

  Future<int?> fontSize() async {
    return preferencesRepository.fontSize();
  }

  void saveFontSize(int fontSize) async {
    preferencesRepository.saveFontSize(fontSize);
  }

  void resetAll() async {
    preferencesRepository.resetAll();
  }
}
