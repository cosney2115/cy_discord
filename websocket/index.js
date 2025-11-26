const WebSocket = require("ws");

class WebSocketClient {
  constructor(token, guildId, intents) {
    this.token = token;
    this.guildId = guildId;
    this.intents = intents || 513;
    this.socket = null;
  }

  async connect() {
    this.socket = new WebSocket('wss://gateway.discord.gg/?v=10&encoding=json');
    return new Promise((resolve, reject) => {
      this.socket.on("open", () => {
        resolve();
      });

      this.socket.on("error", (err) => {
        reject(err);
      });

      this.socket.on("close", (code, reason) => {
        console.log(`WebSocket closed - Code: ${code}, Reason: ${reason}`);
      });

      this.socket.on("message", (data) => {
        const payload = JSON.parse(data.toString());

        if (payload.op === 10) {
          this.heartbeatInterval = payload.d.heartbeat_interval;
          this.startHeartbeat();
          this.identify();
        }

        if (payload.op === 0) {
          emit("discord:message", payload);
        }

        if (payload.op === 9)
          console.log("Invalid Session - sprawdź token i intenty!");

        // if (payload.op === 11) console.log("Heartbeat ACK");
      });
    });
  }

  startHeartbeat() {
    setInterval(() => {
      this.socket.send(JSON.stringify({ op: 1, d: null }));
    }, this.heartbeatInterval);
  }

  identify() {
    this.socket.send(
      JSON.stringify({
        op: 2,
        d: {
          token: `Bot ${this.token}`,
          intents: this.intents,
          properties: {
            os: "linux",
            browser: "fivem",
            device: "fivem",
          },
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
      client.connect()
        .then(() => { 
            if (cb) cb(true); 
        })
        .catch((err) => { 
            if (cb) cb(false, err.toString()); 
        });
    },
    send: (data) => client.send(data),
    getSocket: () => client.socket,
  };
});
