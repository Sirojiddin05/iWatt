part of 'save_un_save_bloc.dart';

@immutable
abstract class SaveUnSaveEvent {
  const SaveUnSaveEvent();
}

class SaveEvent extends SaveUnSaveEvent {
  const SaveEvent();
}
