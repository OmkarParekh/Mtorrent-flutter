import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

part 'mtorrent_event.dart';
part 'mtorrent_state.dart';

class MtorrentBloc extends Bloc<MtorrentEvent, MtorrentState> {
  MtorrentBloc() : super(MtorrentInitial()) {
    on<InitState>((event, emit) async {
      emit(HomePageState());
      // TODO: implement event handler
    });
    on<MagnetLinkEvent>((event, emit) async {
      try {
        final Uri url = Uri.parse(
            'https://mtorrent.cyclic.app/Magnet/link?link=${event.url}');
        final response = await http.get(url);
        var responseData = json.decode(response.body);
        // print(responseData['Magnetlink']);
        var magnetlink = responseData['Magnetlink'];
        // print(magnetlink);
        if (await canLaunchUrl(Uri.parse(magnetlink))) {
          await launchUrl(Uri.parse(magnetlink));
        } else {
          // throw 'Could not launch $url';
        }
      } catch (err) {
        print(err);
      }
    });
    on<SearchTorrent>((event, emit) async {
      if (event.searchKeyword == "") {
      } else {
        emit(LoadingState());
        var url = "https://mtorrent.cyclic.app/search/${event.searchKeyword}";
        final response = await http.get(Uri.parse(url));
        var responseData = json.decode(response.body);

        emit(SearchPageState(responseData));
      }
      // TODO: implement event handler
    });
  }
}
