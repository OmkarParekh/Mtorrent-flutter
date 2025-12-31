// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'bloc/mtorrent_bloc.dart';

// class SearchPage extends StatefulWidget {
//   final String keyword;
//   final SearchPageState state;
//   const SearchPage(this.state,this.keyword);

//   @override
//   State<SearchPage> createState() => _SearchPageState();
// }

// class _SearchPageState extends State<SearchPage> {
//   @override
//   Widget build(BuildContext context) {
//     var state = widget.state;
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: const Color.fromRGBO(28,119,130,10),
//             leading: IconButton(
//                 onPressed: () {
//                   BlocProvider.of<MtorrentBloc>(context).add(InitState());
//                   Navigator.pop(context);
//                 },
//                 icon: const Icon(Icons.arrow_back)),
//             title: const Text("MTorrent")),
//         body: Container(
//           width: MediaQuery.sizeOf(context).width,
//           height: MediaQuery.sizeOf(context).height,
//           decoration: const BoxDecoration(
//               image: DecorationImage(
//                   image: AssetImage(
//                     "Assets/Images/Main_Page.jpg",
//                   ),
//                   fit: BoxFit.fill)),
//           child: Container(
//             child: (state.searchdata.isNotEmpty)?ListView.separated(
//               itemCount: state.searchdata.length,
//               separatorBuilder: (context, index) {
//                 return Container(width: MediaQuery.sizeOf(context).width,
//                 height: 1,
//                 color: Colors.white,

//                 );
//               },
//               itemBuilder: (context, index) {
//                 var data = state.searchdata[index];

//                 return ListTile(
//                   contentPadding: const EdgeInsets.all(10),
//                   title: Text("${data['Name']}",style: const TextStyle(color: Colors.white),),
//                   subtitle: Text("${data['size']}",style: const TextStyle(color: Colors.white),),
//                   onTap: () {
//                     BlocProvider.of<MtorrentBloc>(context)
//                         .add(MagnetLinkEvent(data['link']));
//                   },
//                 );
//               },
//             ):Center(child: Text("No Data Found for Keyword '${widget.keyword}'",style: const TextStyle(color: Colors.white,fontSize: 20),)),
//           ),
//         ));
//   }
// }

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mtorrent/helper/helper.dart';
import 'bloc/mtorrent_bloc.dart';

class SearchPage extends StatefulWidget {
  final String keyword;

  const SearchPage({super.key, required this.keyword});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    // final state = widget.state;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF081C2F),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            context.read<MtorrentBloc>().add(InitState());
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Results for ${widget.keyword}",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 🌌 Background gradient (same theme)
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF081C2F),
                  Color(0xFF0B3A53),
                  Color(0xFF0E5A6F),
                ],
              ),
            ),
          ),

          // Content
          BlocBuilder<MtorrentBloc, MtorrentState>(
            builder: (context, state) {
              if (state is SearchPageState) {
                return state.searchdata.isNotEmpty
                    ? ListView.separated(
                        padding: const EdgeInsets.all(16),
                        itemCount: state.searchdata.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 14),
                        itemBuilder: (context, index) {
                          final data = state.searchdata[index];
                          return _resultCard(context, data);
                        },
                      )
                    : emptyState();
              } else {
                return loadingUI();
              }
            },
          )
        ],
      ),
    );
  }

  // =================== RESULT CARD ===================

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

  // =================== EMPTY STATE ===================
}
