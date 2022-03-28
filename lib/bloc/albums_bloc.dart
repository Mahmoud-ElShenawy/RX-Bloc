import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:rx_bloc/common/bloc_module/bloc_base/base_model.dart';
import 'package:rx_bloc/common/bloc_module/bloc_base/bloc_provider.dart';
import 'package:rx_bloc/model/albums_model.dart';
import 'package:rx_bloc/service/abstracts.dart';
import 'package:rx_bloc/util/tools.dart';
import 'package:rxdart/rxdart.dart';

@immutable
class AlbumsBloc extends BlocBase {
  // ChuckCategoryRepository _chuckRepository;
  // StreamController _chuckListController;
  //
  // StreamSink<Response<chuckCategories>> get chuckListSink =>
  //     _chuckListController.sink;
  //
  // Stream<Response<chuckCategories>> get chuckListStream =>
  //     _chuckListController.stream;
  //
  // ChuckCategoryBloc() {
  //   _chuckListController = StreamController<Response<chuckCategories>>();
  //   _chuckRepository = ChuckCategoryRepository();
  //   fetchCategories();
  // }
  //
  // fetchCategories() async {
  //   chuckListSink.add(Response.loading('Getting Chuck Categories.'));
  //   try {
  //     chuckCategories chuckCats =
  //     await _chuckRepository.fetchChuckCategoryData();
  //     chuckListSink.add(Response.completed(chuckCats));
  //   } catch (e) {
  //     chuckListSink.add(Response.error(e.toString()));
  //     print(e);
  //   }
  // }
  //
  // dispose() {
  //   _chuckListController?.close();
  // }

  final AlbumsRepository repo;
  BehaviorSubject<BaseModel<List<AlbumsModel>>> albumsData;

  Stream<BaseModel<List<AlbumsModel>>> get albumsStream => albumsData.stream;

  StreamSink<BaseModel<List<AlbumsModel>>> get albumsSink => albumsData.sink;

  AlbumsBloc({required this.repo})
      : albumsData = BehaviorSubject<BaseModel<List<AlbumsModel>>>();

  getAlbums() async {
    albumsSink.add(BaseModel.loading('Getting Albums Model'));
    try {
      List<AlbumsModel> albumsModel = await repo.getAlbumsList();
      albumsSink.add(BaseModel.completed(albumsModel));
    } catch (e) {
      switch (e.runtimeType) {
        case DioError:
          final res = (e as DioError);
          albumsSink.add(BaseModel.error(
              "${res.response?.statusCode} -> ${res.response?.statusMessage}"));
          Tools().logger.e(
              "Got error : ${res.response?.statusCode} -> ${res.response?.statusMessage} \n response: ${res.response}");
          break;
        default:
      }
    }

    // try {
    //   List<AlbumsModel> albumsModel = await _albumsRepository!.getAlbumsList();
    //   getAlbumsSink.add(BaseModel.completed(albumsModel));
    // } catch (e) {
    //   getAlbumsSink.add(BaseModel.error(e.toString()));
    //   print(e);
    // }
  }

  @override
  void dispose() {
    albumsData.close();
  }
}

// getSubUsers(int userID) {
//   subUsersData.sink.add(BaseModel.loading(""));
//   repo.getSubUsersData(userID: userID).then((value) {
//     subUsersData.sink.add(BaseModel.completed(value[0].children ?? []));
//   }).catchError((obj) {
//     // non-200 error goes here.
//     switch (obj.runtimeType) {
//       case DioError:
//         // Here's the sample to get the failed response error code and message
//         final res = (obj as DioError);
//         subUsersData.sink.add(BaseModel.error(
//             "${res.response?.statusCode} -> ${res.response?.statusMessage}"));
//         // moviesFetcher.sink.addError(res);
//         logger.e(
//             "Got error : ${res.response?.statusCode} -> ${res.response?.statusMessage} \n response: ${res.response}");
//         break;
//       default:
//     }
//   });
// }
