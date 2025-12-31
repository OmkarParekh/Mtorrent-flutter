// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mtorrent/Screens/bloc/mtorrent_bloc.dart';
// import 'package:mtorrent/Screens/searchpage.dart';

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   TextEditingController keyword = TextEditingController();
//   @override
//   void initState() {
//     BlocProvider.of<MtorrentBloc>(context).add(InitState());
//     keyword.text="";
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("MTorrent"),
//         backgroundColor: const Color.fromRGBO(28, 119, 130, 10),
//       ),
//       body: BlocConsumer<MtorrentBloc, MtorrentState>(
//         listener: (context, state) {
//           if (state is SearchPageState) {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => SearchPage(state,keyword.text),
//                 ));
//             keyword.text="";
//           }
//         },
//         builder: (context, state) {
//           if (state is HomePageState) {
//             return Container(
//               width: MediaQuery.sizeOf(context).width,
//               height: MediaQuery.sizeOf(context).height,
//               decoration: const BoxDecoration(
//                   image: DecorationImage(
//                       image: AssetImage(
//                         "Assets/Images/Main_Page.jpg",
//                       ),
//                       fit: BoxFit.fill)),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Image.asset("Assets/Images/symbol.png"),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: TextFormField(
//                       style: const TextStyle(color: Colors.white),
//                       decoration: InputDecoration(
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(25.0),
//                             borderSide: const BorderSide(
//                               color: Colors.white,
//                             ),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(25.0),
//                             borderSide: const BorderSide(
//                               color: Colors.white,
//                               width: 2.0,
//                             ),
//                           ),
//                           labelText: "Search",
//                           labelStyle: const TextStyle(color: Colors.white)),
//                       controller: keyword,
//                     ),
//                   ),
//                   ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         side: const BorderSide(width: 3.0, color: Colors.white),
//                         backgroundColor: Colors.transparent,
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 40.0, vertical: 10.0),
//                         shape: const StadiumBorder(),
//                       ),
//                       onPressed: () {
//                         BlocProvider.of<MtorrentBloc>(context)
//                             .add(SearchTorrent(keyword.text));
//                       },
//                       child: const Icon(Icons.arrow_forward))
//                 ],
//               ),
//             );
//           }
//           if (state is LoadingState) {
//             return Container(
//               width: MediaQuery.sizeOf(context).width,
//               height: MediaQuery.sizeOf(context).height,
//               decoration: const BoxDecoration(
//                   image: DecorationImage(
//                       image: AssetImage(
//                         "Assets/Images/Main_Page.jpg",
//                       ),
//                       fit: BoxFit.fill)),
//               child: const Center(
//                 child: SizedBox(
//                   height: 50,
//                   width: 50,
//                   child: CircularProgressIndicator(color: Colors.white,),
//                 ),
//               ),
//             );
//           }
//           else{
//             BlocProvider.of<MtorrentBloc>(context).add(InitState());
//           return const Text("");
//           }
//         },
//       ), //Center
//     );
//   }
// }

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mtorrent/Screens/bloc/mtorrent_bloc.dart';
import 'package:mtorrent/Screens/catergorypage.dart';
import 'package:mtorrent/Screens/searchpage.dart';
import 'package:mtorrent/helper/helper.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController keyword = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<MtorrentBloc>().add(InitState());
  }

  @override
  void dispose() {
    keyword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _homeUI(context));
  }

  // =================== HOME UI ===================
  Widget _chip(
    BuildContext context,
    String label,
    IconData icon,
  ) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white.withOpacity(0.08),
        border: Border.all(
          color: Colors.cyanAccent.withOpacity(0.5),
          width: 1.2,
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 18),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }

  Widget _featureChips(BuildContext context) {
    return Row(
      spacing: 12,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoryPage(
                    feature: TorrentFeature.popular,
                  ),
                ));
          },
          child: _chip(
            context,
            "Popular",
            Icons.local_fire_department,
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CategoryPage(
                    feature: TorrentFeature.top,
                  ),
                ));
          },
          child: _chip(
            context,
            "Top",
            Icons.star,
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CategoryPage(
                    feature: TorrentFeature.trending,
                  ),
                ));
          },
          child: _chip(
            context,
            "Trending",
            Icons.trending_up,
          ),
        ),
      ],
    );
  }

  Widget _homeUI(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // 🌌 BACKGROUND GRADIENT (MATCHES BANNER)
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

        SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 🔥 MTORRENT BANNER
              Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage("Assets/Images/symbol.png"),
                    fit: BoxFit.fitWidth,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.cyanAccent.withOpacity(0.35),
                      blurRadius: 25,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 36),

              // 🧊 GLASS SEARCH CARD
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(28),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                    child: Container(
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(
                          color: Colors.cyanAccent.withOpacity(0.35),
                        ),
                      ),
                      child: Column(
                        children: [
                          // SEARCH FIELD
                          TextField(
                            controller: keyword,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                            textInputAction: TextInputAction.search,
                            onSubmitted: (_) => _onSearch(context),
                            decoration: InputDecoration(
                              hintText: "Search torrents...",
                              hintStyle: const TextStyle(
                                color: Colors.white60,
                              ),
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Colors.cyanAccent,
                              ),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.04),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),

                          const SizedBox(height: 26),

                          // 🚀 NEON SEARCH BUTTON
                          SizedBox(
                            width: double.infinity,
                            height: 54,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF00E5FF),
                                    Color(0xFF00B0FF),
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.cyanAccent.withOpacity(0.6),
                                    blurRadius: 18,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              child: ElevatedButton(
                                onPressed: () => _onSearch(context),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                ),
                                child: const Text(
                                  "SEARCH",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1.4,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 36),
              _featureChips(context),
            ],
          ),
        ),
      ],
    );
  }

  // =================== LOADING UI ===================

  // =================== LOGIC ===================

  void _onSearch(BuildContext context) {
    if (keyword.text.trim().isEmpty) return;

    context.read<MtorrentBloc>().add(SearchTorrent(keyword.text.trim()));
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SearchPage(keyword: keyword.text),
      ),
    );
  }
}
