import 'dart:convert';

import 'package:flutter/services.dart' show AssetBundle, rootBundle;

import '../models/portfolio_data.dart';

/// Abstraction over "where the portfolio content comes from". The UI layer
/// only ever depends on this interface, so the JSON source can later be
/// swapped (e.g. a CMS or remote endpoint) without touching any widgets.
abstract class PortfolioRepository {
  Future<PortfolioData> load();
}

/// Default implementation: reads `assets/data/portfolio.json` bundled with
/// the app. This is the single file to edit when updating CV content —
/// no Dart/widget changes needed.
class AssetPortfolioRepository implements PortfolioRepository {
  AssetPortfolioRepository({
    this.assetPath = 'assets/data/portfolio.json',
    AssetBundle? bundle,
  }) : _bundle = bundle ?? rootBundle;

  final String assetPath;
  final AssetBundle _bundle;

  @override
  Future<PortfolioData> load() async {
    final raw = await _bundle.loadString(assetPath);
    final json = jsonDecode(raw) as Map<String, dynamic>;
    return PortfolioData.fromJson(json);
  }
}
