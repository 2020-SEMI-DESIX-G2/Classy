
import 'package:classy/bloc/authorization/authorization_bloc.dart';
import 'package:classy/models/responses/base_response.dart';
import 'package:classy/provider/provider_client.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class MyShopsBloc {

  final ProviderClient client = ProviderClient();
  final BehaviorSubject _postController = BehaviorSubject<List>();
  final PublishSubject _loadingData = PublishSubject<bool>();

  Stream<bool> get loading => _loadingData.stream;
  ValueStream<List> get postStream => _postController.stream;
  
  List get posts => _postController.stream.value;

  Function(List) get changePost => _postController.sink.add;

  loadShops() async {

    _loadingData.sink.add(true);

    BaseResponse response = await client.get(request: authBloc.user['id'], path: 'ventas/');

    _loadingData.sink.add(false);

    if (response.statusCode == 200) {
      _postController.sink.add(response.payload['ventas']);
    }
  }

  void dispose() {
    _postController.close();
    _loadingData.close();
  }
}