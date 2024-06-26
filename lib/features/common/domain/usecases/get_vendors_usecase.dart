import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/common/data/models/generic_pagination.dart';
import 'package:i_watt_app/features/common/domain/entities/get_vendors_params_entity.dart';
import 'package:i_watt_app/features/common/domain/entities/id_name_entity.dart';
import 'package:i_watt_app/features/common/domain/repositories/vendors_repository.dart';

class GetVendorsUseCase implements UseCase<GenericPagination<IdNameEntity>, GetVendorsParams> {
  final VendorsRepository repository;
  GetVendorsUseCase(this.repository);
  @override
  Future<Either<Failure, GenericPagination<IdNameEntity>>> call(GetVendorsParams params) async {
    return repository.getVendors(next: params.next, searchPattern: params.searchPattern);
  }
}
