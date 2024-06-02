class CommandResultMessageEntity {
  final int commandId;
  final bool status;

  const CommandResultMessageEntity({
    this.commandId = -1,
    this.status = false,
  });
}
