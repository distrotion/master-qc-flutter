import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
//-------------------------------------------------
import '../../data/global.dart';

//-------------------------------------------------
String server = 'http://localhost:10020/';
//-------------------------------------------------

abstract class Final_Event {}

class Final_clear_state extends Final_Event {}

class Final_TYPE_flush extends Final_Event {}

class Final_UNIT_flush extends Final_Event {}

class Final_ITEMs_flush extends Final_Event {}

class Final_MACHINE_flush extends Final_Event {}

class Final_METHOD_flush extends Final_Event {}

class Final_SPECIFICATION_flush extends Final_Event {}

class Final_CALCULATE_flush extends Final_Event {}

class Final_Bloc extends Bloc<Final_Event, mapdataset> {
  Final_Bloc()
      : super(
            mapdataset(set01: [], set02: [], set03: [], set04: [], set05: [])) {
    on<Final_clear_state>((event, emit) {
      return _Final_clear_state(
          mapdataset(set01: [], set02: [], set03: [], set04: [], set05: []),
          emit);
    });
    on<Final_TYPE_flush>((event, emit) {
      return _Final_TYPE_flush(
          mapdataset(set01: [], set02: [], set03: [], set04: [], set05: []),
          emit);
    });
    on<Final_UNIT_flush>((event, emit) {
      return _Final_UNIT_flush(
          mapdataset(set01: [], set02: [], set03: [], set04: [], set05: []),
          emit);
    });
    on<Final_ITEMs_flush>((event, emit) {
      return _Final_ITEMs_flush(
          mapdataset(set01: [], set02: [], set03: [], set04: [], set05: []),
          emit);
    });
    on<Final_MACHINE_flush>((event, emit) {
      return _Final_MACHINE_flush(
          mapdataset(set01: [], set02: [], set03: [], set04: [], set05: []),
          emit);
    });
    on<Final_METHOD_flush>((event, emit) {
      return _Final_METHOD_flush(
          mapdataset(set01: [], set02: [], set03: [], set04: [], set05: []),
          emit);
    });
    on<Final_SPECIFICATION_flush>((event, emit) {
      return _Final_SPECIFICATION_flush(
          mapdataset(set01: [], set02: [], set03: [], set04: [], set05: []),
          emit);
    });
    on<Final_CALCULATE_flush>((event, emit) {
      return _Final_CALCULATE_flush(
          mapdataset(set01: [], set02: [], set03: [], set04: [], set05: []),
          emit);
    });
  }

  Future<void> _Final_clear_state(
      mapdataset toAdd, Emitter<mapdataset> emit) async {
    mapdataset clear =
        mapdataset(set01: [], set02: [], set03: [], set04: [], set05: []);
    emit(clear);
  }

  Future<void> _Final_TYPE_flush(
      mapdataset toAdd, Emitter<mapdataset> emit) async {
    mapdataset output =
        mapdataset(set01: [], set02: [], set03: [], set04: [], set05: []);
    final response = await Dio().post(
      server + "master-fn-data-TYPE",
      data: {},
    );

    if (response.statusCode == 200) {
      // var databuff = jsonDecode(response.body);
      var databuff = response.data;
      // print(databuff);
      output.set01.clear();

      for (int i = 0; i < databuff['TYPE'].length; i++) {
        dataset cybuf = new dataset();
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

  Future<void> _Final_UNIT_flush(
      mapdataset toAdd, Emitter<mapdataset> emit) async {
    mapdataset output =
        mapdataset(set01: [], set02: [], set03: [], set04: [], set05: []);
    final response = await Dio().post(
      server + "master-fn-data-UNIT",
      data: {},
    );

    if (response.statusCode == 200) {
      // var databuff = jsonDecode(response.body);
      var databuff = response.data;
      // print(databuff);
      output.set01.clear();

      for (int i = 0; i < databuff['UNIT'].length; i++) {
        dataset cybuf = new dataset();
        // print(databuff['TYPE'][i]['TYPE']);
        cybuf.f01 = databuff['UNIT'][i]['TYPE-NAME'].toString();
        cybuf.f02 = databuff['UNIT'][i]['UNIT'].toString();
        cybuf.f03 = '-';
        cybuf.f04 = databuff['UNIT'][i]['masterID'].toString();
        output.set01.add(cybuf);
      }
      print(output);
    } else {
      print("NO RESPONSE");
    }

    emit(output);
  }

  Future<void> _Final_ITEMs_flush(
      mapdataset toAdd, Emitter<mapdataset> emit) async {
    mapdataset output =
        mapdataset(set01: [], set02: [], set03: [], set04: [], set05: []);
    final response = await Dio().post(
      server + "master-fn-data-ITEMs",
      data: {},
    );
    if (response.statusCode == 200) {
      // var databuff = jsonDecode(response.body);
      var databuff = response.data;
      print(databuff);
      output.set01.clear();

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
      print(output);
    } else {
      print("NO RESPONSE");
    }
    emit(output);
  }

  Future<void> _Final_MACHINE_flush(
      mapdataset toAdd, Emitter<mapdataset> emit) async {
    mapdataset output =
        mapdataset(set01: [], set02: [], set03: [], set04: [], set05: []);
    final response = await Dio().post(
      server + "master-fn-data-MACHINE",
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

  Future<void> _Final_METHOD_flush(
      mapdataset toAdd, Emitter<mapdataset> emit) async {
    mapdataset output =
        mapdataset(set01: [], set02: [], set03: [], set04: [], set05: []);
    final response = await Dio().post(
      server + "master-fn-data-METHOD",
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

  Future<void> _Final_SPECIFICATION_flush(
      mapdataset toAdd, Emitter<mapdataset> emit) async {
    mapdataset output =
        mapdataset(set01: [], set02: [], set03: [], set04: [], set05: []);
    final response = await Dio().post(
      server + "master-fn-data-SPECIFICATION",
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

  Future<void> _Final_CALCULATE_flush(
      mapdataset toAdd, Emitter<mapdataset> emit) async {
    mapdataset output =
        mapdataset(set01: [], set02: [], set03: [], set04: [], set05: []);
    final response = await Dio().post(
      server + "master-fn-data-CALCULATE",
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
