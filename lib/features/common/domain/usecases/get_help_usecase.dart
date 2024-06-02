import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/common/domain/entities/help_entity.dart';
import 'package:i_watt_app/features/common/domain/repositories/about_us_repository.dart';

class GetHelpUseCase implements UseCase<HelpEntity, NoParams> {
  final AboutUsRepository repository;

  GetHelpUseCase(this.repository);

  @override
  Future<Either<Failure, HelpEntity>> call(NoParams params) async => await repository.getHelp();
}
