
class ResponseOb{
  dynamic data;
  MsgState message;
  ResponseOb({this.data, this.message});
}

enum MsgState{
  error,
  loading,
  data
}