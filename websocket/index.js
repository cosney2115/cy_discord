const WebSocket = require("ws");

class WebSocketClient {
  constructor(token, guildId, intents) {
    this.token = token;
    this.guildId = guildId;
    this.intents = intents || 513;
    this.socket = null;
  }

  connect() {
    this.socket = new WebSocket('wss://gateway.discord.gg/?v=10&encoding=json');

    this.socket.on("error", (err) => emit("discord:error", {
      type: "error",
      message: err.message
    }));

    this.socket.on("close", (code, reason) => {
      emit("discord:error", {
        type: "close",
        code,
        reason: reason?.toString() || ""
      });
      setTimeout(() => this.connect(), 2000);
    });

    this.socket.on("message", (data) => {
      const payload = JSON.parse(data.toString());

      if (payload.op === 10) {
        this.heartbeatInterval = payload.d.heartbeat_interval;
        this.startHeartbeat();
        this.identify();
      }

      if (payload.op === 0) emit("discord:message", payload);

      if (payload.op === 7 || payload.op === 9) this.socket.close();
    });
  }

  startHeartbeat() {
    setInterval(() => {
      if (this.socket?.readyState === WebSocket.OPEN) {
        this.socket.send(JSON.stringify({ op: 1, d: null }));
      }
    }, this.heartbeatInterval);
  }

  identify() {
    this.socket.send(
      JSON.stringify({
        op: 2,
        d: {
          token: `Bot ${this.token}`,
          intents: this.intents,
          properties: {}, // can be clear object
        },
      })
    );
  }

  send(data) {
    if (!this.socket || this.socket.readyState !== WebSocket.OPEN)
      throw new Error("WebSocket is not open");

    this.socket.send(data);
  }
}

exports("WebSocketClient", (token, guildId, intents) => {
  const client = new WebSocketClient(token, guildId, intents);

  return {
    connect: (cb) => {
      client.connect();
      if (cb) cb(true);
    },
    send: (data) => client.send(data),
    getSocket: () => client.socket,
  };
});
