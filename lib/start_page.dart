import 'package:f1_analyzer/bloc/lap_detail_bloc.dart';
import 'package:f1_analyzer/model/lap_detail_model.dart';
import 'package:f1_analyzer/widgets/lap_detail_widget.dart';
import 'package:f1_analyzer/widgets/lap_list_widget.dart';
import 'package:flutter/material.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final LapDetailBloc bloc = LapDetailBloc();
  int selectedIndex = 0;

  void setSelectedIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    bloc.fetchLapDetails();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'HotWheels',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(color: Colors.white),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0A0A0A), Color(0xFF1A1A1A), Color(0xFF0F0F0F)],
          ),
        ),
        child: StreamBuilder<List<TyreModel>>(
          stream: bloc.lapDetailsStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Row(
                children: [
                  SizedBox(
                    width: 200,
                    child: LapListWidget(
                      laps: snapshot.data!,
                      onTap: setSelectedIndex,
                      selectedIndex: selectedIndex,
                    ),
                  ),
                  Expanded(
                    child: LapDetailWidget(tyre: snapshot.data![selectedIndex]),
                  ),
                ],
              );
            } else {
              return LinearProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
