import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'data/repositories/portfolio_repository.dart';
import 'presentation/screens/home_screen.dart';
import 'providers/portfolio_provider.dart';
import 'providers/theme_provider.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Swap AssetPortfolioRepository for another PortfolioRepository
        // implementation to source content from somewhere other than the
        // bundled JSON asset, without touching any UI code.
        ChangeNotifierProvider(
          create: (_) => PortfolioProvider(repository: AssetPortfolioRepository()),
        ),
        ChangeNotifierProvider(create: (_) => AppThemeProvider()),
      ],
      child: Consumer<AppThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            title: 'MD Shakhawat Hossain Shahin — Portfolio',
            debugShowCheckedModeBanner: false,
            themeMode: themeProvider.mode,
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
