import 'package:flutter/material.dart';
import 'package:flutter_shell/localization/app_translation.dart';
import 'package:flutter_shell/ob/movie_ob.dart';
import 'package:flutter_shell/ob/response_ob.dart';
import 'package:flutter_shell/tools/internet_provider.dart';
import 'package:flutter_shell/utils/app_constants.dart';
import 'package:flutter_shell/view/page/home_page/upcoming_screen/upcoming_bloc.dart';



class UpcomingScreen extends StatefulWidget {
  @override
  _UpcomingScreenState createState() => _UpcomingScreenState();
}

class _UpcomingScreenState extends State<UpcomingScreen> {

  UpcomingBloc bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc=UpcomingBloc();
    bloc.getUpcomingMovie();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    bloc.dispose();
  }


  @override
  Widget build(BuildContext context) {
    bool isInternet=InternetProvider.of(context).internet;
    return Column(
      children: <Widget>[
        isInternet?Container():Container(
          width: double.infinity,
          color: Colors.red,
          child: Center(child: Text(AppTranslations.of(context).trans("no_internet"))),
        ),
        Expanded(
          child: StreamBuilder(
            stream: bloc.upcomingStream(),
            initialData: ResponseOb(data: null,message: MsgState.loading),
            builder: (BuildContext context, AsyncSnapshot snapshot) {

              ResponseOb ob=snapshot.data;
              if(ob.message==MsgState.loading){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }else if(ob.message==MsgState.data){
                List<Results> results=ob.data;
                return ListView.builder(itemBuilder: (context,index){

                  return movieWidget(results[index]);

                },itemCount: results.length,);

              }else{
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(child: Text(ob.data)),
                    Center(
                      child: RaisedButton(
                        textColor:Colors.white,
                        color:Theme.of(context).primaryColor,
                        child: Text(AppTranslations.of(context).trans("try_again")),
                        onPressed: (){
                          bloc.getUpcomingMovie();
                        },
                      ),
                    )
                  ],
                );
              }

            },
          ),
        ),
      ],
    );
  }


  Widget movieWidget(Results res){
    return Column(
      children: <Widget>[
        Image.network(IMG_BASE_URL+res.backdropPath),
        Text(res.title),
      ],
    );
  }

}
