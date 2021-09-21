typedef void EventCallback(arg);

class EventBus {
  // 私有构造函数
  EventBus._internal();

  // 保存单例
  static EventBus _singleton = new EventBus._internal();

  // 工厂构造
  factory EventBus() => _singleton;

  // 保存事件订阅者队列
  var _emap = new Map<Object, List<EventCallback>>();

  // 添加订阅者
  void on(eventName, EventCallback f ){
    if( eventName == null || f == null ) return;
    _emap[eventName] ??= <EventCallback>[];
    _emap[eventName]?.add(f);
  }

  // 移除订阅者
  void off(eventName, [EventCallback? f] ) {
    var list = _emap[eventName];
    if(eventName == null || list == null) return;
    if( f == null){
      // _emap[eventName] = null;  这里因为空安全不知道怎么表示
      list.removeAt(eventName);
      return;
    }else{
      list.remove(f);
    }
  }

  // 触发事件，事件触发后该事件订阅者都会被调用
  void emit( evnetName, [arg]) {
    var list = _emap[evnetName];
    if( list == null ) return;
    int len = list.length - 1;
    // 反向遍历，防止订阅者在回调中移除自身带来的下标错位
    for(var i = len; i > -1; --i){
      list[i] (arg);
    }
  }

  // 定义一个全局变量，页面引入后可直接使用bus
  var bus = new EventBus();
}