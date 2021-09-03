import 'package:get_it/get_it.dart';

import 'bloc_module.dart';
import 'repositories_module.dart';
import 'usecase_module.dart';

GetIt get injector => GetIt.instance;

void initInjector() {
  initRepositoryModule();
  initUseCaseModule();
  initBlocModule();
}
