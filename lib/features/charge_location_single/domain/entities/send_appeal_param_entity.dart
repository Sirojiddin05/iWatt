class SendAppealParams {
  final int id;
  final int location;
  final String otherAppeal;

  SendAppealParams({required this.id, required this.location, this.otherAppeal = ''});
}
