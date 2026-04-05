

import 'package:bloc/bloc.dart';
import 'package:weather_app/bloc/UserEvent.dart';
import 'package:weather_app/bloc/UserState.dart';

class UserBloc extends Bloc<UserEvent, UserState> {

  DBService dbService;

  UserBloc({required this.dbService}) : super(UserInitialState) {


  }
}