import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mtorrent/Screens/bloc/mtorrent_bloc.dart';
import 'package:mtorrent/Screens/searchpage.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController keyword = TextEditingController();
  @override
  void initState() {
    BlocProvider.of<MtorrentBloc>(context).add(InitState());
    keyword.text="";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MTorrent"),
        backgroundColor: const Color.fromRGBO(28, 119, 130, 10),
      ),
      body: BlocConsumer<MtorrentBloc, MtorrentState>(
        listener: (context, state) {
          if (state is SearchPageState) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchPage(state,keyword.text),
                ));
            keyword.text="";
          }
        },
        builder: (context, state) {
          if (state is HomePageState) {
            return Container(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        "Assets/Images/Main_Page.jpg",
                      ),
                      fit: BoxFit.fill)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset("Assets/Images/symbol.png"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: const BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 2.0,
                            ),
                          ),
                          labelText: "Search",
                          labelStyle: const TextStyle(color: Colors.white)),
                      controller: keyword,
                    ),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(width: 3.0, color: Colors.white),
                        backgroundColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40.0, vertical: 10.0),
                        shape: const StadiumBorder(),
                      ),
                      onPressed: () {
                        BlocProvider.of<MtorrentBloc>(context)
                            .add(SearchTorrent(keyword.text));
                      },
                      child: const Icon(Icons.arrow_forward))
                ],
              ),
            );
          }
          if (state is LoadingState) {
            return Container(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        "Assets/Images/Main_Page.jpg",
                      ),
                      fit: BoxFit.fill)),
              child: const Center(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(color: Colors.white,),
                ),
              ),
            );
          }
          else{
            BlocProvider.of<MtorrentBloc>(context).add(InitState());
          return const Text("");
          }
        },
      ), //Center
    );
  }
}
