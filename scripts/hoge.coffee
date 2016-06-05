module.exports = (robot) ->

  robot.respond /つー/i, (msg) ->
    msg.send "かー"

  # 正規表現でマッチングした部分の取得もできる
  robot.respond /I am (.*)/i, (msg) ->
    msg.send "Hi, #{msg.match[1]}"

  # msg.randomで配列の文字列の中からランダムに選択して発言する
  robot.respond /おみくじ/i, (msg) ->
    msg.send msg.random ["大吉", "中吉", "小吉", "凶"]

  # 呼びかけなくても単語に反応して発言する
  robot.hear /疲れた/i, (msg) ->
    msg.send "がんばって！"

  # Web APIを使って応答する
  robot.hear /location (.*)/, (msg) ->
    request = robot.http("https://maps.googleapis.com/maps/api/geocode/json")
                   .query(address: msg.match[1])
                   .get()
    request (err, res, body) ->
      json = JSON.parse body
      location = json['results'][0]['geometry']['location']
      msg.send "#{location['lat']}, #{location['lng']}"

