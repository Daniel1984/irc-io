appPath = "#{process.cwd()}/app"

module.exports.index = (req, res, next) ->
  res.render 'index',
    title: "CHAT.IO"