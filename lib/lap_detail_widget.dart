import 'package:f1_analyzer/lap_detail_model.dart';
import 'package:flutter/material.dart';

class LapDetailWidget extends StatefulWidget {
  const LapDetailWidget({super.key, required this.tyre});
  final TyreModel tyre;
  @override
  State<LapDetailWidget> createState() => _LapDetailWidgetState();
}

class _LapDetailWidgetState extends State<LapDetailWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Lap ${widget.tyre.lapNumber} ${widget.tyre.compound.toString().split('.').last}",
      ),
    );
  }
}
