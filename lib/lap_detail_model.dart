enum TyreCompound { soft, medium, hard, intermediate, wet }

enum WearPattern { uneven, inner, outer, center, even }

enum TyreColor { matteBlack, glossyBlack, purpleTin, greyBlack, paleGrey }

class TyreModel {
  final int lapNumber;
  final TyreCompound compound;
  final TyreDetailModel frontLeft;
  final TyreDetailModel frontRight;
  final TyreDetailModel rearLeft;
  final TyreDetailModel rearRight;

  TyreModel({
    required this.lapNumber,
    required this.compound,
    required this.frontLeft,
    required this.frontRight,
    required this.rearLeft,
    required this.rearRight,
  });
}

class TyreDetailModel {
  final TyreColor color;
  final WearPattern wearPattern;
  final bool sidewallDefomation;
  final bool isGraining;
  final int tyrePressure;
  final int tyreTemperature;
  final int trackTemperature;

  TyreDetailModel({
    required this.color,
    required this.wearPattern,
    required this.sidewallDefomation,
    required this.isGraining,
    required this.tyrePressure,
    required this.tyreTemperature,
    required this.trackTemperature,
  });
}
