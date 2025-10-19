import 'package:f1_analyzer/model/lap_detail_model.dart';
import 'package:flutter/material.dart';

class LapListWidget extends StatefulWidget {
  const LapListWidget({
    super.key,
    required this.laps,
    required this.onTap,
    required this.selectedIndex,
  });
  final List<TyreModel> laps;
  final int selectedIndex;
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
          selectedTileColor: index == widget.selectedIndex
              ? const Color(0xFFE10600) // F1 red background when selected
              : null,
          selected: index == widget.selectedIndex,
          title: Row(
            children: [
              Text(
                "Lap ${lap.lapNumber}",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: index == widget.selectedIndex
                      ? Colors
                            .white // White text when selected
                      : null, // Default theme color when not selected
                ),
              ),
              Spacer(),
              TyreIconWidget(compound: lap.compound),
            ],
          ),
        );
      },
    );
  }
}

class TyreIconWidget extends StatelessWidget {
  final TyreCompound compound;

  const TyreIconWidget({super.key, required this.compound});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.black, shape: BoxShape.circle),
      padding: const EdgeInsets.all(2),
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle,
          border: Border.all(color: compound.color, width: 2.5),
        ),
        child: Center(
          child: Text(
            compound.displayName[0],
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
