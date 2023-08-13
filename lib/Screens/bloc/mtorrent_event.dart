part of 'mtorrent_bloc.dart';

sealed class MtorrentEvent extends Equatable {
  const MtorrentEvent();

  @override
  List<Object> get props => [];
}

class InitState extends MtorrentEvent{}
class MagnetLinkEvent extends MtorrentEvent{
  final String url;
  const MagnetLinkEvent(this.url);
  @override
  List<Object> get props => [url];
}

class SearchTorrent extends MtorrentEvent{
  final String searchKeyword;
  const SearchTorrent(this.searchKeyword);
  @override
  List<Object> get props => [searchKeyword];
}
class TopSearchTorrent extends MtorrentEvent{
  final String topCategory;
  const TopSearchTorrent(this.topCategory);
  @override
  List<Object> get props => [topCategory];
}
class TrendingSearchTorrent extends MtorrentEvent{
  final String trendCategory;
  final String time;
  const TrendingSearchTorrent(this.trendCategory,this.time);
  @override
  List<Object> get props => [trendCategory,time];
}
class PopularSearchTorrent extends MtorrentEvent{
    final String poppularCategory;
  final String time;
  const PopularSearchTorrent(this.poppularCategory,this.time);
  @override
  List<Object> get props => [poppularCategory,time];
}
