import 'package:rx_bloc/model/albums_model.dart';
import 'package:rx_bloc/service/network/api_provider.dart';
import 'package:rx_bloc/util/tools.dart';

import '../abstracts.dart';
import '../constants.dart';

class GetAlbumsRepository implements AlbumsRepository {
  final ApiProvider _apiProvider = ApiProvider.internal();
  List<AlbumsModel> _listAlbums = [];

  @override
  Future<List<AlbumsModel>> getAlbumsList() async {
    await _apiProvider.get(
        apiRoute: url,
        successResponse: (response) {
          _listAlbums = albumFromJson(response);
        },
        errorResponse: (response) {
          Tools().logger.e('Error');
        });

    return _listAlbums;
  }

  List<AlbumsModel> get listAlbums => _listAlbums;
}
