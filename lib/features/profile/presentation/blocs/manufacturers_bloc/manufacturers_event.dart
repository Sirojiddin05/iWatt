part of 'manufacturers_bloc.dart';

@immutable
abstract class ManufacturersEvent {}

class GetManufacturers extends ManufacturersEvent {
  GetManufacturers();
}

class GetMoreManufacturers extends ManufacturersEvent {
  GetMoreManufacturers();
}

class SearchManufacturers extends ManufacturersEvent {
  final String searchQuery;

  SearchManufacturers(this.searchQuery);
}
