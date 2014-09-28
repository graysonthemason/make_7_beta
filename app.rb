require 'sinatra/base'


class App < Sinatra::Base

  ########################
  # Configuration
  ########################

  configure do
    enable :logging
    enable :method_override
    enable :sessions
    $player1 = [[],[],[],[],[],[],[],[],[],[],[]]
    $player2 = [[],[],[],[],[],[],[],[],[],[],[]]
    $winner  = nil
    $turn    = true
    $player1tiles = [12, 8, 3]
    $player2tiles = [12, 8, 3]
    $player1_name = nil
    $player2_name = nil
    $player_1_wins = 0
    $player_2_wins = 0
    $column1 = true
    $column2 = true
    $column3 = true
    $column4 = true
    $column4 = true
    $column5 = true
    $column6 = true
    $column7 = true
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

  def diagonal(array)
    count_start = -4
    count = -4
    count2 = 0
    total = 0
      while count <= 4
        while count2 <= 6
          if count >= 0 && array[count][count2]
            total  += array[count][count2]
          else 
            total   = 0
          end
          $winner   = array if total == 7
          count    += 1
          count2   += 1
        end
        count_start += 1
        count  = count_start
        count2 = 0
      end
  end

    def diagonal_down(array)
    count_start = - 4
    count  = -4
    count2 = 6
    total  = 0
      while count_start <= 4
        while count2 >= 0
          if count >= 0 && array[count][count2]
            total  += array[count][count2]
          else 
            total   = 0
          end
          $winner = array if total == 7
          count  += 1
          count2 -= 1
        end
        count_start += 1
        count  = count_start
        count2 = 6
      end
  end

  def column(array)
    array.each do |column|
      total = 0
      column.each do |num|
        if num && num > 0
          total += num 
        else
          total  = 0
        end
        $winner  = array if total == 7
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
          total  = 0
        end
        $winner  = array if total == 7
      end
      count += 1
    end
  end

  def reset_values
    $player1 = [[],[],[],[],[],[],[],[],[],[],[]]
    $player2 = [[],[],[],[],[],[],[],[],[],[],[]]
    $winner  = nil
    $turn    = true
    $player1tiles = [12, 8, 3]
    $player2tiles = [12, 8, 3]
    $column1 = true
    $column2 = true
    $column3 = true
    $column4 = true
    $column4 = true
    $column5 = true
    $column6 = true
    $column7 = true
  end

  def update_tile_count(number)
    if $turn
      case number.to_i
      when 1
        $player1tiles[0] -= 1 
      when 2
        $player1tiles[1] -= 1 
      when 3
        $player1tiles[2] -= 1
      end
    else
      case number.to_i
      when 1
        $player2tiles[0] -= 1 
      when 2
        $player2tiles[1] -= 1 
      when 3
        $player2tiles[2] -= 1
      end     
    end
  end


  get('/') do
    reset_values
    $player1_name = nil
    $player2_name = nil
    $player_1_wins = 0
    $player_2_wins = 0
    render(:erb, :login)
  end

get('/rules') do
  render(:erb, :rules)
end

  get('/game') do
    redirect to('/') if $player1_name == nil || $player2_name == nil
    $player1tiles
    diagonal($player1)
    diagonal($player2)
    diagonal_down($player1)
    diagonal_down($player2)
    column($player1)
    column($player2)
    row($player1)
    row($player2)
    if $winner && $turn
      $winner = $player2_name
      $player_2_wins += 1
    elsif $winner
      $winner = $player1_name
      $player_1_wins += 1
    end
    render(:erb, :game)
  end

  get('/new_game') do
    reset_values
      redirect to('/game')
  end

  post('/column1') do
    update_tile_count(params[:number])
    if $turn
      $player1[0].push(params["number"].to_i)
      $player2[0].push(0)
      $turn = false
    else
      $player2[0].push(params["number"].to_i)
      $player1[0].push(0)
      $turn = true
    end
    $column1 = false if $player1[0].count == 7
      redirect to('/game')
  end

    post('/column2') do
      update_tile_count(params[:number])
      if $turn
        $player1[1].push(params["number"].to_i)
        $player2[1].push(0)
        $turn = false
      else 
        $player2[1].push(params["number"].to_i)
        $player1[1].push(0)
        $turn = true
      end
    $column2 = false if $player1[1].count == 7

      redirect to('/game')
    end
    post('/column3') do
      update_tile_count(params[:number])
      if $turn
        $player1[2].push(params["number"].to_i)
        $player2[2].push(0)
        $turn = false
      else 
        $player2[2].push(params["number"].to_i)
        $player1[2].push(0)
        $turn = true
      end
    $column3 = false if $player1[2].count == 7

      redirect to('/game')
    end
    post('/column4') do
      update_tile_count(params[:number])
      if $turn
        $player1[3].push(params["number"].to_i)
        $player2[3].push(0)
        $turn = false
      else 
        $player2[3].push(params["number"].to_i)
        $player1[3].push(0)
        $turn = true
      end
    $column4 = false if $player1[3].count == 7

      redirect to('/game')
    end
    post('/column5') do
      update_tile_count(params[:number])
      if $turn
        $player1[4].push(params["number"].to_i)
        $player2[4].push(0)
        $turn = false
      else 
        $player2[4].push(params["number"].to_i)
        $player1[4].push(0)
        $turn = true
      end
    $column5 = false if $player1[4].count == 7

      redirect to('/game')
    end
    post('/column6') do
      update_tile_count(params[:number])
      if $turn
        $player1[5].push(params["number"].to_i)
         $player2[5].push(0)
        $turn = false
      else 
        $player2[5].push(params["number"].to_i)
        $player1[5].push(0)
        $turn = true
      end
    $column6 = false if $player1[5].count == 7

      redirect to('/game')
    end
    post('/column7') do
      update_tile_count(params[:number])
      if $turn
        $player1[6].push(params["number"].to_i)
         $player2[6].push(0)
        $turn = false
      else 
        $player2[6].push(params["number"].to_i)
        $player1[6].push(0)
        $turn = true
      end
    $column7= false if $player1[6].count == 7
    redirect to('/game')
    end
    post('/new_game') do
      $player1_name = params["player1"]
      $player2_name = params["player2"]
      redirect to('/game')
    end
end

