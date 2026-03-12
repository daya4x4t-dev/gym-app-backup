import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gym/screens/home_dashboard.dart';

void main() {
  testWidgets('HomeDashboard v2 displays key elements', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(
      home: HomeDashboard(),
    ));

    // Verify greeting text
    expect(find.text('Good Morning'), findsOneWidget);
    expect(find.text('Ready for today’s workout?'), findsOneWidget);

    // Verify sections headers
    expect(find.text('Top Gym Brand'), findsOneWidget);
    expect(find.text('Top Workout'), findsOneWidget);

    // Verify Featured Banner title
    expect(find.text('Top Workouts\nof 2025'), findsOneWidget);

    // Verify Search Bar placeholder
    expect(find.text('Search workouts, gyms or equipment'), findsOneWidget);

    // Verify Gym Equipment button
    expect(find.text('View Gym Equipment'), findsOneWidget);

    // Verify Stats cards labels
    expect(find.text('Heart Rate'), findsOneWidget);
    expect(find.text('Calories'), findsOneWidget);
    expect(find.text('Steps'), findsOneWidget);
    expect(find.text('Weight'), findsOneWidget);
    expect(find.text('Diet Plan'), findsOneWidget);

    // Verify AI Trainer label in bottom nav
    expect(find.text('AI Trainer'), findsOneWidget);
  });
}
