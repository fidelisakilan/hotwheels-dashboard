import 'package:f1_analyzer/lap_detail_bloc.dart';
import 'package:f1_analyzer/lap_detail_model.dart';
import 'package:f1_analyzer/lap_detail_widget.dart';
import 'package:f1_analyzer/lap_list_widget.dart';
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
        title: Text("HotWheels"),
        centerTitle: true,
        backgroundColor: Colors.red.shade50,
      ),
      body: StreamBuilder<List<TyreModel>>(
        stream: bloc.lapDetailsStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Row(
              children: [
                Expanded(
                  child: LapListWidget(
                    laps: snapshot.data!,
                    onTap: setSelectedIndex,
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
    );
  }
}
