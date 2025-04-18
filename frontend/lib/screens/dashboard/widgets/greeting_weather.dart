import 'package:flutter/material.dart';
import '../../../utils/date_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GreetingWeather extends StatelessWidget {
  const GreetingWeather({super.key});

  Future<String> _getName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userName') ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder<String>(
                future: _getName(),
                builder: (context, snapshot) {
                  String name = snapshot.data ?? '';
                  return Text(
                    "Hi, Good Morning,${name.isNotEmpty ? ' $name' : ''}...",
                    style: const TextStyle(fontSize: 25, color: Colors.white),
                  );
                },
              ),
              const Text(
                "34.0°C",
                style: TextStyle(
                    fontSize: 75, color: Colors.white, letterSpacing: -2),
              ),
              const WeatherInfo(),
            ],
          ),
          const SizedBox(
            width: 50,
          ),
          Column(
            children: [
              const Text(
                "☁️ Partly Cloudy",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
              Text(getCurrentDate(),
                  style: const TextStyle(color: Colors.white, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}

class WeatherInfo extends StatelessWidget {
  final double moisture;
  final double humidity;

  const WeatherInfo({
    super.key,
    this.moisture = 45.0,
    this.humidity = 60.0,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 10),
        const Icon(Icons.water_drop, color: Colors.white),
        Text("${moisture.toStringAsFixed(1)}%",
            style: const TextStyle(color: Colors.white)),
        const SizedBox(width: 40),
        const Icon(Icons.air_rounded, color: Colors.white),
        Text("${humidity.toStringAsFixed(1)}%",
            style: const TextStyle(color: Colors.white)),
      ],
    );
  }
}
