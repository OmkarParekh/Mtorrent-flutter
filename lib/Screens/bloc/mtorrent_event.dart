part of 'mtorrent_bloc.dart';

sealed class MtorrentEvent extends Equatable {
  const MtorrentEvent();

  @override
  List<Object> get props => [];
}

class InitState extends MtorrentEvent {}

class MagnetLinkEvent extends MtorrentEvent {
  final String url;
  const MagnetLinkEvent(this.url);
  @override
  List<Object> get props => [url];
}

class SearchTorrent extends MtorrentEvent {
  final String searchKeyword;
  const SearchTorrent(this.searchKeyword);
  @override
  List<Object> get props => [searchKeyword];
}

class TopSearchTorrent extends MtorrentEvent {
  final TopCategory topCategory;
  const TopSearchTorrent({required this.topCategory});
}

class TrendingSearchTorrent extends MtorrentEvent {
  final TrendingType trendingType;
  final TrendingPeriod trendingPeriod;
  const TrendingSearchTorrent(
      {required this.trendingType, required this.trendingPeriod});
}

class PopularSearchTorrent extends MtorrentEvent {
  final PopularType popularType;
  final PopularPeriod popularPeriod;
  const PopularSearchTorrent(
      {required this.popularType, required this.popularPeriod});
}
