import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class BarChartSample2 extends StatefulWidget {
  final List<double> maxTemps;
  final List<double> minTemps;

  const BarChartSample2({
    super.key,
    required this.maxTemps,
    required this.minTemps,
  });

  final Color leftBarColor = Colors.red;
  final Color rightBarColor = Colors.blue;

  @override
  State<StatefulWidget> createState() => BarChartSample2State();
}

class BarChartSample2State extends State<BarChartSample2> {
  final double width = 7;
  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex = -1;

  @override
  void initState() {
    super.initState();

    final barGroups = List.generate(7, (index) {
      return makeGroupData(
        index,
        widget.minTemps[index],
        widget.maxTemps[index],
      );
    });

    rawBarGroups = barGroups;
    showingBarGroups = rawBarGroups;
  }

  @override
  Widget build(BuildContext context) {
    final maxY = widget.maxTemps.reduce(max);

    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 30, 14, 0),
      child: Column(
        children: [
          Expanded(
            child: BarChart(
              BarChartData(
                maxY: maxY,
                minY: 0,
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 50,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          '${value.toStringAsFixed(0)}°C',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                  ),
                  topTitles: AxisTitles(),
                  bottomTitles: AxisTitles(),
                  leftTitles: AxisTitles(),
                ),
                borderData: FlBorderData(show: false),
                barGroups: showingBarGroups,
                gridData: const FlGridData(show: false),
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 0,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y2,
          color: widget.leftBarColor,
          width: width,
        ),
        BarChartRodData(
          toY: y1,
          color: widget.rightBarColor,
          width: width,
        ),
      ],
    );
  }
}
