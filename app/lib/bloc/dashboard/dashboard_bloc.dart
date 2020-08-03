
import 'package:classy/bloc/authorization/authorization_bloc.dart';
import 'package:classy/models/responses/base_response.dart';
import 'package:classy/provider/provider_client.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class DashboardBloc {

  final ProviderClient client = ProviderClient();
  final BehaviorSubject _postController = BehaviorSubject<List>();
  final PublishSubject _hasData = PublishSubject<bool>();

  List get posts => _postController.stream.value;

  Stream<bool> get data => _hasData.stream;

  loadPosts() async {

    BaseResponse response = await client.get(path: 'producto/');
    if (response.statusCode == 200) {

      if (null == _postController.stream.value) {
        _postController.sink.add(response.payload['productos']);
        _hasData.sink.add(true);
      }
    }
  }

  void saveToCar(producto) async {

    producto['idUsuario'] = authBloc.user['id'];
    producto['idProducto'] = producto['_id'];

    await client.post(producto, 'carrito/');
  }


  void dispose() {
    _postController.close();
    _hasData.close();
  }
}