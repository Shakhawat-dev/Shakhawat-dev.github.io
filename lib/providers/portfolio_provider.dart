import 'package:flutter/foundation.dart';

import '../data/models/portfolio_data.dart';
import '../data/repositories/portfolio_repository.dart';

enum PortfolioStatus { loading, ready, error }

/// Loads [PortfolioData] once from the [PortfolioRepository] and exposes it
/// to the widget tree. Call [reload] to re-read the JSON at runtime (handy
/// during development when iterating on content).
class PortfolioProvider extends ChangeNotifier {
  PortfolioProvider({required PortfolioRepository repository})
      : _repository = repository {
    _load();
  }

  final PortfolioRepository _repository;

  PortfolioStatus status = PortfolioStatus.loading;
  PortfolioData? data;
  Object? error;

  Future<void> _load() async {
    status = PortfolioStatus.loading;
    notifyListeners();
    try {
      data = await _repository.load();
      status = PortfolioStatus.ready;
    } catch (e) {
      error = e;
      status = PortfolioStatus.error;
    }
    notifyListeners();
  }

  Future<void> reload() => _load();
}
