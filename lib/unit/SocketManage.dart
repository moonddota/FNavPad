import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

class SocketManage {
  SocketManage._();

  static SocketManage get instance => _getInstance();
  static SocketManage? _instance;

  static SocketManage _getInstance() {
    _instance ??= SocketManage._();
    return _instance!;
  }

  final _ip = "127.0.0.1";
  final _port = 8000;

  late ServerSocket? _serverSocket; //服务端socket
  late Socket? _socket;
  late SocketCallback? _socketCallback;
  final _sb = StringBuffer();
  final HEADER = "##&&";
  final END = "\$\$^^";

  void serverBind(SocketCallback callback) async {
    _socketCallback = callback;
    ServerSocket.bind(_ip, _port).then((ss) {
      print('服务器绑定成功- $_ip $_port');
      _serverSocket = ss;
      _serverSocket?.handleError((e) {
        print('socketError $e');
      });
      _serverSocket?.listen(handleListen, onError: (e, t) {
        print("serverSocket $e $t");
      }, onDone: () {
        print("serverSocket  onDone");
      }, cancelOnError: true);
    });
  }

  void handleListen(Socket s) {
    _socket = s;
    print('_socket连接建立');
    _socketCallback?.onConnect();
    _socket?.listen(handleMessage,
        onError: handleError, onDone: handleDone, cancelOnError: true);
  }

  handleMessage(Uint8List e) {
    // print('收到客户端消息：$e');
    String s = String.fromCharCodes(e);
    // String s = utf8.decode(e);
    if (s.contains(HEADER)) {
      _sb.clear();
      s = s.split(HEADER)[1];
    }
    if (s.contains(END)) {
      s = s.split(END)[0];
      _sb.write(s);
      // print(_sb.toString());
      _socketCallback?.receiveMessage(_sb.toString());
      return;
    }
    _sb.write(s);
  }

  void handleError(Object e) {
    print('socketError：$e  ');
  }

  void handleDone() {
    print('_socket链接断开');
    _socketCallback?.onDone();
  }

  //服务端发送消息
  void sendMsg(String msg) {
    if (msg.isEmpty || _socket == null) {
      return;
    }
    // _socket?.write(Utf8Encoder().convert("$HEADER$msg$END"));
    _socket?.write("$HEADER$msg$END");
    // print("发送  $HEADER$msg$END" );
  }

  close() {
    _socket?.close();
    _serverSocket?.close();
    _socketCallback == null;
  }
}

class SocketCallback {
  Function() onConnect;
  Function() onDone;
  Function(String msg) receiveMessage;

  SocketCallback(
      {required this.onConnect,
      required this.onDone,
      required this.receiveMessage});
}
