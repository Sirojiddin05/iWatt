enum CarNumberType {
  individual([1], "INDIVIDUAL"),
  legal([2], "LEGAL"),
  diplomatic([4, 5], "DIPLOMATIC"),
  oon([3], "OON"),
  internationalResident([7], "InternationalResident"),
  internationalOrganization([6], "InternationalOrganization");

  final List<int> type;
  final String value;

  const CarNumberType(this.type, this.value);
}
