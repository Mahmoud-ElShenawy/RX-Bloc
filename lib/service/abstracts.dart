import 'package:rx_bloc/model/albums_model.dart';

abstract class AlbumsRepository {
  Future<List<AlbumsModel>> getAlbumsList();
}
