class LoadedState {

  late String orderSn;
  late int  maxSize;
  late bool uploading;

  /// 上传后的img链接
  List<String>  imgUrl =  [] ;

  LoadedState() {
    ///Initialize variables
    orderSn = '';
    maxSize = 4;
    uploading = false;
  }
}
