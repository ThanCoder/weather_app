import 'package:flutter/material.dart';

import 'package:weather/core/models/weather_response.dart';
import 'package:weather/core/models/weather_response_x.dart';

class WeatherMobilePage extends StatelessWidget {
  const WeatherMobilePage({super.key, required this.weather});

  final WeatherResponse weather;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _LocationHeader(weather: weather),

              const SizedBox(height: 20),

              _CurrentWeatherCard(weather: weather.current),

              const SizedBox(height: 24),

              _HourlyForecast(hourly: weather.hourly),

              const SizedBox(height: 24),

              _DetailsSection(weather: weather.current, daily: weather.daily),

              const SizedBox(height: 24),

              _DailyForecast(daily: weather.daily),
            ],
          ),
        ),
      ),
    );
  }
}

class _LocationHeader extends StatelessWidget {
  const _LocationHeader({required this.weather});

  final WeatherResponse weather;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Row(
      children: [
        Icon(Icons.location_on_outlined, color: colors.primary, size: 22),

        const SizedBox(width: 8),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                weather.location.name,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),

              if (weather.location.country != null)
                Text(
                  weather.location.country!,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
            ],
          ),
        ),

        Text(
          _formatDate(weather.date),
          style: theme.textTheme.bodySmall?.copyWith(
            color: colors.onSurfaceVariant,
          ),
        ),
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
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: colors.primaryContainer,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        children: [
          Icon(
            weather.weatherCode.weatherIcon,
            size: 64,
            color: colors.onPrimaryContainer,
          ),

          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                weather.temperature.toStringAsFixed(0),
                style: theme.textTheme.displayLarge?.copyWith(
                  fontWeight: FontWeight.w300,
                  height: 1,
                  color: colors.onPrimaryContainer,
                ),
              ),

              Text(
                '°',
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: colors.onPrimaryContainer,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Text(
            weather.weatherCode.weatherCondition,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: colors.onPrimaryContainer,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            'Feels like '
            '${weather.feelsLike.toStringAsFixed(0)}°',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colors.onPrimaryContainer.withValues(alpha: 0.75),
            ),
          ),
        ],
      ),
    );
  }
}

class _HourlyForecast extends StatelessWidget {
  const _HourlyForecast({required this.hourly});

  final List<HourlyWeather> hourly;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hourly forecast',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),

        const SizedBox(height: 14),

        SizedBox(
          height: 132,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: hourly.length,
            separatorBuilder: (_, _) {
              return const SizedBox(width: 10);
            },
            itemBuilder: (context, index) {
              final item = hourly[index];

              return Container(
                width: 78,
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: colors.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: colors.outlineVariant),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _formatHour(item.time),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Icon(
                      item.weatherCode.weatherIcon,
                      size: 25,
                      color: colors.primary,
                    ),

                    const SizedBox(height: 10),

                    Text(
                      '${item.temperature.toStringAsFixed(0)}°',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _DetailsSection extends StatelessWidget {
  const _DetailsSection({required this.weather, required this.daily});

  final CurrentWeather weather;
  final List<DailyWeather> daily;

  @override
  Widget build(BuildContext context) {
    final today = daily.isNotEmpty ? daily.first : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Today',
          style: Theme.of(context).textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.w700),
        ),

        const SizedBox(height: 14),

        GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.8,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _DetailCard(
              icon: Icons.water_drop_outlined,
              title: 'Humidity',
              value: '${weather.humidity}%',
            ),

            _DetailCard(
              icon: Icons.air,
              title: 'Wind',
              value: '${weather.windSpeed.toStringAsFixed(1)} km/h',
            ),

            _DetailCard(
              icon: Icons.water_drop_outlined,
              title: 'Rain',
              value: '${weather.precipitation.toStringAsFixed(1)} mm',
            ),

            if (today != null)
              _DetailCard(
                icon: Icons.umbrella_outlined,
                title: 'Rain chance',
                value: '${today.precipitationProbability}%',
              ),

            if (today != null)
              _DetailCard(
                icon: Icons.wb_sunny_outlined,
                title: 'Sunrise',
                value: _formatTime(today.sunrise),
              ),

            if (today != null)
              _DetailCard(
                icon: Icons.nightlight_outlined,
                title: 'Sunset',
                value: _formatTime(today.sunset),
              ),
          ],
        ),
      ],
    );
  }
}

class _DetailCard extends StatelessWidget {
  const _DetailCard({
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

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: colors.outlineVariant),
      ),
      child: Row(
        children: [
          Icon(icon, size: 22, color: colors.primary),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
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
                    horizontal: 16,
                    vertical: 16,
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 72,
                        child: Text(
                          _dayName(daily[i].date, i),
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: i == 0
                                ? FontWeight.w700
                                : FontWeight.normal,
                          ),
                        ),
                      ),

                      Icon(
                        daily[i].weatherCode.weatherIcon,
                        size: 23,
                        color: colors.primary,
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: Text(
                          daily[i].weatherCode.weatherCondition,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colors.onSurfaceVariant,
                          ),
                        ),
                      ),

                      const SizedBox(width: 8),

                      Text(
                        '${daily[i].temperatureMax.toStringAsFixed(0)}°',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      const SizedBox(width: 10),

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

String _formatDate(DateTime date) {
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  return '${months[date.month - 1]} ${date.day}';
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
