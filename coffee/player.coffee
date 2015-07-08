player_interval = null;

$('#player-play').click ->
  $('#youtube-player-container').tubeplayer 'play'
  return

$('#player-pause').click ->
  $('#youtube-player-container').tubeplayer 'pause'
  return

updateHTML = (s) ->
  $('#status').html s
  return

titleReset = ->
  $('title').text($('title').text().replace('▶ '+ $('#youtube-player-container').tubeplayer('player').getVideoData()['title'] ,''));
  return

titleSet = ->
  console.log("TITLE!!!!!!!!!!!SET!")
  $('title').text('▶ ' + $('#youtube-player-container').tubeplayer('player').getVideoData()['title'] + $('title').text());
  return

$('#youtube-player-container').tubeplayer
  width: 1
  height: 1
  allowFullScreen: 'true'
  initialVideo: 'K-QQekBc0wY'
  playerID: 'youtube-player'
  preferredQuality: 'small'
  onPlay: (id) ->
    player_interval = setInterval(progressStart,300);
    return
  onPause: ->
    clearInterval(player_interval)
    titleReset()
    $('#player-pause').hide()
    $('#player-play').show()
    return
  onStop: ->
    updateHTML '動画の再生を停止しました'
    return
  onSeek: (time) ->
    updateHTML 'シーク位置が変更されました'
    titleReset()
    player_interval = setInterval(progressStart,300)
    return
  onMute: ->
    updateHTML 'ミュートを設定しました'
    return
  onUnMute: ->
    updateHTML 'ミュートが解除されました'
    return
  onPlayerUnstarted: ->
    updateHTML '未再生'
    return
  onPlayerEnded: ->
    updateHTML '再生終了'
    titleReset()
    return
  onPlayerPlaying: ->
    updateHTML '再生中'
    titleSet()
    $('#player-pause').show()
    $('#player-play').hide()
    return
  onPlayerPaused: ->
    updateHTML '一時停止中'
    return
  onPlayerBuffering: ->
    updateHTML 'バッファリング中'
    return
  onPlayerCued: ->
    updateHTML 'キュー'
    return
  onQualityChange: (quality) ->
    updateHTML '画質が変更されました'
    return
  onErrorNotFound: ->
    updateHTML '動画が見つかりません'
    return
  onErrorNotEmbeddable: ->
    updateHTML '埋め込みできません'
    return

progressStart = () ->
  data = $('#youtube-player-container').tubeplayer 'data'
  current_par = data['currentTime'] / data['duration']
  $('#player-progress-hover').val(current_par * 100 )
  $('.mdl-slider__background-lower').css('flex',current_par + ' 1 0%')
  $('.mdl-slider__background-upper').css('flex',1 - current_par + ' 1 0%')
  $('#player-progress').children('.bar1').css('width',current_par * 100 + '%')


  return

$('#player-progress-wrapp').hover (->
  console.log('hover')
  $('#player-progress-container').hide()
  $('#player-progress-hover-container').show()
  return
), ->
  #$('#player-progress-container').css('display','table-cell')
  console.log('Out?')
  $('#player-progress-container').show()
  $('#player-progress-hover-container').hide()
  return


# KeyBord Events
$(window).keydown (e) ->
  if e.keyCode == 32
    data = $('#youtube-player-container').tubeplayer 'data'
    if data['state'] == 1
      $('#youtube-player-container').tubeplayer 'pause'
    else
      $('#youtube-player-container').tubeplayer 'play'
  false

# Mouse Events
$('#player-progress-hover-container').mousedown ->
  clearInterval(player_interval)
  return
$('#player-progress-hover-container').mouseup ->
  data = $('#youtube-player-container').tubeplayer 'data'
  $("#youtube-player-container").tubeplayer("seek",($('#player-progress-hover').val()/100) * data['duration']);

  return

#IE対策
$('#player-progress-hover-container').hide()
