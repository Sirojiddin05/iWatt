import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/common/domain/entities/about_us_entity.dart';
import 'package:i_watt_app/features/common/domain/repositories/about_us_repository.dart';

class GetAboutUsUseCase implements UseCase<AboutUsEntity, NoParams> {
  final AboutUsRepository repository;

  GetAboutUsUseCase(this.repository);

  @override
  Future<Either<Failure, AboutUsEntity>> call(NoParams params) async => await repository.getAboutUs();
}
