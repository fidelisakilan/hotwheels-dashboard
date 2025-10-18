import 'package:f1_analyzer/lap_detail_model.dart';
import 'package:flutter/material.dart';

class LapListWidget extends StatefulWidget {
  const LapListWidget({super.key, required this.laps, required this.onTap});
  final List<TyreModel> laps;
  final Function(int) onTap;

  @override
  State<LapListWidget> createState() => _LapListWidgetState();
}

class _LapListWidgetState extends State<LapListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.laps.length,
      itemBuilder: (context, index) {
        final lap = widget.laps[index];
        return ListTile(
          onTap: () => widget.onTap(index),
          title: Text(
            "Lap ${lap.lapNumber}",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          trailing: Text(
            "Compound: ${lap.compound.toString().split('.').last}",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        );
      },
    );
  }
}
