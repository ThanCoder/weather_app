import 'package:flutter/material.dart';

import 'package:weather/core/models/weather_response.dart';
import 'package:weather/core/models/weather_response_x.dart';

class WeatherDesktopPage extends StatelessWidget {
  const WeatherDesktopPage({super.key, required this.weather});

  final WeatherResponse weather;

  @override
  Widget build(BuildContext context) {
    // print(weather.location.name);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1400),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Header(weather: weather),

                  const SizedBox(height: 32),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 4,
                        child: _CurrentWeatherCard(weather: weather.current),
                      ),

                      const SizedBox(width: 24),

                      Expanded(
                        flex: 7,
                        child: _HourlyCard(hourly: weather.hourly),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  _DetailsCard(weather: weather.current, daily: weather.daily),

                  const SizedBox(height: 32),

                  _DailyForecast(daily: weather.daily),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.weather});

  final WeatherResponse weather;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Row(
      children: [
        Icon(
          weather.current.weatherCode.weatherIcon,
          size: 28,
          color: colors.primary,
        ),

        const SizedBox(width: 12),

        Text(
          'Weather',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),

        const Spacer(),

        Text(
          weather.location.name,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),

        if (weather.location.country != null) ...[
          Text(
            ', ${weather.location.country}',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: colors.onSurfaceVariant,
            ),
          ),
        ],

        const SizedBox(width: 16),

        IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
      ],
    );
  }
}

class _CurrentWeatherCard extends StatelessWidget {
  const _CurrentWeatherCard({required this.weather});

  final CurrentWeather weather;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colors.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            weather.weatherCode.weatherIcon,
            size: 52,
            color: colors.primary,
          ),

          const SizedBox(height: 20),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                weather.temperature.toStringAsFixed(0),
                style: theme.textTheme.displayLarge?.copyWith(
                  fontWeight: FontWeight.w300,
                  height: 1,
                ),
              ),

              Text('°', style: theme.textTheme.headlineMedium),
            ],
          ),

          const SizedBox(height: 12),

          Text(
            weather.weatherCode.weatherCondition,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            'Feels like '
            '${weather.feelsLike.toStringAsFixed(0)}°',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: colors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _HourlyCard extends StatelessWidget {
  const _HourlyCard({required this.hourly});

  final List<HourlyWeather> hourly;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colors.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hourly forecast',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 24),

          SizedBox(
            height: 120,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: hourly.length,
              separatorBuilder: (_, _) {
                return const SizedBox(width: 8);
              },
              itemBuilder: (context, index) {
                final item = hourly[index];

                return SizedBox(
                  width: 72,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _formatHour(item.time),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colors.onSurfaceVariant,
                        ),
                      ),

                      const SizedBox(height: 14),

                      Icon(
                        item.weatherCode.weatherIcon,
                        size: 25,
                        color: colors.primary,
                      ),

                      const SizedBox(height: 12),

                      Text(
                        '${item.temperature.toStringAsFixed(0)}°',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailsCard extends StatelessWidget {
  const _DetailsCard({required this.weather, required this.daily});

  final CurrentWeather weather;
  final List<DailyWeather> daily;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final today = daily.isNotEmpty ? daily.first : null;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.outlineVariant),
      ),
      child: Row(
        children: [
          Expanded(
            child: _DetailItem(
              icon: Icons.water_drop_outlined,
              title: 'Humidity',
              value: '${weather.humidity}%',
            ),
          ),

          _Divider(),

          Expanded(
            child: _DetailItem(
              icon: Icons.air,
              title: 'Wind',
              value: '${weather.windSpeed.toStringAsFixed(1)} km/h',
            ),
          ),

          _Divider(),

          Expanded(
            child: _DetailItem(
              icon: Icons.water_drop_outlined,
              title: 'Precipitation',
              value: '${weather.precipitation.toStringAsFixed(1)} mm',
            ),
          ),

          if (today != null) ...[
            _Divider(),

            Expanded(
              child: _DetailItem(
                icon: Icons.wb_sunny_outlined,
                title: 'Sunrise',
                value: _formatTime(today.sunrise),
              ),
            ),

            _Divider(),

            Expanded(
              child: _DetailItem(
                icon: Icons.nightlight_outlined,
                title: 'Sunset',
                value: _formatTime(today.sunset),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _DetailItem extends StatelessWidget {
  const _DetailItem({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 22, color: colors.primary),

        const SizedBox(width: 12),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colors.onSurfaceVariant,
              ),
            ),

            const SizedBox(height: 3),

            Text(
              value,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 42,
      color: Theme.of(context).colorScheme.outlineVariant,
    );
  }
}

class _DailyForecast extends StatelessWidget {
  const _DailyForecast({required this.daily});

  final List<DailyWeather> daily;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '7-day forecast',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),

        const SizedBox(height: 14),

        Container(
          decoration: BoxDecoration(
            border: Border.all(color: colors.outlineVariant),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              for (int i = 0; i < daily.length; i++) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 90,
                        child: Text(
                          _dayName(daily[i].date, i),
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: i == 0
                                ? FontWeight.w700
                                : FontWeight.normal,
                          ),
                        ),
                      ),

                      SizedBox(
                        width: 48,
                        child: Icon(
                          daily[i].weatherCode.weatherIcon,
                          size: 22,
                          color: colors.primary,
                        ),
                      ),

                      Expanded(
                        child: Text(
                          daily[i].weatherCode.weatherCondition,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: colors.onSurfaceVariant,
                          ),
                        ),
                      ),

                      Text(
                        '${daily[i].temperatureMax.toStringAsFixed(0)}°',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      const SizedBox(width: 16),

                      Text(
                        '${daily[i].temperatureMin.toStringAsFixed(0)}°',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),

                if (i != daily.length - 1)
                  Divider(height: 1, color: colors.outlineVariant),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

String _formatHour(DateTime time) {
  final hour = time.hour;

  final displayHour = hour % 12 == 0 ? 12 : hour % 12;

  final period = hour >= 12 ? 'PM' : 'AM';

  return '$displayHour $period';
}

String _formatTime(DateTime time) {
  final hour = time.hour;

  final displayHour = hour % 12 == 0 ? 12 : hour % 12;

  final minute = time.minute.toString().padLeft(2, '0');

  final period = hour >= 12 ? 'PM' : 'AM';

  return '$displayHour:$minute $period';
}

String _dayName(DateTime date, int index) {
  if (index == 0) {
    return 'Today';
  }

  return switch (date.weekday) {
    DateTime.monday => 'Monday',
    DateTime.tuesday => 'Tuesday',
    DateTime.wednesday => 'Wednesday',
    DateTime.thursday => 'Thursday',
    DateTime.friday => 'Friday',
    DateTime.saturday => 'Saturday',
    DateTime.sunday => 'Sunday',
    _ => '',
  };
}
