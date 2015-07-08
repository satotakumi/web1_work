(function() {
  var player_interval, progressStart, titleReset, titleSet, updateHTML;

  player_interval = null;

  $('#player-play').click(function() {
    $('#youtube-player-container').tubeplayer('play');
  });

  $('#player-pause').click(function() {
    $('#youtube-player-container').tubeplayer('pause');
  });

  updateHTML = function(s) {
    $('#status').html(s);
  };

  titleReset = function() {
    $('title').text($('title').text().replace('▶ ' + $('#youtube-player-container').tubeplayer('player').getVideoData()['title'], ''));
  };

  titleSet = function() {
    console.log("TITLE!!!!!!!!!!!SET!");
    $('title').text('▶ ' + $('#youtube-player-container').tubeplayer('player').getVideoData()['title'] + $('title').text());
  };

  $('#youtube-player-container').tubeplayer({
    width: 1,
    height: 1,
    allowFullScreen: 'true',
    initialVideo: 'K-QQekBc0wY',
    playerID: 'youtube-player',
    preferredQuality: 'small',
    onPlay: function(id) {
      player_interval = setInterval(progressStart, 300);
    },
    onPause: function() {
      clearInterval(player_interval);
      titleReset();
      $('#player-pause').hide();
      $('#player-play').show();
    },
    onStop: function() {
      updateHTML('動画の再生を停止しました');
    },
    onSeek: function(time) {
      updateHTML('シーク位置が変更されました');
      titleReset();
      player_interval = setInterval(progressStart, 300);
    },
    onMute: function() {
      updateHTML('ミュートを設定しました');
    },
    onUnMute: function() {
      updateHTML('ミュートが解除されました');
    },
    onPlayerUnstarted: function() {
      updateHTML('未再生');
    },
    onPlayerEnded: function() {
      updateHTML('再生終了');
      titleReset();
    },
    onPlayerPlaying: function() {
      updateHTML('再生中');
      titleSet();
      $('#player-pause').show();
      $('#player-play').hide();
    },
    onPlayerPaused: function() {
      updateHTML('一時停止中');
    },
    onPlayerBuffering: function() {
      updateHTML('バッファリング中');
    },
    onPlayerCued: function() {
      updateHTML('キュー');
    },
    onQualityChange: function(quality) {
      updateHTML('画質が変更されました');
    },
    onErrorNotFound: function() {
      updateHTML('動画が見つかりません');
    },
    onErrorNotEmbeddable: function() {
      updateHTML('埋め込みできません');
    }
  });

  progressStart = function() {
    var current_par, data;
    data = $('#youtube-player-container').tubeplayer('data');
    current_par = data['currentTime'] / data['duration'];
    $('#player-progress-hover').val(current_par * 100);
    $('.mdl-slider__background-lower').css('flex', current_par + ' 1 0%');
    $('.mdl-slider__background-upper').css('flex', 1 - current_par + ' 1 0%');
    $('#player-progress').children('.bar1').css('width', current_par * 100 + '%');
  };

  $('#player-progress-wrapp').hover((function() {
    console.log('hover');
    $('#player-progress-container').hide();
    $('#player-progress-hover-container').show();
  }), function() {
    console.log('Out?');
    $('#player-progress-container').show();
    $('#player-progress-hover-container').hide();
  });

  $(window).keydown(function(e) {
    var data;
    if (e.keyCode === 32) {
      data = $('#youtube-player-container').tubeplayer('data');
      if (data['state'] === 1) {
        $('#youtube-player-container').tubeplayer('pause');
      } else {
        $('#youtube-player-container').tubeplayer('play');
      }
    }
    return false;
  });

  $('#player-progress-hover-container').mousedown(function() {
    clearInterval(player_interval);
  });

  $('#player-progress-hover-container').mouseup(function() {
    var data;
    data = $('#youtube-player-container').tubeplayer('data');
    $("#youtube-player-container").tubeplayer("seek", ($('#player-progress-hover').val() / 100) * data['duration']);
  });

  $('#player-progress-hover-container').hide();

}).call(this);
