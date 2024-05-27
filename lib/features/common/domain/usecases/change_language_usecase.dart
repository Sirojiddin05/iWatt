import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/profile/domain/repositories/change_language_repository.dart';

class ChangeLanguageUseCase implements UseCase<void, String> {
  final ChangeLanguageRepository repository;

  const ChangeLanguageUseCase(this.repository);
  @override
  Future<Either<Failure, void>> call(String params) async {
    return await repository.changeLanguage(languageCode: params);
  }
}
