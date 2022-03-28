import 'package:flutter/material.dart';
import 'package:rx_bloc/bloc/albums_bloc.dart';
import 'package:rx_bloc/common/bloc_module/bloc_base/base_model.dart';
import 'package:rx_bloc/common/bloc_module/bloc_base/bloc_provider.dart';
import 'package:rx_bloc/model/albums_model.dart';
import 'package:rx_bloc/view/widget/error_widget.dart';
import 'package:rx_bloc/view/widget/list_row_widget.dart';
import 'package:rx_bloc/view/widget/loading_widget.dart';
import 'package:rx_bloc/view/widget/text_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final AlbumsBloc _albumsBloc;

  @override
  void initState() {
    super.initState();
    _albumsBloc.getAlbums();

  }

  @override
  void dispose() {
    super.dispose();
    _albumsBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: const TextWidget(text: 'Albums'),
      ),
      body: Container(
        child: _body(context),
      ),
    );
  }

  _body(BuildContext context) {
    return Column(
      children: [
        StreamBuilder<BaseModel<List<AlbumsModel>>>(
          stream: _albumsBloc.albumsStream,
          builder: (context, snapshot) {
            final data = snapshot.data?.data ?? [];

            return snapshot.data!.status == Status.LOADING
                ? const LoadingWidget()
                : snapshot.data!.status == Status.ERROR
                    ? ErrorTextWidget(
                        message: snapshot.data!.message,
                        onTap: () => _albumsBloc.getAlbums(),
                      )
                    : BlocProvider(
                        blocBuilder: () => _albumsBloc,
                        blocDispose: (bloc) => _albumsBloc.dispose(),
                        child: _list(snapshot.data!.data),
                      );
            // print('@@@@@@@@@ ${snapshot.hasData} - ${snapshot.hasError}');

            // switch (snapshot.data!.status) {
            //   case Status.LOADING:
            //     return const LoadingWidget();
            //   default:
            //     if (snapshot.hasError) {
            //       return ErrorTextWidget(
            //         message: snapshot.data!.message,
            //         onTap: () => _albumsBloc.getAlbums(),
            //       );
            //     } else {
            //       return _list(snapshot.data!.data);
            //     }
            // }
            // if (!snapshot.hasError) {
            //   switch (snapshot.data!.status) {
            //     case Status.LOADING:
            //       return const LoadingWidget();
            //
            //     case Status.COMPLETED:
            //       return _list(snapshot.data!.data);
            //
            //     case Status.ERROR:
            //       return ErrorTextWidget(
            //         message: snapshot.data!.message,
            //         onTap: () => _albumsBloc.getAlbums(),
            //       );
            //     default:
            //       return Container(
            //         child: Text('fffffff'),
            //       );
            //   }
            // }
            // return Container(
            //   child: Text('gggggg'),
            // );
          },
        )

        // BlocBuilder<AlbumsBloc, AlbumsState>(
        //     builder: (BuildContext context, AlbumsState state) {
        //       if (state is AlbumsListError) {
        //         final error = state.error;
        //         String message = '${error.message}\nTap to Retry.';
        //         return ErrorTextWidget(
        //           message: message,
        //           onTap: _loadAlbums,
        //         );
        //       }
        //       if (state is AlbumsLoaded) {
        //         List<AlbumsModel> albums = state.albums;
        //         return _list(albums);
        //       }
        //       return const LoadingWidget();
        //     }),
      ],
    );
  }

  Widget _list(List<AlbumsModel>? albums) {
    return Expanded(
      child: ListView.builder(
        itemCount: albums!.length,
        itemBuilder: (_, index) {
          AlbumsModel album = albums[index];
          return ListRowWidget(album: album);
        },
      ),
    );
  }
}
