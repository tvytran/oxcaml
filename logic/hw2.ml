(* Roll dice function *)
let roll_dice () = 
  let die1 = Random.int 6 + 1 in
  let die2 = Random.int 6 + 1 in
  (die1, die2)

(* Move player around the board *)
let move_player player dice_total =
  let new_position = (player.position + dice_total) mod 40 in
  let passed_go = player.position + dice_total >= 40 in
  let new_money = if passed_go then player.money + 200 else player.money in
  { player with position = new_position; money = new_money }

(* Handle landing on a space *)
let handle_space_landing player board =
  let space = board.(player.position) in
  match space with
  | SpecialSpace "Go" -> 
      { player with money = player.money + 200 }
  | SpecialSpace "Jail" -> 
      player (* Just visiting *)
  | SpecialSpace "Go to Jail" -> 
      { player with position = 10; money = player.money } (* Send to jail *)
  | SpecialSpace "Free Parking" -> 
      player (* Nothing happens *)
  | PropertySpace prop -> 
      (match prop.owner with
       | None -> 
           Printf.printf "%s can buy %s for $%d\n" player.name prop.name prop.price;
           player (* TODO: Add buying logic *)
       | Some owner when owner = player.name -> 
           Printf.printf "%s owns %s\n" player.name prop.name;
           player
       | Some owner -> 
           Printf.printf "%s pays rent of $%d to %s for %s\n" 
             player.name prop.rent owner prop.name;
           { player with money = player.money - prop.rent })
  | RailroadSpace railroad ->
      (match railroad.owner with
       | None -> 
           Printf.printf "%s can buy %s for $%d\n" player.name railroad.name railroad.price;
           player
       | Some owner when owner = player.name -> 
           player
       | Some owner -> 
           Printf.printf "%s pays railroad rent of $%d to %s\n" 
             player.name railroad.rent owner;
           { player with money = player.money - railroad.rent })
  | UtilitySpace utility ->
      (match utility.owner with
       | None -> 
           Printf.printf "%s can buy %s for $%d\n" player.name utility.name utility.price;
           player
       | Some owner when owner = player.name -> 
           player
       | Some owner -> 
           let rent = 4 * (fst (roll_dice ()) + snd (roll_dice ())) in (* Simplified utility rent *)
           Printf.printf "%s pays utility rent of $%d to %s\n" 
             player.name rent owner;
           { player with money = player.money - rent })
  | ActionSpace action ->
      (match action.action_type with
       | Tax -> 
           let tax_amount = if action.name = "Income Tax" then 200 else 75 in
           Printf.printf "%s pays %s of $%d\n" player.name action.name tax_amount;
           { player with money = player.money - tax_amount }
       | Chance -> 
           Printf.printf "%s draws a Chance card\n" player.name;
           player (* TODO: Implement card drawing *)
       | CommunityChest -> 
           Printf.printf "%s draws a Community Chest card\n" player.name;
           player (* TODO: Implement card drawing *))

(* Main make_move function *)
let make_move player board =
  Printf.printf "\n%s's turn (Position %d, Money $%d)\n" 
    player.name player.position player.money;
  
  let (die1, die2) = roll_dice () in
  let dice_total = die1 + die2 in
  let doubles = die1 = die2 in
  
  Printf.printf "%s rolled %d and %d (total %d)%s\n" 
    player.name die1 die2 dice_total 
    (if doubles then " - DOUBLES!" else "");
  
  let moved_player = move_player player dice_total in
  Printf.printf "%s moved to position %d\n" moved_player.name moved_player.position;
  
  let final_player = handle_space_landing moved_player board in
  
  (final_player, doubles)

(* Example usage *)
let test_make_move () =
  Random.self_init ();
  let board = setup_board () in
  let player1 = {
    name = "Alice";
    money = 1500;
    properties = [];
    railroads = [];
    utilities = [];
    get_out_jail = 0;
    position = 0;
  } in
  
  let (new_player, rolled_doubles) = make_move player1 board in
  Printf.printf "Final: %s at position %d with $%d\n" 
    new_player.name new_player.position new_player.money;