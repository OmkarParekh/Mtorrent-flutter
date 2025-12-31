part of 'mtorrent_bloc.dart';

sealed class MtorrentState extends Equatable {
  const MtorrentState();

  @override
  List<Object> get props => [];
}

final class MtorrentInitial extends MtorrentState {}

class HomePageState extends MtorrentState {}

class MagnetLinkState extends MtorrentState {}

class SearchPageState extends MtorrentState {
  final List<dynamic> searchdata;
  const SearchPageState(this.searchdata);
}

class LoadingState extends MtorrentState {}

class TrendingPageState extends MtorrentState {
  final List<dynamic> data;
  final TrendingType trendingType;
  final TrendingPeriod trendingPeriod;
  const TrendingPageState(
      {required this.data,
      required this.trendingPeriod,
      required this.trendingType});
}

class PopularPageState extends MtorrentState {
  final List<dynamic> data;
  final PopularType popularType;
  final PopularPeriod popularPeriod;
  const PopularPageState(
      {required this.data,
      required this.popularPeriod,
      required this.popularType});
}

class TopPageState extends MtorrentState {
  final List<dynamic> data;
  final TopCategory topCategory;
  const TopPageState({
    required this.data,
    required this.topCategory,
  });
}
