import 'dart:ui';

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF172B4D),
              Color(0xFF0D182B),
              Color(0xFF09111F),
            ],
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 30),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    _buildAppBar(colorScheme),
                    const SizedBox(height: 28),

                    // Location
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          size: 18,
                          color: colorScheme.primary,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          'Yangon, Myanmar',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Thursday, August 27',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white60,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Main weather
                    _buildCurrentWeather(theme),

                    const SizedBox(height: 24),

                    // Hourly
                    _GlassCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hourly Forecast',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 18),
                          SizedBox(
                            height: 110,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              children: const [
                                _HourlyItem(
                                  time: 'Now',
                                  icon: Icons.cloud_rounded,
                                  temp: '28°',
                                  active: true,
                                ),
                                _HourlyItem(
                                  time: '16:00',
                                  icon: Icons.cloud_rounded,
                                  temp: '28°',
                                ),
                                _HourlyItem(
                                  time: '17:00',
                                  icon: Icons.cloud_queue_rounded,
                                  temp: '27°',
                                ),
                                _HourlyItem(
                                  time: '18:00',
                                  icon: Icons.nights_stay_rounded,
                                  temp: '26°',
                                ),
                                _HourlyItem(
                                  time: '19:00',
                                  icon: Icons.nights_stay_rounded,
                                  temp: '26°',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 18),

                    // Weather details
                    Row(
                      children: [
                        Expanded(
                          child: _DetailCard(
                            icon: Icons.water_drop_rounded,
                            title: 'Humidity',
                            value: '78%',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _DetailCard(
                            icon: Icons.air_rounded,
                            title: 'Wind',
                            value: '12 km/h',
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        Expanded(
                          child: _DetailCard(
                            icon: Icons.wb_sunny_rounded,
                            title: 'UV Index',
                            value: '5.2',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _DetailCard(
                            icon: Icons.visibility_rounded,
                            title: 'Visibility',
                            value: '9.6 km',
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    Text(
                      '7-Day Forecast',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    const _DayItem(
                      day: 'Today',
                      condition: 'Partly cloudy',
                      icon: Icons.cloud_rounded,
                      low: '25°',
                      high: '30°',
                    ),
                    const _DayItem(
                      day: 'Fri',
                      condition: 'Light rain',
                      icon: Icons.water_drop_rounded,
                      low: '25°',
                      high: '29°',
                    ),
                    const _DayItem(
                      day: 'Sat',
                      condition: 'Cloudy',
                      icon: Icons.cloud_rounded,
                      low: '25°',
                      high: '30°',
                    ),
                    const _DayItem(
                      day: 'Sun',
                      condition: 'Thunderstorm',
                      icon: Icons.thunderstorm_rounded,
                      low: '24°',
                      high: '28°',
                    ),
                    const _DayItem(
                      day: 'Mon',
                      condition: 'Partly cloudy',
                      icon: Icons.cloud_queue_rounded,
                      low: '25°',
                      high: '31°',
                    ),
                    const _DayItem(
                      day: 'Tue',
                      condition: 'Sunny',
                      icon: Icons.wb_sunny_rounded,
                      low: '25°',
                      high: '32°',
                    ),
                    const _DayItem(
                      day: 'Wed',
                      condition: 'Light rain',
                      icon: Icons.water_drop_rounded,
                      low: '25°',
                      high: '30°',
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(ColorScheme colorScheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Weather',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w700,
          ),
        ),
        IconButton.filledTonal(
          onPressed: () {},
          icon: const Icon(Icons.my_location_rounded),
          style: IconButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.white.withValues(alpha: .12),
          ),
        ),
      ],
    );
  }

  Widget _buildCurrentWeather(ThemeData theme) {
    return Column(
      children: [
        const Icon(
          Icons.cloud_rounded,
          size: 105,
          color: Colors.white,
        ),

        const SizedBox(height: 4),

        Text(
          '28°',
          style: theme.textTheme.displayLarge?.copyWith(
            color: Colors.white,
            fontSize: 82,
            fontWeight: FontWeight.w300,
            height: 1,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          'Partly Cloudy',
          style: theme.textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 5),

        Text(
          'Feels like 31°',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: Colors.white60,
          ),
        ),
      ],
    );
  }
}

class _GlassCard extends StatelessWidget {
  final Widget child;

  const _GlassCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(26),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 18,
          sigmaY: 18,
        ),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: .08),
            borderRadius: BorderRadius.circular(26),
            border: Border.all(
              color: Colors.white.withValues(alpha: .08),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

class _HourlyItem extends StatelessWidget {
  final String time;
  final String temp;
  final IconData icon;
  final bool active;

  const _HourlyItem({
    required this.time,
    required this.temp,
    required this.icon,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 66,
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: active
            ? Colors.white.withValues(alpha: .14)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            time,
            style: TextStyle(
              color: active ? Colors.white : Colors.white54,
              fontSize: 12,
            ),
          ),
          Icon(
            icon,
            color: Colors.white,
            size: 25,
          ),
          Text(
            temp,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _DetailCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return _GlassCard(
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white70,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DayItem extends StatelessWidget {
  final String day;
  final String condition;
  final IconData icon;
  final String low;
  final String high;

  const _DayItem({
    required this.day,
    required this.condition,
    required this.icon,
    required this.low,
    required this.high,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: _GlassCard(
        child: Row(
          children: [
            SizedBox(
              width: 48,
              child: Text(
                day,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            Icon(
              icon,
              color: Colors.white70,
              size: 25,
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Text(
                condition,
                style: const TextStyle(
                  color: Colors.white60,
                  fontSize: 13,
                ),
              ),
            ),

            Text(
              '$high / $low',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}