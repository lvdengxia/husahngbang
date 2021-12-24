class DeliverState {

  late String orderSn;

  late int maxSize;

  /// 上传后的img链接
  List<String>  imgUrl1 =  [] ;
  List<String>  imgUrl2 =  [] ;

  DeliverState() {
    ///Initialize variables
    orderSn = '';
    maxSize = 4;
  }
}
