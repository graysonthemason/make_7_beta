require 'sinatra/base'
require 'pry'
require 'rubocop'

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
    redirect to('/new_game')
  end

  def diagonal(array)
    count_start = 0
    count = 0
    count2 = 0
    total = 0
    while count_start < 6
      while count2 < 6
        while count < 6
          if array[count][count + count2] && array[count][count + count2] > 0
            total += array[count][count + count2]
          else 
            total = 0
          end
          $winner = array if total == 7
          count += 1
        end
        count = 0
        count2 += 1
      end
      count_start +=1
      count = count_start
      count2 = 0
    end
    count_start +=1
  end

    def diagonal_down(array)
    count_start = 0
    count = 0
    count2 = 0
    total = 0
    while count_start < 6
      while count2 < 6
        while count < 6
          if array[count][count - count2] && array[count][count + count2] > 0
            total += array[count][count + count2]
          else 
            total = 0
          end
          $winner = array if total == 7
          count += 1
        end
        count = 0
        count2 += -1
      end
      count_start +=1
      count = count_start
      count2 = 0
    end
    count_start +=1
  end
        

  def column(array)
    array.each do |column|
      total = 0
      column.each do |num|
        if num && num > 0
          total += num 
        else
          total = 0
        end
        $winner = array if total == 7
      end
    end
  end

  def row(array)
    count = 0
    total = 0
    while count < 7
      array.each do |column|
        if column[count] && column[count] > 0
          total += column[count]
        else
          total = 0
        end
        $winner = array if total == 7
      end
      count += 1
    end
  end

  get('/game') do
    diagonal($player1)
    diagonal($player2)
    column($player1)
    column($player2)
    row($player1)
    row($player2)
    redirect to ('/winner') if $winner
    render(:erb, :game)
  end

  get('/new_game') do
    $player1 = [[],[],[],[],[],[],[]]
    $player2 = [[],[],[],[],[],[],[]]
    $winner = nil
    $turn = true
    render(:erb, :new_game)
  end

  get('/winner') do
    if $winner && $turn
      $winner = "Player 2"
    elsif $winner
      $winner = "Player 1"
    end
    render(:erb, :winner)
  end

  post('/column1') do
    if $turn
      $player1[0].push(params["number"].to_i)
      $player2[0].push(0)
      $turn = false
    else
      $player2[0].push(params["number"].to_i)
      $player1[0].push(0)
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
        $player2[1].push(params["number"].to_i)
        $player1[1].push(0)
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
        $player2[2].push(params["number"].to_i)
        $player1[2].push(0)
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
        $player2[3].push(params["number"].to_i)
        $player1[3].push(0)
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
        $player2[4].push(params["number"].to_i)
        $player1[4].push(0)
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
        $player2[5].push(params["number"].to_i)
        $player1[5].push(0)
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
        $player2[6].push(params["number"].to_i)
        $player1[6].push(0)
        $turn = true
      end
      redirect to('/game')
    end
end

