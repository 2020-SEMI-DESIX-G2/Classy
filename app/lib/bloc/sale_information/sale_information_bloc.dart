
import 'package:classy/bloc/authorization/authorization_bloc.dart';
import 'package:classy/models/responses/base_response.dart';
import 'package:classy/provider/provider_client.dart';
import 'package:rxdart/rxdart.dart';

class SaleInformationBloc {

  final ProviderClient client = ProviderClient();

  final BehaviorSubject _saleCarController = BehaviorSubject<List>();
  final PublishSubject _loadingData = PublishSubject<bool>();

  ValueStream<List> get saleCar => _saleCarController.stream;
  ValueStream<List> get infoCar => _saleCarController.stream;

  Stream<bool> get loading => _loadingData.stream;

  Function(List) get changeSaleCar => _saleCarController.sink.add;

  void sumSaleCar(saleInformation) {
    
    if (saleInformation.number < 5) {
      List list =_saleCarController.stream.value;
      list[list.indexOf(saleInformation)].sumNumber();
      changeSaleCar(list);
    }
  }

  void minSaleCar(saleInformation) {
    
    if (saleInformation.number > 0) {
      List list =_saleCarController.stream.value;
      list[list.indexOf(saleInformation)].minNumber();
      changeSaleCar(list);
    }
  }

  Future<bool> executePayment(List sales) async {

    _loadingData.sink.add(true);

    Map<String, dynamic> request = Map();

    List list =_saleCarController.stream.value;

    double subTotalAmount = list.fold(0, (previous, current) => previous + (double.parse(current.amount)* current.number));
    double itbms = subTotalAmount * 0.07;
    (subTotalAmount + itbms).toStringAsFixed(2);

    request['total'] = (subTotalAmount + itbms).toStringAsFixed(2);

    request['productos'] = list.where((element) => element.number > 0).map((element) {

      return {
        'id': element.id,
        'titulo': element.name,
        'precio': element.amount,
        'cantidad': element.number
      };
    }).toList();

    request['idUsuario'] = authBloc.user['id'];

    BaseResponse response = await client.post(request, 'ventas/');

    _loadingData.sink.add(false);
    if (response.statusCode == 200) {

      return true;
    } else {
      return false;
    }
  }

  void dispose() {
    _loadingData.close();
    _saleCarController.close();
  }
}