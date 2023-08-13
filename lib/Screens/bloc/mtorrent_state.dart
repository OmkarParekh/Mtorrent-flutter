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
  final trendingdata;
  const TrendingPageState(this.trendingdata);
}

class PopularPageState extends MtorrentState {
  final populardata;
  const PopularPageState(this.populardata);
}
