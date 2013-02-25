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
        socket.emit 'grant:user:access', { nickname: nickname, id: socket.id }
        io.sockets.emit 'user:joined', { connections: connections, nickname: nickname }
    
    socket.on 'public:message', (message) ->
      socket.get 'nickname', (err, name) ->  
        io.sockets.emit 'public:message', { message: message, nickname: name }
        
    socket.on 'start:video', (id) ->
      receiver = io.sockets.sockets[id]
      receiver.emit 'start:video', socket.id
      socket.emit 'start:video', receiver.id
    
    socket.on 'broadcast:video', (data) ->
      io.sockets.sockets[data.user_id].emit 'broadcast:video', data
        
    socket.on 'disconnect', ->
      for connection, i in connections
        if connection?.id == socket?.id
          nickname = connection.nickname
          connections.splice(i, 1)
          io.sockets.emit 'user:left', { connections: connections, nickname: nickname }