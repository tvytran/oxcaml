type player_kind = Player1 | Player2 | Player3 | Player4

type property = {
  name: string;
  owner: string option;
  houses: int;
  price: int;
  rent: int;
  mortgaged_cost: int;
  unmortgaged_cost: int;
  mortgaged: bool;
  house_cost: int;
}

type asset_type = Property | Railroad | Utility
type asset = {
  name: string;
  owner: string option;
  price: int;
  rent: int;
  mortgaged_cost: int;
  unmortgaged_cost: int;
  mortgaged: bool;
  asset_type: asset_type;
  houses: int;
  house_cost: int;
}

type action_type = Tax | Chance | CommunityChest  

type action= {
  name: string;
  description: string;
  action_type: action_type;
}

type chance = {
  name: string;
  description: string;
}

type tax = {
  name: string;
  amount: int;
}

type community_chest = {
  name: string;
  description: string;
}

type player = {
  name: string;
  money: int;
  assets: asset list;
  get_out_jail: int;
  position: int;
}

type space =
  | SpecialSpace of string
  | PropertySpace of {
      name: string;
      owner: string option;
      houses: int;
      price: int;
      rent: int;
      mortgaged_cost: int;
      unmortgaged_cost: int;
      mortgaged: bool;
      house_cost: int;
    }
  | RailroadSpace of {
      name: string;
      owner: string option;
      price: int;
      rent: int;
      mortgaged_cost: int;
      unmortgaged_cost: int;
      mortgaged: bool;
    }
  | UtilitySpace of {
      name: string;
      owner: string option;
      price: int;
      rent: int;
      mortgaged_cost: int;
      unmortgaged_cost: int;
      mortgaged: bool;
    }
  | ActionSpace of {
      name: string;
      description: string;
      action_type: action_type;
    }

let create_board () : space array =
  Array.make 40 (SpecialSpace "Uninitialized")

let setup_board () =
  let board = create_board () in
  
  (* Position 0: Go *)
  board.(0) <- SpecialSpace "Go";
  
  (* Position 1: Mediterranean Avenue *)
  board.(1) <- PropertySpace {
    name = "Mediterranean Avenue";
    owner = None;
    houses = 0;
    price = 60;
    rent = 2;
    mortgaged_cost = 30;
    unmortgaged_cost = 30;
    mortgaged = false;
    house_cost = 50;
  };
  
  (* Position 2: Community Chest *)
  board.(2) <- ActionSpace {
    name = "Community Chest";
    description = "Draw a Community Chest card";
    action_type = CommunityChest;
  };
  
  (* Position 3: Baltic Avenue *)
  board.(3) <- PropertySpace {
    name = "Baltic Avenue";
    owner = None;
    houses = 0;
    price = 60;
    rent = 4;
    mortgaged_cost = 30;
    unmortgaged_cost = 30;
    mortgaged = false;
    house_cost = 50;
  };
  
  (* Position 4: Income Tax *)
  board.(4) <- ActionSpace {
    name = "Income Tax";
    description = "Pay $200";
    action_type = Tax;
  };
  
  (* Position 5: Reading Railroad *)
  board.(5) <- RailroadSpace {
    name = "Reading Railroad";
    owner = None;
    price = 200;
    rent = 25;
    mortgaged_cost = 100;
    unmortgaged_cost = 100;
    mortgaged = false;
  };
  
  (* Position 6: Oriental Avenue *)
  board.(6) <- PropertySpace {
    name = "Oriental Avenue";
    owner = None;
    houses = 0;
    price = 100;
    rent = 6;
    mortgaged_cost = 50;
    unmortgaged_cost = 50;
    mortgaged = false;
    house_cost = 50;
  };
  
  (* Position 7: Chance *)
  board.(7) <- ActionSpace {
    name = "Chance";
    description = "Draw a Chance card";
    action_type = Chance;
  };
  
  (* Position 8: Vermont Avenue *)
  board.(8) <- PropertySpace {
    name = "Vermont Avenue";
    owner = None;
    houses = 0;
    price = 100;
    rent = 6;
    mortgaged_cost = 50;
    unmortgaged_cost = 50;
    mortgaged = false;
    house_cost = 50;
  };
  
  (* Position 9: Connecticut Avenue *)
  board.(9) <- PropertySpace {
    name = "Connecticut Avenue";
    owner = None;
    houses = 0;
    price = 120;
    rent = 8;
    mortgaged_cost = 60;
    unmortgaged_cost = 60;
    mortgaged = false;
    house_cost = 50;
  };
  
  (* Position 10: Jail *)
  board.(10) <- SpecialSpace "Jail";
  
  (* Position 11: St. Charles Place *)
  board.(11) <- PropertySpace {
    name = "St. Charles Place";
    owner = None;
    houses = 0;
    price = 140;
    rent = 10;
    mortgaged_cost = 70;
    unmortgaged_cost = 70;
    mortgaged = false;
    house_cost = 100;
  };
  
  (* Position 12: Electric Company *)
  board.(12) <- UtilitySpace {
    name = "Electric Company";
    owner = None;
    price = 150;
    rent = 0;
    mortgaged_cost = 75;
    unmortgaged_cost = 75;
    mortgaged = false;
  };
  
  (* Position 13: States Avenue *)
  board.(13) <- PropertySpace {
    name = "States Avenue";
    owner = None;
    houses = 0;
    price = 140;
    rent = 10;
    mortgaged_cost = 70;
    unmortgaged_cost = 70;
    mortgaged = false;
    house_cost = 100;
  };
  
  (* Position 14: Virginia Avenue *)
  board.(14) <- PropertySpace {
    name = "Virginia Avenue";
    owner = None;
    houses = 0;
    price = 160;
    rent = 12;
    mortgaged_cost = 80;
    unmortgaged_cost = 80;
    mortgaged = false;
    house_cost = 100;
  };
  
  (* Position 15: Pennsylvania Railroad *)
  board.(15) <- RailroadSpace {
    name = "Pennsylvania Railroad";
    owner = None;
    price = 200;
    rent = 25;
    mortgaged_cost = 100;
    unmortgaged_cost = 100;
    mortgaged = false;
  };
  
  (* Position 16: St. James Place *)
  board.(16) <- PropertySpace {
    name = "St. James Place";
    owner = None;
    houses = 0;
    price = 180;
    rent = 14;
    mortgaged_cost = 90;
    unmortgaged_cost = 90;
    mortgaged = false;
    house_cost = 100;
  };
  
  (* Position 17: Community Chest *)
  board.(17) <- ActionSpace {
    name = "Community Chest";
    description = "Draw a Community Chest card";
    action_type = CommunityChest;
  };
  
  (* Position 18: Tennessee Avenue *)
  board.(18) <- PropertySpace {
    name = "Tennessee Avenue";
    owner = None;
    houses = 0;
    price = 180;
    rent = 14;
    mortgaged_cost = 90;
    unmortgaged_cost = 90;
    mortgaged = false;
    house_cost = 100;
  };
  
  (* Position 19: New York Avenue *)
  board.(19) <- PropertySpace {
    name = "New York Avenue";
    owner = None;
    houses = 0;
    price = 200;
    rent = 16;
    mortgaged_cost = 100;
    unmortgaged_cost = 100;
    mortgaged = false;
    house_cost = 100;
  };
  
  (* Position 20: Free Parking *)
  board.(20) <- SpecialSpace "Free Parking";
  
  (* Position 21: Kentucky Avenue *)
  board.(21) <- PropertySpace {
    name = "Kentucky Avenue";
    owner = None;
    houses = 0;
    price = 220;
    rent = 18;
    mortgaged_cost = 110;
    unmortgaged_cost = 110;
    mortgaged = false;
    house_cost = 150;
  };
  
  (* Position 22: Chance *)
  board.(22) <- ActionSpace {
    name = "Chance";
    description = "Draw a Chance card";
    action_type = Chance;
  };
  
  (* Position 23: Indiana Avenue *)
  board.(23) <- PropertySpace {
    name = "Indiana Avenue";
    owner = None;
    houses = 0;
    price = 220;
    rent = 18;
    mortgaged_cost = 110;
    unmortgaged_cost = 110;
    mortgaged = false;
    house_cost = 150;
  };
  
  (* Position 24: Illinois Avenue *)
  board.(24) <- PropertySpace {
    name = "Illinois Avenue";
    owner = None;
    houses = 0;
    price = 240;
    rent = 20;
    mortgaged_cost = 120;
    unmortgaged_cost = 120;
    mortgaged = false;
    house_cost = 150;
  };
  
  (* Position 25: B&O Railroad *)
  board.(25) <- RailroadSpace {
    name = "B&O Railroad";
    owner = None;
    price = 200;
    rent = 25;
    mortgaged_cost = 100;
    unmortgaged_cost = 100;
    mortgaged = false;
  };
  
  (* Position 26: Atlantic Avenue *)
  board.(26) <- PropertySpace {
    name = "Atlantic Avenue";
    owner = None;
    houses = 0;
    price = 260;
    rent = 22;
    mortgaged_cost = 130;
    unmortgaged_cost = 130;
    mortgaged = false;
    house_cost = 150;
  };
  
  (* Position 27: Ventnor Avenue *)
  board.(27) <- PropertySpace {
    name = "Ventnor Avenue";
    owner = None;
    houses = 0;
    price = 260;
    rent = 22;
    mortgaged_cost = 130;
    unmortgaged_cost = 130;
    mortgaged = false;
    house_cost = 150;
  };
  
  (* Position 28: Water Works *)
  board.(28) <- UtilitySpace {
    name = "Water Works";
    owner = None;
    price = 150;
    rent = 0;
    mortgaged_cost = 75;
    unmortgaged_cost = 75;
    mortgaged = false;
  };
  
  (* Position 29: Marvin Gardens *)
  board.(29) <- PropertySpace {
    name = "Marvin Gardens";
    owner = None;
    houses = 0;
    price = 280;
    rent = 24;
    mortgaged_cost = 140;
    unmortgaged_cost = 140;
    mortgaged = false;
    house_cost = 150;
  };
  
  (* Position 30: Go to Jail *)
  board.(30) <- SpecialSpace "Go to Jail";
  
  (* Position 31: Pacific Avenue *)
  board.(31) <- PropertySpace {
    name = "Pacific Avenue";
    owner = None;
    houses = 0;
    price = 300;
    rent = 26;
    mortgaged_cost = 150;
    unmortgaged_cost = 150;
    mortgaged = false;
    house_cost = 200;
  };
  
  (* Position 32: North Carolina Avenue *)
  board.(32) <- PropertySpace {
    name = "North Carolina Avenue";
    owner = None;
    houses = 0;
    price = 300;
    rent = 26;
    mortgaged_cost = 150;
    unmortgaged_cost = 150;
    mortgaged = false;
    house_cost = 200;
  };
  
  (* Position 33: Community Chest *)
  board.(33) <- ActionSpace {
    name = "Community Chest";
    description = "Draw a Community Chest card";
    action_type = CommunityChest;
  };
  
  (* Position 34: Pennsylvania Avenue *)
  board.(34) <- PropertySpace {
    name = "Pennsylvania Avenue";
    owner = None;
    houses = 0;
    price = 320;
    rent = 28;
    mortgaged_cost = 160;
    unmortgaged_cost = 160;
    mortgaged = false;
    house_cost = 200;
  };
  
  (* Position 35: Short Line *)
  board.(35) <- RailroadSpace {
    name = "Short Line";
    owner = None;
    price = 200;
    rent = 25;
    mortgaged_cost = 100;
    unmortgaged_cost = 100;
    mortgaged = false;
  };
  
  (* Position 36: Chance *)
  board.(36) <- ActionSpace {
    name = "Chance";
    description = "Draw a Chance card";
    action_type = Chance;
  };
  
  (* Position 37: Park Place *)
  board.(37) <- PropertySpace {
    name = "Park Place";
    owner = None;
    houses = 0;
    price = 350;
    rent = 35;
    mortgaged_cost = 175;
    unmortgaged_cost = 175;
    mortgaged = false;
    house_cost = 200;
  };
  
  (* Position 38: Luxury Tax *)
  board.(38) <- ActionSpace {
    name = "Luxury Tax";
    description = "Pay $75";
    action_type = Tax;
  };
  
  (* Position 39: Boardwalk *)
  board.(39) <- PropertySpace {
    name = "Boardwalk";
    owner = None;
    houses = 0;
    price = 400;
    rent = 50;
    mortgaged_cost = 200;
    unmortgaged_cost = 200;
    mortgaged = false;
    house_cost = 200;
  };
  
  board

  
