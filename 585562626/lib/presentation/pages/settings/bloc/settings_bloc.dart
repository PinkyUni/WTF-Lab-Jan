import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';

import '../../../../../domain/usecases/settings_usecase.dart';
import '../../../../domain/enums.dart';
import '../bloc/bloc.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsUseCase settingsUseCase;

  SettingsBloc({
    required this.settingsUseCase,
    SettingsState initialState = const InitialSettingsState(),
  }) : super(initialState) {
    add(const InitSettingsEvent());
  }

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if (event is InitSettingsEvent) {
      final _localAuthentication = LocalAuthentication();
      final biometrics = await _localAuthentication.getAvailableBiometrics();
      final canCheckBiometrics = biometrics.contains(BiometricType.fingerprint);
      yield await _init(canCheckBiometrics);
    } else if (state is MainSettingsState) {
      final currentState = state as MainSettingsState;
      if (event is UpdateBiometricsEvent) {
        settingsUseCase.saveBiometricsMode(event.checkBiometrics);
        yield currentState.copyWith(
          checkBiometrics:
              event.checkBiometrics ? BiometricsCheck.enabled : BiometricsCheck.disabled,
        );
      } else if (event is SwitchThemeEvent) {
        final newMode = !currentState.isDarkMode;
        settingsUseCase.saveTheme(newMode);
        yield currentState.copyWith(isDarkMode: newMode);
      } else if (event is UpdateAlignmentEvent) {
        final newMode = !currentState.isRightBubbleAlignment;
        settingsUseCase.saveBubbleAlignment(newMode);
        yield currentState.copyWith(isRightBubbleAlignment: newMode);
      } else if (event is UpdateDateTimeModificationEvent) {
        final newMode = !currentState.isDateTimeModificationEnabled;
        settingsUseCase.saveDateTimeModification(newMode);
        yield currentState.copyWith(isDateTimeModificationEnabled: newMode);
      } else if (event is UpdateFontSizeEvent) {
        settingsUseCase.saveFontSize(event.fontSize.index);
        yield currentState.copyWith(fontSize: event.fontSize);
      } else if (event is ResetSettingsEvent) {
        settingsUseCase.resetAll();
        yield await _init(currentState.canCheckBiometrics);
      }
    }
  }

  Future<SettingsState> _init(bool canCheckBiometrics) async {
    final isBiometricsEnabled = await settingsUseCase.biometricsLockEnabled();
    final isDarkMode = await settingsUseCase.isDarkTheme();
    final isLeftAlignment = await settingsUseCase.bubbleAlignment();
    final isDateTimeModificationEnabled = await settingsUseCase.dateTimeModificationEnabled();
    final fontSizeIndex = await settingsUseCase.fontSize();
    return MainSettingsState(
      showBiometricsDialog: isBiometricsEnabled,
      isRightBubbleAlignment: isLeftAlignment,
      isDateTimeModificationEnabled: isDateTimeModificationEnabled,
      isDarkMode: isDarkMode,
      canCheckBiometrics: canCheckBiometrics,
      checkBiometrics: canCheckBiometrics
          ? (isBiometricsEnabled ? BiometricsCheck.enabled : BiometricsCheck.disabled)
          : BiometricsCheck.notAvailable,
      fontSize: SettingsFontSize.values[fontSizeIndex ?? SettingsFontSize.normal.index],
    );
  }
}
