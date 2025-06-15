--[[
ROCK, PAPER, SCISSORS!

1. Get user input (rock, paper, or scissors)
2. Randomly generate a play
3. Compare the two plays and log the winner
EXTRA: Add a mode for two players instead of one?
]]--

print("Rock, Paper, Scissors!\n")
choices = {"rock", "paper", "scissors"} -- Table containing the possible selections

io.write("What mode do you want to play? (PVP/PVE)\n"); mode = io.read() -- Write to the terminal and read the response
mode = string.lower(mode) -- Update mode to be itself, but all lowercase

-- If the response as a lowercase is neither "pvp" nor "pve"
if mode ~= "pvp" and mode ~= "pve" then
  print("Please input pve for single player or pvp for multiplayer.") -- Print error message
  return -- End the script by returning nil
end

function check_selection(player)
  
  -- If the player doesn't pick rock, paper, or scissors
  if player ~= "rock" and player ~= "paper" and player ~= "scissors" then
    print("Error! Please input rock, paper, or scissors.") -- Print error message
    return -- End the script by returning nil
  end
end

function player_vs_bot() -- Function to fight a bot (single player mode)
  
  io.write("Pick rock, paper, or scissors.\n") -- Write a message to the terminal
  local player = string.lower(io.read()) -- Read the response for input, but make the input all lowercase
  
  check_selection(player) -- Check if the player's input is rock, paper, or scissors and return an error message if not
  
  -- Generate a random number between 1 and 3, and use that as an index for the possible choices to select a random result
  local bot = choices[math.random(3)] -- Don't forget Lua indexing starts at 1!
  
  -- Create a local variable that tracks all the ways you can lose
  local loss = -- If any of these conditions are true, loss = true
  (bot == "rock" and player == "scissors") -- If bot picks rock and you pick scissors
  or (bot == "paper" and player == "rock") -- If bot picks paper and you pick rock
  or (bot == "scissors" and player == "paper") -- If bot picks scissors and you pick paper
  
  -- If both player and bot pick the same thing
  if player == bot then
    print("It's a tie! Bot picked " .. bot .. ".")
    
  -- If loss is true
  elseif loss then
    print("You lose! Bot picked " .. bot .. ".") -- Print a loss message
    
  -- If else (this is automatically a win since we handled any invalid inputs before)
  else
    print("You win! Bot picked " .. bot .. ".") -- Print a win message
  end
  
  return -- End the script by returning nil
end

function player_vs_player()
  io.write("Player 1, pick rock, paper, or scissors.\n")
  local p1 = string.lower(io.read())
  check_selection(p1) -- Check if p1's input was rock, paper, or scissors and return an error message if not
  
  -- Function to check the OS of the user so we can write the appropriate command for clearing the terminal
  function clear()
    
    --[[
    The package library helps us load and build modules in Lua.
    
    The package.config string contains all the characters used by the package manager for handling packages.
    However, the first character contains the directory separator, which is what we use to differentiate different operating systems.
    On Windows, the directory separator is "\", and on all other systems it is "/".
    
    :sub is just a different way of called the sub function from string libary that returns a substring.
    (1, 1) are parameters for the sub() function, meaning it starts at index 1 and gets the first item (tldr it gets the first character in the string)
    
    Overall, package.config:sub(1,1) can be rewritten as string.sub(package.config, 1, 1).
    Get the package.config string, which contains characters used for package handling, and get the first item from it, which is the directory separator.
    ]]--

    -- If the directory separator is "/" (means the OS is not Windows [likely UNIX])
    if package.config:sub(1,1) == "/" then
      return "clear" -- Return the command to clear the terminal on UNIX systems
      
    -- If the directory separator is "\" (means the OS is Windows [])
    elseif package.config:sub(1,1) == "\\" then
      return "cls" -- Return the appropriate command for the operating system (windows uses cls)
    
    -- If else (the directory separator wasn't found)
    else
      print("Error: directory separator not found.") -- Print an error message
      return -- End the script by returning nil
    end
  end
    
  os.execute(clear()) -- Clear the terminal via the os library using the appropriate clear command for the user's OS
    
  io.write("Player 2, pick rock, paper, or scissors\n")
  local p2 = string.lower(io.read())
  check_selection(p2) -- Check if p2's input was rock, paper, or scissors and return an error message if not

  -- Create a local variable that tracks all the ways p2 can lose
  local p2_loss = -- If any of these conditions are true, loss = true
  (p1 == "rock" and p2 == "scissors") -- If bot picks rock and you pick scissors
  or (p1 == "paper" and p2 == "rock") -- If bot picks paper and you pick rock
  or (p1 == "scissors" and p2 == "paper") -- If bot picks scissors and you pick paper

  -- If both player and bot pick the same thing
  if p1 == p2 then
    print("It's a tie! Both players picked " .. p1 .. ".")
 
  -- If p2 loses (if loss is true)
  elseif loss then
    print("P1 wins and P2 loses! P1 picked " .. p1 .. " and P2 picked " .. p2 ".") -- Print a win message for p1/loss message for p2
      
  -- If else (this is automatically a win for p2 since we handled any invalid inputs before)
  else
    print("P2 wins and P1 loses! P2 picked " .. p2 .. " and P1 picked " .. p1 .. ".") -- Print a win message for p2/loss message for p1
  end 
    
  return -- End the script by returning nil
end

-- If the response as a lowercase is "pvp"
if string.lower(mode) == "pvp" then
  player_vs_player() -- Run the pvp function

-- If the response as a lowercase is "pve"
elseif string.lower(mode) == "pve" then
  player_vs_bot() -- Run the pve function
end