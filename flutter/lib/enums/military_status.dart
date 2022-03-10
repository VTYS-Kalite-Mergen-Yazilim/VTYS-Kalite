enum MilitaryStatusEnum {
  done,
  notDone,
  exempt,
  deferred,
}

extension MilitaryStatusEnumExtension on MilitaryStatusEnum {
  static List<String> getList() {
    List<String> militaryStatusList = [];
    for (var item in MilitaryStatusEnum.values) {
      militaryStatusList.add(item.getName);
    }
    return militaryStatusList;
  }

  String get getName {
    switch (this) {
      case MilitaryStatusEnum.done:
        return "Yapıldı";
      case MilitaryStatusEnum.notDone:
        return "Yapılmadı";
      case MilitaryStatusEnum.exempt:
        return "Muaf";
      case MilitaryStatusEnum.deferred:
        return "Tecilli";
      default:
        return "";
    }
  }

  static getEnumFromName(name) {
    return MilitaryStatusEnum
        .values[MilitaryStatusEnumExtension.getList().indexOf(name)];
  }
}
