import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/mtorrent_bloc.dart';

class SearchPage extends StatefulWidget {
  final String keyword;
  final SearchPageState state;
  const SearchPage(this.state,this.keyword);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    var state = widget.state;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(28,119,130,10),
            leading: IconButton(
                onPressed: () {
                  BlocProvider.of<MtorrentBloc>(context).add(InitState());
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back)),
            title: const Text("MTorrent")),
        body: Container(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    "Assets/Images/Main_Page.jpg",
                  ),
                  fit: BoxFit.fill)),
          child: Container(
            child: (state.searchdata.isNotEmpty)?ListView.separated(
              itemCount: state.searchdata.length,
              separatorBuilder: (context, index) {
                return Container(width: MediaQuery.sizeOf(context).width,
                height: 1,
                color: Colors.white,
          
                );
              },
              itemBuilder: (context, index) {
                var data = state.searchdata[index];
          
                return ListTile(
                  contentPadding: const EdgeInsets.all(10),
                  title: Text("${data['Name']}",style: const TextStyle(color: Colors.white),),
                  subtitle: Text("${data['size']}",style: const TextStyle(color: Colors.white),),
                  onTap: () {
                    BlocProvider.of<MtorrentBloc>(context)
                        .add(MagnetLinkEvent(data['link']));
                  },
                );
              },
            ):Center(child: Text("No Data Found for Keyword '${widget.keyword}'",style: const TextStyle(color: Colors.white,fontSize: 20),)),
          ),
        ));
  }
}
