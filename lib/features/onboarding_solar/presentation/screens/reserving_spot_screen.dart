import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/route_names.dart';
import '../../../../core/widgets/ancestro_loading.dart';

class ReservingSpotScreen extends ConsumerStatefulWidget {
  const ReservingSpotScreen({super.key});

  @override
  ConsumerState<ReservingSpotScreen> createState() =>
      _ReservingSpotScreenState();
}

class _ReservingSpotScreenState extends ConsumerState<ReservingSpotScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) context.go(RouteNames.solarFinances);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: AncestroLoading(
          message: 'Reserving your spot...\nWe need to review some documents.',
        ),
      ),
    );
  }
}
