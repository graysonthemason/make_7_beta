require 'sinatra/base'
require 'pry'

class App < Sinatra::Base

  ########################
  # Configuration
  ########################

  configure do
    enable :logging
    enable :method_override
    enable :sessions
    $player1 = [[],[],[],[],[],[],[]]
    $player2 = [[],[],[],[],[],[],[]]
    $winner = nil
    $turn = true

  end

  before do
    logger.info "Request Headers: #{headers}"
    logger.warn "Params: #{params}"
  end

  after do
    logger.info "Response Headers: #{response.headers}"
  end
  ########################
  # Routes
  ########################

  get('/') do
    render(:erb, :index, :layout => :layout)
  end

  get('/game') do
    $player1.each |column|
      

    render(:erb, :game)
  end
  post('/column1') do
    if $turn
      $player1[0].push(params["number"].to_i)
      $player2[0].push(0)
      $turn = false
    else 
      $player1[0].push(0)
      $player2[0].push(params["number"].to_i)
      $turn = true
    end
      redirect to('/game')
  end
    post('/column2') do
      if $turn
        $player1[1].push(params["number"].to_i)
        $player2[1].push(0)
        $turn = false
      else 
        $player1[1].push(0)
        $player2[1].push(params["number"].to_i)
        $turn = true
      end
      redirect to('/game')
    end
    post('/column3') do
      if $turn
        $player1[2].push(params["number"].to_i)
        $player2[2].push(0)
        $turn = false
      else 
        $player1[2].push(0)
        $player2[2].push(params["number"].to_i)
        $turn = true
      end
      redirect to('/game')
    end
    post('/column4') do
      if $turn
        $player1[3].push(params["number"].to_i)
        $player2[3].push(0)
        $turn = false
      else 
        $player1[3].push(0)
        $player2[3].push(params["number"].to_i)
        $turn = true
      end
      redirect to('/game')
    end
    post('/column5') do
      if $turn
        $player1[4].push(params["number"].to_i)
        $player2[4].push(0)
        $turn = false
      else 
        $player1[4].push(0)
        $player2[4].push(params["number"].to_i)
        $turn = true
      end
      redirect to('/game')
    end
    post('/column6') do
      if $turn
        $player1[5].push(params["number"].to_i)
        $player2[5].push(0)
        $turn = false
      else 
        $player1[5].push(0)
        $player2[5].push(params["number"].to_i)
        $turn = true
      end
      redirect to('/game')
    end
    post('/column7') do
      if $turn
        $player1[6].push(params["number"].to_i)
        $player2[6].push(0)
        $turn = false
      else 
        $player1[6].push(0)
        $player2[6].push(params["number"].to_i)
        $turn = true
      end
      redirect to('/game')
    end
end

