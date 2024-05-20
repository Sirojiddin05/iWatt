enum NavItemEnum {
  map,
  list,
  chargingProcesses,
  profile;

  bool get isHome => this == NavItemEnum.map;
  bool get isList => this == NavItemEnum.list;
  bool get isChargers => this == NavItemEnum.chargingProcesses;
  bool get isProfile => this == NavItemEnum.profile;
}
