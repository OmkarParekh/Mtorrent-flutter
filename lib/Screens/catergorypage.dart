import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mtorrent/Screens/bloc/mtorrent_bloc.dart';
import 'package:mtorrent/helper/helper.dart';

class CategoryPage extends StatefulWidget {
  final TorrentFeature feature;

  const CategoryPage({super.key, required this.feature});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  // Filters
  final ValueNotifier<TopCategory> topCategory = ValueNotifier(TopCategory.all);

  final ValueNotifier<PopularPeriod> popularPeriod =
      ValueNotifier(PopularPeriod.day);

  final ValueNotifier<PopularType> popularType =
      ValueNotifier(PopularType.movies);

  final ValueNotifier<TrendingPeriod> trendingPeriod =
      ValueNotifier(TrendingPeriod.day);

  final ValueNotifier<TrendingType> trendingType =
      ValueNotifier(TrendingType.all);

  // Mock list (replace with Bloc later)

  @override
  void initState() {
    super.initState();
    _loadInitialList();
  }

  @override
  void dispose() {
    topCategory.dispose();
    popularPeriod.dispose();
    popularType.dispose();
    trendingPeriod.dispose();
    trendingType.dispose();
    super.dispose();
  }

  void _loadInitialList() {
    if (widget.feature == TorrentFeature.popular) {
      BlocProvider.of<MtorrentBloc>(context).add(PopularSearchTorrent(
          popularPeriod: popularPeriod.value, popularType: popularType.value));
    } else if (widget.feature == TorrentFeature.top) {
      BlocProvider.of<MtorrentBloc>(context)
          .add(TopSearchTorrent(topCategory: topCategory.value));
    } else if (widget.feature == TorrentFeature.trending) {
      BlocProvider.of<MtorrentBloc>(context).add(TrendingSearchTorrent(
          trendingPeriod: trendingPeriod.value,
          trendingType: trendingType.value));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF081C2F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF081C2F),
        elevation: 0,
        title: Text(torrentFeatureLabel(widget.feature)),
        actions: [_applyButton()],
      ),
      body: Column(
        children: [
          _filterSection(),
          Expanded(child: _resultList()),
        ],
      ),
    );
  }

  // ================= FILTER UI =================
  Widget _filterSection() {
    switch (widget.feature) {
      case TorrentFeature.top:
        return _filterRow([
          ValueListenableBuilder<TopCategory>(
            valueListenable: topCategory,
            builder: (_, value, __) {
              return _smallDropdown<TopCategory>(
                value: value,
                items: TopCategory.values,
                onChanged: (v) => topCategory.value = v,
              );
            },
          ),
        ]);

      case TorrentFeature.popular:
        return _filterRow([
          ValueListenableBuilder<PopularPeriod>(
            valueListenable: popularPeriod,
            builder: (_, value, __) {
              return _smallDropdown<PopularPeriod>(
                value: value,
                items: PopularPeriod.values,
                onChanged: (v) => popularPeriod.value = v,
              );
            },
          ),
          ValueListenableBuilder<PopularType>(
            valueListenable: popularType,
            builder: (_, value, __) {
              return _smallDropdown<PopularType>(
                value: value,
                items: PopularType.values,
                onChanged: (v) => popularType.value = v,
              );
            },
          ),
        ]);

      case TorrentFeature.trending:
        return _filterRow([
          ValueListenableBuilder<TrendingPeriod>(
            valueListenable: trendingPeriod,
            builder: (_, value, __) {
              return _smallDropdown<TrendingPeriod>(
                value: value,
                items: TrendingPeriod.values,
                onChanged: (v) => trendingPeriod.value = v,
              );
            },
          ),
          ValueListenableBuilder<TrendingType>(
            valueListenable: trendingType,
            builder: (_, value, __) {
              return _smallDropdown<TrendingType>(
                value: value,
                items: TrendingType.values,
                onChanged: (v) => trendingType.value = v,
              );
            },
          ),
        ]);

      case TorrentFeature.home:
        return const SizedBox.shrink();
    }
  }

  Widget _filterRow(List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: children
            .map((c) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: c,
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _smallDropdown<T>({
    required T value,
    required List<T> items,
    required Function(T) onChanged,
  }) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.cyanAccent.withOpacity(0.4)),
      ),
      child: DropdownButton<T>(
        value: value,
        isExpanded: true,
        underline: const SizedBox(),
        dropdownColor: const Color(0xFF081C2F),
        iconEnabledColor: Colors.cyanAccent,
        style: const TextStyle(color: Colors.white, fontSize: 12),
        items: items.map((e) {
          return DropdownMenuItem(
            value: e,
            child: Text(enumLabel(e)),
          );
        }).toList(),
        onChanged: (v) => onChanged(v as T),
      ),
    );
  }

  // ================= SEARCH-STYLE LIST =================

  Widget _resultList() {
    return BlocBuilder<MtorrentBloc, MtorrentState>(
      builder: (context, state) {
        if (state is PopularPageState ||
            state is TrendingPageState ||
            state is TopPageState) {
          var data = (state is PopularPageState)
              ? state.data.length
              : (state is TrendingPageState)
                  ? state.data.length
                  : (state is TopPageState)
                      ? state.data.length
                      : 0;
          if (data != 0) {
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: (state is PopularPageState)
                  ? state.data.length
                  : (state is TrendingPageState)
                      ? state.data.length
                      : (state is TopPageState)
                          ? state.data.length
                          : 0,
              separatorBuilder: (_, __) => const SizedBox(height: 14),
              itemBuilder: (context, index) {
                final item = (state is PopularPageState)
                    ? state.data[index]
                    : (state is TrendingPageState)
                        ? state.data[index]
                        : (state is TopPageState)
                            ? state.data[index]
                            : 0;

                return _resultCard(context, item);
              },
            );
          } else {
            return emptyState();
          }
        } else {
          return loadingUI();
        }
      },
    );
  }

  Widget _resultCard(BuildContext context, Map<String, dynamic> data) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: InkWell(
          onTap: () {
            context.read<MtorrentBloc>().add(MagnetLinkEvent(data['link']));
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.cyanAccent.withOpacity(0.35),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.cyanAccent.withOpacity(0.15),
                  blurRadius: 12,
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon column
                const Icon(
                  Icons.download_rounded,
                  color: Colors.cyanAccent,
                  size: 28,
                ),

                const SizedBox(width: 12),

                // Data column (table-like)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Torrent name
                      Text(
                        data['Name'] ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 6),

                      // Size row
                      Row(
                        children: [
                          const Icon(
                            Icons.storage_rounded,
                            size: 14,
                            color: Colors.white60,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            data['size'] ?? '',
                            style: const TextStyle(
                              color: Colors.white60,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Action icon
                const Icon(
                  Icons.open_in_new_rounded,
                  color: Colors.white70,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ================= APPLY =================

  Widget _applyButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.cyanAccent,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: () {
          _loadInitialList();
        },
        child: const Text(
          "APPLY",
          style: TextStyle(
            color: Colors.black,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
          ),
        ),
      ),
    );
  }
}
