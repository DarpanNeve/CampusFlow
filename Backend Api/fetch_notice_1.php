<?php

try {
    $conn = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    $server = new \Ratchet\WebSocket\WsServer(new class($conn) implements \Ratchet\MessageComponentInterface {
        protected $conn;

        public function __construct($conn) {
            $this->conn = $conn;
        }

        public function onOpen(\Ratchet\ConnectionInterface $conn) {
            // Do nothing on open
        }

        public function onClose(\Ratchet\ConnectionInterface $conn) {
            // Do nothing on close
        }

        public function onError(\Ratchet\ConnectionInterface $conn, \Exception $e) {
            // Log the error
        }

        public function onMessage(\Ratchet\ConnectionInterface $from, $msg) {
            $stmt = $this->conn->prepare("SELECT * FROM user_chat");
            $stmt->execute();

            $data = $stmt->fetchAll(PDO::FETCH_ASSOC);

            $json = json_encode($data);

            $from->send($json);
        }
    });

    $loop   = \React\EventLoop\Factory::create();
    $socket = new \React\Socket\Server('0.0.0.0:8080', $loop);
    $server = new \Ratchet\Server\IoServer($server, $socket, $loop);

    $server->run();
}
catch(PDOException $e) {
    echo "Error: " . $e->getMessage();
}
>

