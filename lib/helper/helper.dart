import 'package:flutter/material.dart';

enum TorrentFeature {
  home,
  popular,
  top,
  trending,
}

enum TopCategory { all, movies, music, apps, games, anime, tv, others }

enum TrendingPeriod {
  day,
  week,
}

enum TrendingType { all, movies, music, apps, games, anime, tv, others }

enum PopularPeriod {
  day,
  week,
}

enum PopularType { movies, music, apps, games, anime, tv, others }

String torrentFeatureLabel(TorrentFeature feature) {
  switch (feature) {
    case TorrentFeature.home:
      return "Home";
    case TorrentFeature.popular:
      return "Popular";
    case TorrentFeature.top:
      return "Top";
    case TorrentFeature.trending:
      return "Trending";
  }
}

String topCategoryLabel(TopCategory c) {
  switch (c) {
    case TopCategory.all:
      return "all";
    case TopCategory.movies:
      return "movies";
    case TopCategory.music:
      return "music";
    case TopCategory.apps:
      return "apps";
    case TopCategory.games:
      return "games";
    case TopCategory.anime:
      return "anime";
    case TopCategory.tv:
      return "tV";
    case TopCategory.others:
      return "others";
  }
}

String trendingPeriodLabel(TrendingPeriod p) {
  switch (p) {
    case TrendingPeriod.day:
      return "day";
    case TrendingPeriod.week:
      return "week";
  }
}

String trendingTypeLabel(TrendingType t) {
  switch (t) {
    case TrendingType.all:
      return "all";
    case TrendingType.movies:
      return "movies";
    case TrendingType.music:
      return "music";
    case TrendingType.apps:
      return "apps";
    case TrendingType.games:
      return "games";
    case TrendingType.anime:
      return "anime";
    case TrendingType.tv:
      return "tV";
    case TrendingType.others:
      return "others";
  }
}

String popularPeriodLabel(PopularPeriod p) {
  switch (p) {
    case PopularPeriod.day:
      return "day";
    case PopularPeriod.week:
      return "week";
  }
}

String popularTypeLabel(PopularType t) {
  switch (t) {
    case PopularType.movies:
      return "movies";
    case PopularType.music:
      return "music";
    case PopularType.apps:
      return "apps";
    case PopularType.games:
      return "games";
    case PopularType.anime:
      return "anime";
    case PopularType.tv:
      return "tv";
    case PopularType.others:
      return "others";
  }
}

String enumLabel(dynamic e) {
  return e.toString().split('.').last.toUpperCase();
}

Widget loadingUI() {
  return Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF081C2F),
          Color(0xFF0B3A53),
          Color(0xFF0E5A6F),
        ],
      ),
    ),
    child: const Center(
      child: CircularProgressIndicator(
        color: Colors.cyanAccent,
        strokeWidth: 3,
      ),
    ),
  );
}

Widget emptyState() {
  return Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.search_off_rounded,
            size: 64,
            color: Colors.white38,
          ),
          const SizedBox(height: 16),
          Text(
            "No results found",
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 18,
              height: 1.4,
            ),
          ),
        ],
      ),
    ),
  );
}
