import 'package:bloc/bloc.dart';
import 'package:clima_app/core/helpers/firebase_messaging_helper.dart';

class FirebaseTokenCubit extends Cubit<void> {
  FirebaseTokenCubit() : super(null);

  Future registerToken() async {
    FirebaseMessagingHelper.registerFirebaseToken();
  }
}
