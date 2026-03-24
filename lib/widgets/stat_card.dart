import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color? iconBgColor;
  final String title;
  final String value;
  final String? unit;
  final String? trend;
  final bool? isPositive;
  final bool isSmall;

  const StatCard({
    super.key,
    required this.icon,
    required this.iconColor,
    this.iconBgColor,
    required this.title,
    required this.value,
    this.unit,
    this.trend,
    this.isPositive,
    this.isSmall = false,
  });

  const StatCard.small({
    super.key,
    required this.icon,
    required this.iconColor,
    this.iconBgColor,
    required this.title,
    required this.value,
  })  : unit = null,
        trend = null,
        isPositive = null,
        isSmall = true;

  @override
  Widget build(BuildContext context) {
    if (isSmall) {
      return _buildSmallCard();
    }
    return _buildLargeCard();
  }

  Widget _buildLargeCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconBgColor ?? iconColor.withAlpha(25),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(height: 18),
          Text(
            title.toUpperCase(),
            style: const TextStyle(
              color: AppTheme.textGreyLight,
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: const TextStyle(
                  color: AppTheme.textDark,
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                ),
              ),
              if (unit != null) ...[
                const SizedBox(width: 4),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    unit!,
                    style: const TextStyle(
                      color: AppTheme.textGreyLight,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ],
          ),
          if (trend != null && isPositive != null) ...[
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  isPositive!
                      ? Icons.arrow_outward_rounded
                      : Icons.south_east_rounded,
                  color: isPositive! ? AppTheme.greenAccent : Colors.red,
                  size: 14,
                ),
                const SizedBox(width: 4),
                Text(
                  trend!,
                  style: TextStyle(
                    color: isPositive! ? AppTheme.greenAccent : Colors.red,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSmallCard() {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: iconBgColor ?? iconColor.withAlpha(25),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Icon(icon, color: iconColor, size: 24),
        ),
        const SizedBox(height: 10),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFF757575),
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
