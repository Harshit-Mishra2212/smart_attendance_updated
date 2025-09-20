import 'package:flutter/material.dart';

class StudentClassGraph extends StatefulWidget {
  final String className;
  final int present;
  final int total;

  const StudentClassGraph({
    super.key,
    required this.className,
    required this.present,
    required this.total,
  });

  @override
  State<StudentClassGraph> createState() => _StudentClassGraphState();
}

class _StudentClassGraphState extends State<StudentClassGraph>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Controller for 1.5 seconds animation
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Tween from 0 → ratio
    _animation = Tween<double>(
      begin: 0,
      end: widget.present / widget.total,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    // Start animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ratio = widget.present / widget.total;

    return Scaffold(
      appBar: AppBar(title: Text("Attendance - ${widget.className}")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                double currentRatio = _animation.value;

                return Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    // Red background line
                    Container(
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    // Green animated line
                    FractionallySizedBox(
                      widthFactor: currentRatio,
                      child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    // Present number follows green bar
                    Positioned(
                      left: (currentRatio *
                              MediaQuery.of(context).size.width) -
                          60,
                      child: Text(
                        "${(widget.present * currentRatio / ratio).round()}",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 12),
            // Total number below red line
            Text(
              "Total Classes: ${widget.total}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}