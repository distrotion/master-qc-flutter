import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
//-------------------------------------------------
import '../../data/global.dart';

//-------------------------------------------------
String server = 'http://localhost:10020/';
//-------------------------------------------------

abstract class Incoming_Event {}

class Incoming_clear_state extends Incoming_Event {}

class Incoming_TYPE_flush extends Incoming_Event {}

class Incoming_UNIT_flush extends Incoming_Event {}

class Incoming_ITEMs_flush extends Incoming_Event {}

class Incoming_MACHINE_flush extends Incoming_Event {}

class Incoming_METHOD_flush extends Incoming_Event {}

class Incoming_SPECIFICATION_flush extends Incoming_Event {}

class Incoming_CALCULATE_flush extends Incoming_Event {}

class Incoming_Bloc extends Bloc<Incoming_Event, mapdataset> {
  Incoming_Bloc()
      : super(
            mapdataset(set01: [], set02: [], set03: [], set04: [], set05: [])) {
    on<Incoming_clear_state>((event, emit) {
      return _Incoming_clear_state(
          mapdataset(set01: [], set02: [], set03: [], set04: [], set05: []),
          emit);
    });
    on<Incoming_TYPE_flush>((event, emit) {
      return _Incoming_TYPE_flush(
          mapdataset(set01: [], set02: [], set03: [], set04: [], set05: []),
          emit);
    });
    on<Incoming_UNIT_flush>((event, emit) {
      return _Incoming_UNIT_flush(
          mapdataset(set01: [], set02: [], set03: [], set04: [], set05: []),
          emit);
    });
    on<Incoming_ITEMs_flush>((event, emit) {
      return _Incoming_ITEMs_flush(
          mapdataset(set01: [], set02: [], set03: [], set04: [], set05: []),
          emit);
    });
    on<Incoming_MACHINE_flush>((event, emit) {
      return _Incoming_MACHINE_flush(
          mapdataset(set01: [], set02: [], set03: [], set04: [], set05: []),
          emit);
    });
    on<Incoming_METHOD_flush>((event, emit) {
      return _Incoming_METHOD_flush(
          mapdataset(set01: [], set02: [], set03: [], set04: [], set05: []),
          emit);
    });
    on<Incoming_SPECIFICATION_flush>((event, emit) {
      return _Incoming_SPECIFICATION_flush(
          mapdataset(set01: [], set02: [], set03: [], set04: [], set05: []),
          emit);
    });
    on<Incoming_CALCULATE_flush>((event, emit) {
      return _Incoming_CALCULATE_flush(
          mapdataset(set01: [], set02: [], set03: [], set04: [], set05: []),
          emit);
    });
  }

  Future<void> _Incoming_clear_state(
      mapdataset toAdd, Emitter<mapdataset> emit) async {
    mapdataset clear =
        mapdataset(set01: [], set02: [], set03: [], set04: [], set05: []);
    emit(clear);
  }

  Future<void> _Incoming_TYPE_flush(
      mapdataset toAdd, Emitter<mapdataset> emit) async {
    mapdataset output =
        mapdataset(set01: [], set02: [], set03: [], set04: [], set05: []);
    final response = await Dio().post(
      server + "master-ic-data-TYPE",
      data: {},
    );

    if (response.statusCode == 200) {
      // var databuff = jsonDecode(response.body);
      var databuff = response.data;
      // print(databuff);
      output.set01.clear();

      for (int i = 0; i < databuff['TYPE'].length; i++) {
        dataset cybuf = dataset();
        // print(databuff['TYPE'][i]['TYPE']);
        cybuf.f01 = databuff['TYPE'][i]['TYPE'].toString();
        cybuf.f02 = databuff['TYPE'][i]['masterID'].toString();
        output.set01.add(cybuf);
      }
      // print(output);
    } else {
      print("NO RESPONSE");
    }
    emit(output);
  }

  Future<void> _Incoming_UNIT_flush(
      mapdataset toAdd, Emitter<mapdataset> emit) async {
    mapdataset output =
        mapdataset(set01: [], set02: [], set03: [], set04: [], set05: []);
    final response = await Dio().post(
      server + "master-ic-data-UNIT",
      data: {},
    );

    if (response.statusCode == 200) {
      // var databuff = jsonDecode(response.body);
      var databuff = response.data;
      // print(databuff);
      output.set01.clear();

      for (int i = 0; i < databuff['UNIT'].length; i++) {
        dataset cybuf = dataset();
        // print(databuff['TYPE'][i]['TYPE']);
        cybuf.f01 = databuff['UNIT'][i]['TYPE-NAME'].toString();
        cybuf.f02 = databuff['UNIT'][i]['UNIT'].toString();
        cybuf.f03 = '-';
        cybuf.f04 = databuff['UNIT'][i]['masterID'].toString();
        output.set01.add(cybuf);
      }
      for (int i = 0; i < databuff['TYPE'].length; i++) {
        dataset cybuf = dataset();
        // print(databuff['TYPE'][i]['TYPE']);
        cybuf.f01 = databuff['TYPE'][i]['TYPE'].toString();
        cybuf.f02 = databuff['TYPE'][i]['masterID'].toString();
        output.set02.add(cybuf);
      }
    } else {
      print("NO RESPONSE");
    }

    emit(output);
  }

  Future<void> _Incoming_ITEMs_flush(
      mapdataset toAdd, Emitter<mapdataset> emit) async {
    mapdataset output =
        mapdataset(set01: [], set02: [], set03: [], set04: [], set05: []);
    final response = await Dio().post(
      server + "master-ic-data-ITEMs",
      data: {},
    );
    if (response.statusCode == 200) {
      // var databuff = jsonDecode(response.body);
      var databuff = response.data;
      print(databuff);
      output.set01.clear();
      output.set02.clear();

      for (int i = 0; i < databuff['ITEMs'].length; i++) {
        dataset cybuf = new dataset();
        // print(databuff['TYPE'][i]['TYPE']);
        cybuf.f01 = databuff['ITEMs'][i]['TYPE-NAME'].toString();
        cybuf.f02 = databuff['ITEMs'][i]['ITEMs'].toString();
        cybuf.f03 = databuff['ITEMs'][i]['RESULTFORMAT'].toString();
        cybuf.f04 = databuff['ITEMs'][i]['GRAPHTYPE'].toString();
        cybuf.f05 = databuff['ITEMs'][i]['INTERSECTION'].toString();
        cybuf.f06 = databuff['ITEMs'][i]['masterID'].toString();
        output.set01.add(cybuf);
      }
    } else {
      print("NO RESPONSE");
    }
    emit(output);
  }

  Future<void> _Incoming_MACHINE_flush(
      mapdataset toAdd, Emitter<mapdataset> emit) async {
    mapdataset output =
        mapdataset(set01: [], set02: [], set03: [], set04: [], set05: []);
    final response = await Dio().post(
      server + "master-ic-data-MACHINE",
      data: {},
    );
    if (response.statusCode == 200) {
      // var databuff = jsonDecode(response.body);
      var databuff = response.data;
      print(databuff);
      output.set01.clear();

      for (int i = 0; i < databuff['MACHINE'].length; i++) {
        dataset cybuf = new dataset();
        // print(databuff['TYPE'][i]['TYPE']);
        cybuf.f01 = databuff['MACHINE'][i]['METHOD'].toString();
        cybuf.f02 = databuff['MACHINE'][i]['MACHINE'].toString();
        cybuf.f03 = '-';
        cybuf.f04 = databuff['MACHINE'][i]['masterID'].toString();

        output.set01.add(cybuf);
      }
      print(output);
    } else {
      print("NO RESPONSE");
    }
    emit(output);
  }

  Future<void> _Incoming_METHOD_flush(
      mapdataset toAdd, Emitter<mapdataset> emit) async {
    mapdataset output =
        mapdataset(set01: [], set02: [], set03: [], set04: [], set05: []);
    final response = await Dio().post(
      server + "master-ic-data-METHOD",
      data: {},
    );
    if (response.statusCode == 200) {
      // var databuff = jsonDecode(response.body);
      var databuff = response.data;
      print(databuff);
      output.set01.clear();

      for (int i = 0; i < databuff['METHOD'].length; i++) {
        dataset cybuf = new dataset();
        // print(databuff['TYPE'][i]['TYPE']);
        cybuf.f01 = databuff['METHOD'][i]['ITEMs-NAME'].toString();
        cybuf.f02 = databuff['METHOD'][i]['METHOD-NAME'].toString();
        cybuf.f03 = databuff['METHOD'][i]['DOCUMENTSM'].toString();
        cybuf.f04 = '-';
        cybuf.f05 = databuff['METHOD'][i]['masterID'].toString();
        output.set01.add(cybuf);
      }
      print(output);
    } else {
      print("NO RESPONSE");
    }
    emit(output);
  }

  Future<void> _Incoming_SPECIFICATION_flush(
      mapdataset toAdd, Emitter<mapdataset> emit) async {
    mapdataset output =
        mapdataset(set01: [], set02: [], set03: [], set04: [], set05: []);
    final response = await Dio().post(
      server + "master-ic-data-SPECIFICATION",
      data: {},
    );
    if (response.statusCode == 200) {
      // var databuff = jsonDecode(response.body);
      var databuff = response.data;
      print(databuff);
      output.set01.clear();

      for (int i = 0; i < databuff['SPECIFICATION'].length; i++) {
        dataset cybuf = new dataset();
        // print(databuff['TYPE'][i]['TYPE']);
        cybuf.f01 = databuff['SPECIFICATION'][i]['ITEMs-NAME'].toString();
        cybuf.f02 = databuff['SPECIFICATION'][i]['SPECIFICATION'].toString();
        cybuf.f03 = databuff['SPECIFICATION'][i]['masterID'].toString();
        output.set01.add(cybuf);
      }
      print(output);
      print(output);
    } else {
      print("NO RESPONSE");
    }
    emit(output);
  }

  Future<void> _Incoming_CALCULATE_flush(
      mapdataset toAdd, Emitter<mapdataset> emit) async {
    mapdataset output =
        mapdataset(set01: [], set02: [], set03: [], set04: [], set05: []);
    final response = await Dio().post(
      server + "master-ic-data-CALCULATE",
      data: {},
    );
    if (response.statusCode == 200) {
      // var databuff = jsonDecode(response.body);
      var databuff = response.data;
      print(databuff);
      // output.set01.clear();

      // for (int i = 0; i < databuff['UNIT'].length; i++) {
      //   dataset cybuf = new dataset();
      //   // print(databuff['TYPE'][i]['TYPE']);
      //   cybuf.f01 = databuff['UNIT'][i]['TYPE'].toString();
      //   cybuf.f02 = databuff['UNIT'][i]['UNIT'].toString();
      //   cybuf.f03 = databuff['UNIT'][i]['masterID'].toString();
      //   output.set01.add(cybuf);
      // }
      print(output);
    } else {
      print("NO RESPONSE");
    }
    emit(output);
  }
}
