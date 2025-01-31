import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:genio/main.dart';
import 'dashboard_page.dart';

class AnalisisPage extends StatelessWidget {
  final String videoTitle;
  final String videoPath;

  AnalisisPage({required this.videoTitle, required this.videoPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Analisis Video'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => DashboardPage()), // Halaman Dashboard
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                videoTitle,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Container(
                height: 200,
                child: VideoPlayerWidget(videoPath: videoPath),
              ),
              SizedBox(height: 16),
              Text(
                'Analisis Data',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Hasil analisis video berdasarkan data dari AI dan algoritma pemrosesan citra.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              CustomLineChart(),
              SizedBox(height: 16),
              CustomBarChart(),
              SizedBox(height: 16),
              CustomPieChart(),
            ],
          ),
        ),
      ),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoPath;
  VideoPlayerWidget({required this.videoPath});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoPath)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )
        : Center(child: CircularProgressIndicator());
  }
}

// Grafik Garis Sederhana dengan CustomPaint
class CustomLineChart extends StatelessWidget {
  final List<double> data = [3.1, 4.0, 3.5, 5.0, 4.2, 6.0]; // Contoh data

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: CustomPaint(
        size: Size(double.infinity, 200),
        painter: LineChartPainter(data),
      ),
    );
  }
}

class LineChartPainter extends CustomPainter {
  final List<double> data;

  LineChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final path = Path();

    double xInterval = size.width / (data.length - 1);
    double yMax = data.reduce((a, b) => a > b ? a : b);
    double yScale = size.height / yMax;

    for (int i = 0; i < data.length; i++) {
      double x = i * xInterval;
      double y = size.height - data[i] * yScale;

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);

    // Gambar titik-titik data
    final dotPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    for (int i = 0; i < data.length; i++) {
      double x = i * xInterval;
      double y = size.height - data[i] * yScale;
      canvas.drawCircle(Offset(x, y), 4, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

// Grafik Batang Sederhana dengan CustomPaint
class CustomBarChart extends StatelessWidget {
  final List<double> data = [3.1, 4.0, 3.5, 5.0, 4.2, 6.0]; // Contoh data

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: CustomPaint(
        size: Size(double.infinity, 200),
        painter: BarChartPainter(data),
      ),
    );
  }
}

class BarChartPainter extends CustomPainter {
  final List<double> data;

  BarChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;

    double barWidth = size.width / data.length;
    double yMax = data.reduce((a, b) => a > b ? a : b);
    double yScale = size.height / yMax;

    for (int i = 0; i < data.length; i++) {
      double x = i * barWidth;
      double y = size.height - data[i] * yScale;

      canvas.drawRect(
        Rect.fromLTWH(x, y, barWidth - 10, size.height - y),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

// Grafik Pie Sederhana dengan CustomPaint
class CustomPieChart extends StatelessWidget {
  final List<double> data = [3.1, 4.0, 3.5, 5.0, 4.2, 6.0]; // Contoh data

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: CustomPaint(
        size: Size(double.infinity, 200),
        painter: PieChartPainter(data),
      ),
    );
  }
}

class PieChartPainter extends CustomPainter {
  final List<double> data;

  PieChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill;

    double total = data.reduce((a, b) => a + b);
    double startAngle = -90 * (3.141592653589793 / 180); // Mulai dari atas

    for (int i = 0; i < data.length; i++) {
      paint.color = Colors.primaries[i % Colors.primaries.length];
      double sweepAngle = (data[i] / total) * 360 * (3.141592653589793 / 180);

      canvas.drawArc(
        Rect.fromLTWH(0, 0, size.width, size.height),
        startAngle,
        sweepAngle,
        true,
        paint,
      );

      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}