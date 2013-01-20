module.exports = (io) ->
  
  connections = []
  
  io.configure ->
    io.set('transports', ['xhr-polling'])
    io.set('polling duration', 10)
    io.disable('log')
  
  io.sockets.on 'connection', (socket) ->
    socket.on 'join:chat', (nickname) ->
      timestamp = new Date().valueOf().toString().substring(8)
      nickname = "guest-#{timestamp}" unless nickname
      connections.push id: socket.id, nickname: nickname
      socket.set 'nickname', nickname, ->
        socket.emit 'grant:user:access', {nickname: nickname}
        io.sockets.emit 'new:user:joined', {nickname: nickname}
        io.sockets.emit 'user:list:update', connections

    socket.on 'public:message:from:user', (message) ->
      socket.get 'nickname', (err, name) ->  
        io.sockets.emit 'public:message:from:server', {message: message, nickname: name}
        
    socket.on 'disconnect', ->
      for connection, i in connections
        if connection?.id == socket?.id
          io.sockets.emit 'user:left:chat', {nickname: connection.nickname}
          connections.splice(i, 1)
          io.sockets.emit 'user:list:update', connections