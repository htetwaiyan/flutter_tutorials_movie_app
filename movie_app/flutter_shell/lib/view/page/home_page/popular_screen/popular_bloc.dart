import 'dart:convert';

import 'package:flutter_shell/network/base_network.dart';
import 'package:flutter_shell/ob/movie_ob.dart';
import 'package:flutter_shell/ob/response_ob.dart';
import 'package:rxdart/rxdart.dart';


class PopularBloc extends BaseNetwork{


  PublishSubject<ResponseOb> popularController=PublishSubject<ResponseOb>();

  Observable<ResponseOb> popularStream(){
    return popularController.stream;
  }


  getPopularMovie(){
    ResponseOb rv=ResponseOb(data: null,message: MsgState.loading);
    popularController.sink.add(rv);


    getRequest(endUrl: "popular?api_key=f45b7e038139d8e9bb9f8878d46b6030&language=en-US&page=1").then((resp){

      if(resp.message==MsgState.data){
        MovieOb mo=MovieOb.fromJson(json.decode(resp.data.toString()));
        rv.message=MsgState.data;
        rv.data=mo.results;
        popularController.sink.add(rv);

      }else{
        rv.message=MsgState.error;
        rv.data=resp.data;
        popularController.sink.add(rv);
      }

    });




  }


  void dispose(){
    popularController.close();
  }




}