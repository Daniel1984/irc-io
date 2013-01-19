module.exports = (io) ->
  
  io.configure () ->
    io.set("transports", ["xhr-polling"])
    io.set("polling duration", 10)
  
  io.sockets.on 'connection', (socket) ->
    socket.on 'join:chat', (nickname) ->
      timestamp = new Date().valueOf()
      nickname = "guest-#{timestamp}" unless nickname
      socket.set 'nickname', nickname, () ->
        socket.emit 'let:user:in', {nickname: nickname}
        io.sockets.emit 'new:user:joined', {nickname: nickname}

    socket.on 'public:message:from:user', (message) ->
      socket.get 'nickname', (err, name) ->  
        io.sockets.emit 'public:message:from:server', {message: message, nickname: name}