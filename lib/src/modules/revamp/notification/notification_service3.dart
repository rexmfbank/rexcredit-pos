import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

// Define the structure for the received data for clarity
class Message {
  final String user;
  final String message;

  Message(this.user, this.message);

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      json['user'] ?? 'Unknown User',
      json['message'] ?? 'No message content',
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Laravel Echo WebSocket Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      home: const WebSocketEchoDemo(),
    );
  }
}

class WebSocketEchoDemo extends StatefulWidget {
  const WebSocketEchoDemo({super.key});

  @override
  State<WebSocketEchoDemo> createState() => _WebSocketEchoDemoState();
}

class _WebSocketEchoDemoState extends State<WebSocketEchoDemo> {
  // --- CONFIGURATION ---
  // 1. WebSocket URL (e.g., 'http://192.168.1.100:6001')
  final String _wsUrl = 'http://localhost:6001';
  // 2. Channel Name (MUST match the Laravel route/channel definition)
  // Use 'private-...' or 'presence-...' for authenticated channels
  final String _channelName = 'private-orders.1';
  // 3. Event Name (MUST match the event class name or broadcastAs name)
  final String _eventName = 'OrderShipped';
  // 4. Auth Token (Required for private/presence channels)
  final String _authToken = 'YOUR_BEARER_TOKEN_HERE';
  // ---------------------

  io.Socket? _socket;
  String _status = 'Disconnected';
  Message? _latestMessage;

  @override
  void initState() {
    super.initState();
    _connectAndSubscribe();
  }

  void _connectAndSubscribe() {
    try {
      // 1. Connection Options:
      // - transports: ['websocket'] is crucial for Echo.
      // - extraHeaders: Used by the Echo server to authenticate private channels
      //   by passing the token to the Laravel backend for validation.
      _socket = io.io(
        _wsUrl,
        io.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .setExtraHeaders({
          'Authorization': 'Bearer $_authToken',
        })
            .build(),
      );

      // 2. Set up Connection Listeners
      _socket!.onConnect((_) {
        setState(() {
          _status = 'Connected! Subscribing to $_channelName...';
        });
        _subscribeToChannel();
      });

      _socket!.onDisconnect((_) {
        setState(() {
          _status = 'Disconnected';
        });
      });

      _socket!.onConnectError((err) {
        setState(() {
          _status = 'Connection Error: $err';
        });
        print('Connection Error: $err');
      });

      _socket!.onError((err) {
        setState(() {
          _status = 'General Error: $err';
        });
        print('Socket Error: $err');
      });

      // 3. Connect!
      _socket!.connect();
    } catch (e) {
      setState(() {
        _status = 'Error during setup: $e';
      });
      print('Socket connection setup failed: $e');
    }
  }

  void _subscribeToChannel() {
    if (_socket != null && _socket!.connected) {
      // The 'subscribe' event is standard for Laravel Echo servers.
      // It uses the Authorization header set during connection for validation.
      _socket!.emit('subscribe', {
        'channel': _channelName,
      });

      setState(() {
        _status = 'Subscription request sent for $_channelName. Waiting for authentication response...';
      });

      // 4. Set up Event Listener
      // Laravel Echo names events as 'channelName:eventName'.
      // e.g., 'private-orders.1:OrderShipped'
      final fullEventName = '$_channelName:$_eventName';

      _socket!.on(fullEventName, (data) {
        if (data != null && data is Map<String, dynamic>) {
          final message = Message.fromJson(data);
          setState(() {
            _latestMessage = message;
            _status = 'Event received on $fullEventName!';
          });
          print('Event Data Received: $data');
        } else {
          setState(() {
            _status = 'Event received, but data format was unexpected.';
          });
        }
      });

      // 5. Handle subscription failures (e.g., failed authorization)
      _socket!.on('subscription_error', (data) {
        if (data != null && data['channel'] == _channelName) {
          setState(() {
            _status = 'Subscription FAILED for $_channelName. Check Auth Token and security rules.';
          });
          print('Subscription Error Data: $data');
        }
      });

    } else {
      setState(() {
        _status = 'Socket is not connected. Cannot subscribe.';
      });
    }
  }

  @override
  void dispose() {
    // Clean up the connection when the widget is removed
    _socket?.disconnect();
    _socket?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Laravel Echo Demo'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Card(
                elevation: 4,
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Configuration:',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor),
                      ),
                      const SizedBox(height: 8),
                      _buildConfigRow('URL', _wsUrl),
                      _buildConfigRow('Channel', _channelName),
                      _buildConfigRow('Event', _eventName),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Status:',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(
                _status,
                style: TextStyle(
                  color: _socket?.connected == true ? Colors.green : Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Latest Event Data:',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _latestMessage == null
                      ? const Text(
                    'Waiting for event...',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  )
                      : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDataRow('User', _latestMessage!.user),
                      _buildDataRow('Message', _latestMessage!.message),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConfigRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text('$label:',
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget _buildDataRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text('$label:',
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(child: Text(value, maxLines: 2, overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }
}
