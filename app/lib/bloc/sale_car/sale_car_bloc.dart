
import 'package:classy/bloc/authorization/authorization_bloc.dart';
import 'package:classy/models/responses/base_response.dart';
import 'package:classy/provider/provider_client.dart';
import 'package:rxdart/subjects.dart';

class SaleCarBloc {

  final ProviderClient client = ProviderClient();
  final BehaviorSubject _postController = BehaviorSubject<List>();
  final PublishSubject _loadingData = PublishSubject<bool>();


  Stream<bool> get loading => _loadingData.stream;
  List get posts => _postController.stream.value;

  loadCar() async {

    _loadingData.sink.add(true);

    BaseResponse response = await client.get(request: authBloc.user['id'], path: 'carrito/');

    _loadingData.sink.add(false);

    if (response.statusCode == 200) {
      _postController.sink.add(response.payload['carritos']);
    }
  }

  deleteItem(post) async {

    List posts = _postController.stream.value;
    posts.remove(post);
    _postController.sink.add(posts);
    _loadingData.sink.add(false);

    await client.delete(request: post['_id'], path: 'carrito/');
  }

  void dispose() {
    _postController.close();
    _loadingData.close();
  }
}