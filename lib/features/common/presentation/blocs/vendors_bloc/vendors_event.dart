part of 'vendors_bloc.dart';

abstract class VendorsEvent {}

class GetVendorsEvent extends VendorsEvent {
  GetVendorsEvent();
}

class GetMoreVendorsEvent extends VendorsEvent {
  GetMoreVendorsEvent();
}

class SearchVendorsEvent extends VendorsEvent {
  final String searchPattern;
  SearchVendorsEvent({required this.searchPattern});
}
