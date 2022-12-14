include <bit/boardgame_insert_toolkit_lib.2.scad>;

// determines whether lids are output.
g_b_print_lid = f;

// determines whether boxes are output.
g_b_print_box = true; 

// Focus on one box
g_isolated_print_box = ""; 

// Used to visualize how all of the boxes fit together. 
g_b_visualization = f;          
        
// this is the outer wall thickness. 
//Default = 1.5mm
g_wall_thickness = 1.5;

// The tolerance value is extra space put between planes of the lid and box that fit together.
// Increase the tolerance to loosen the fit and decrease it to tighten it.
//
// Note that the tolerance is applied exclusively to the lid.
// So if the lid is too tight or too loose, change this value ( up for looser fit, down for tighter fit ) and 
// you only need to reprint the lid.
// 
// The exception is the stackable box, where the bottom of the box is the lid of the box below,
// in which case the tolerance also affects that box bottom.
//
g_tolerance = 0.15;

// This adjusts the position of the lid detents downward. 
// The larger the value, the bigger the gap between the lid and the box.
g_tolerance_detents_pos = 0.1;

g_lid_solid = t;
g_lid_label = f;

function getLidAttributes(txt, rotation = 0, size = 9, solid=g_lid_solid) = (g_lid_label) ? [
    [ LABEL,
        [
            [ LBL_TEXT,    txt],
            [ LBL_SIZE,    size ],
            [ LBL_FONT,    "Ubuntu:style=bold" ],
            [ ROTATION,    rotation],
        ]
     ],
] : [[ LID_SOLID_B, solid]];

gw = g_wall_thickness;
gw2 = gw * 2;
gw3 = gw * 3;
gw4 = gw * 4;

box_width = 220;
box_height = 309;
city_d = 28+gw;
box_depth = city_d * 2;

hex_r = 39;
hex_w = 34;
pedestal_h = 5;

// Player 


military_w = 28;
board_width = 195;
player_height = (hex_w+gw)*4+gw+(military_w+gw);
player_width = board_width / 3;
round_r = 24;
round_small_h = 2*((player_height-military_w-gw2)/3)-gw2;
round_big_h = player_height - military_w - gw4 - round_small_h;

// Resources
resources_depth = box_width - board_width;
resources_height = 95;
resource_width = 50;

// Cache and Fish
cache_depth = resources_depth;
cache_height = resources_height;
cache_width = 50;

// Money 
money_depth = resources_depth;
money_height = resources_height;
money_width = box_height - (3 * resource_width) - cache_width;

// Cards 
cards_width = (box_height - player_height) / 2;
cards_height = 93;
tech_cards_depth = 45;
other_cards_depth = tech_cards_depth / 3;

// Leader cards and first player
leader_cards_width = cards_width * 2;
leader_cards_height = cards_height;
leader_cards_depth = box_depth - tech_cards_depth;

// Tiles 
tiles_depth = 35;
tiles_width = 45;
tiles_height = 70;
// Good Tokens 
goods_width = board_width - cards_height;
goods_height = box_height - player_height;
goods_depth = box_depth - tiles_depth;

// Tiles 
tile_cards_width = goods_width;
tile_cards_height = goods_height;
tile_cards_depth = tiles_depth;

echo (goods_width,"x",goods_height);
data =
[
    [   "player_bottom_x3",                            
        [
            [ BOX_SIZE_XYZ, [player_height, player_width, city_d] ],
            [ BOX_NO_LID_B, true],
            [ BOX_STACKABLE_B, true],    
            [ BOX_COMPONENT,                             
                [
                    [ CMP_COMPARTMENT_SIZE_XYZ, [ hex_r, hex_r, city_d] ],  
                    [ CMP_SHAPE, HEX ],
                    [CMP_SHAPE_VERTICAL_B, t],
                    [CMP_PEDESTAL_BASE_B, t],
                    [POSITION_XY, [-gw,-gw/2]],
                    [CMP_CUTOUT_SIDES_4B, [t,f,f,f]]
                ]
            ],
            [ BOX_COMPONENT,                             
                [
                    [ CMP_COMPARTMENT_SIZE_XYZ, [ hex_r, hex_r, city_d] ],  
                    [ CMP_SHAPE, HEX ],
                    [CMP_SHAPE_VERTICAL_B, t],
                    [CMP_PEDESTAL_BASE_B, t],
                    [POSITION_XY, [hex_w,-gw/2]],
                    [CMP_CUTOUT_SIDES_4B, [t,f,f,f]]
                ]
            ],
            [ BOX_COMPONENT,                             
                [
                    [ CMP_COMPARTMENT_SIZE_XYZ, [ hex_r, hex_r, city_d] ],  
                    [ CMP_SHAPE, HEX ],
                    [CMP_SHAPE_VERTICAL_B, t],
                    [CMP_PEDESTAL_BASE_B, t],
                    [POSITION_XY, [2*(hex_w)+gw,-gw/2]],
                    [CMP_CUTOUT_SIDES_4B, [t,f,f,f]]
                ]
            ],
            [ BOX_COMPONENT,                             
                [
                    [ CMP_COMPARTMENT_SIZE_XYZ, [ hex_r, hex_r, city_d] ],  
                    [ CMP_SHAPE, HEX ],
                    [CMP_SHAPE_VERTICAL_B, t],
                    [CMP_PEDESTAL_BASE_B, t],
                    [POSITION_XY, [3*(hex_w)+gw2,-gw/2]],
                    [CMP_CUTOUT_SIDES_4B, [t,f,f,f]]
                ]
            ],
            [ BOX_COMPONENT,                             
                [
                    [ CMP_COMPARTMENT_SIZE_XYZ, [ military_w, military_w, city_d] ],  
                    [CMP_PEDESTAL_BASE_B, t],
                    [POSITION_XY, [4*(hex_w)+gw4,gw]],
                    [CMP_CUTOUT_SIDES_4B, [t,f,f,f]]
                ]
            ],
            [ BOX_COMPONENT,                             
                [
                    [ CMP_COMPARTMENT_SIZE_XYZ, [ military_w, military_w, city_d] ],  
                    [CMP_PEDESTAL_BASE_B, t],
                    [POSITION_XY, [4*(hex_w)+gw4,military_w+gw3]],
                    [CMP_CUTOUT_SIDES_4B, [f,t,f,f]]
                ]
            ],
            [ BOX_COMPONENT,                             
                [
                    [ CMP_COMPARTMENT_SIZE_XYZ, [ round_big_h, round_r-gw, city_d] ],  
                    [POSITION_XY, [0,hex_r]],
                ]
            ],
            [ BOX_COMPONENT,                             
                [
                    [ CMP_COMPARTMENT_SIZE_XYZ, [ round_small_h, round_r-gw, city_d] ],  
                    [POSITION_XY, [round_big_h+gw,hex_r]],
                ]
            ]
        ]
    ],
    [   "player_top_x3",                            
        [
            [ BOX_SIZE_XYZ, [player_height, player_width, city_d] ],
            [ BOX_LID,
                getLidAttributes(txt="Player Box"),
            ],
            [ BOX_COMPONENT,                             
                [
                    [ CMP_COMPARTMENT_SIZE_XYZ, [ hex_r, hex_r, city_d] ],  
                    [ CMP_SHAPE, HEX ],
                    [CMP_SHAPE_VERTICAL_B, t],
                    [CMP_PEDESTAL_BASE_B, t],
                    [POSITION_XY, [-gw,-gw/2]],
                    [CMP_CUTOUT_SIDES_4B, [t,f,f,f]]
                ]
            ],
            [ BOX_COMPONENT,                             
                [
                    [ CMP_COMPARTMENT_SIZE_XYZ, [ hex_r, hex_r, city_d] ],  
                    [ CMP_SHAPE, HEX ],
                    [CMP_SHAPE_VERTICAL_B, t],
                    [CMP_PEDESTAL_BASE_B, t],
                    [POSITION_XY, [hex_w,-gw/2]],
                    [CMP_CUTOUT_SIDES_4B, [t,f,f,f]]
                ]
            ],
            [ BOX_COMPONENT,                             
                [
                    [ CMP_COMPARTMENT_SIZE_XYZ, [ hex_r, hex_r, city_d] ],  
                    [ CMP_SHAPE, HEX ],
                    [CMP_SHAPE_VERTICAL_B, t],
                    [CMP_PEDESTAL_BASE_B, t],
                    [POSITION_XY, [2*(hex_w)+gw,-gw/2]],
                    [CMP_CUTOUT_SIDES_4B, [t,f,f,f]]
                ]
            ],
            [ BOX_COMPONENT,                             
                [
                    [ CMP_COMPARTMENT_SIZE_XYZ, [ hex_r, hex_r, city_d] ],  
                    [ CMP_SHAPE, HEX ],
                    [CMP_SHAPE_VERTICAL_B, t],
                    [CMP_PEDESTAL_BASE_B, t],
                    [POSITION_XY, [3*(hex_w)+gw2,-gw/2]],
                    [CMP_CUTOUT_SIDES_4B, [t,f,f,f]]
                ]
            ],
            [ BOX_COMPONENT,                             
                [
                    [ CMP_COMPARTMENT_SIZE_XYZ, [ military_w, military_w, city_d] ],  
                    [CMP_PEDESTAL_BASE_B, t],
                    [POSITION_XY, [4*(hex_w)+gw4,gw]],
                    [CMP_CUTOUT_SIDES_4B, [t,f,f,f]]
                ]
            ],
            [ BOX_COMPONENT,                             
                [
                    [ CMP_COMPARTMENT_SIZE_XYZ, [ military_w, military_w, city_d] ],  
                    [CMP_PEDESTAL_BASE_B, t],
                    [POSITION_XY, [4*(hex_w)+gw4,military_w+gw3]],
                    [CMP_CUTOUT_SIDES_4B, [f,t,f,f]]
                ]
            ],
            [ BOX_COMPONENT,                             
                [
                    [ CMP_COMPARTMENT_SIZE_XYZ, [ round_big_h, round_r-gw, city_d] ],  
                    [POSITION_XY, [0,hex_r]],
                ]
            ],
            [ BOX_COMPONENT,                             
                [
                    [ CMP_COMPARTMENT_SIZE_XYZ, [ round_small_h, round_r-gw, city_d] ],  
                    [POSITION_XY, [round_big_h+gw,hex_r]],
                ]
            ]
        ]
    ],
    [   "resources_x3",
        [
            [ BOX_SIZE_XYZ, [resources_height, resource_width, resources_depth] ],
            [ BOX_LID,
                getLidAttributes(txt="Resources"),
            ],
            [ BOX_COMPONENT,
                [
                    [ CMP_NUM_COMPARTMENTS_XY, [2, 1] ],
                    [ CMP_COMPARTMENT_SIZE_XYZ, [ (resources_height-gw3)/2, resource_width-gw2, resources_depth] ],
                ]
            ]
         ]
     ],
     [   "cache_and_fish_x1",                            
        [
            [ BOX_SIZE_XYZ, [cache_height, cache_width, cache_depth] ],
            [ BOX_LID,
                getLidAttributes(txt="Cache & Fish"),
            ],
            [ BOX_COMPONENT,
                [
                    [ CMP_COMPARTMENT_SIZE_XYZ, [ (cache_height-gw3)/3, cache_width-gw2, cache_depth] ],  
                    [POSITION_XY, [0,0]],
                ]
            ],
            [ BOX_COMPONENT,
                [
                    [ CMP_COMPARTMENT_SIZE_XYZ, [ 2*((cache_height-gw3)/3), cache_width-gw2, cache_depth] ],  
                    [POSITION_XY, [(cache_height-gw3)/3+gw,0]],
                ]
            ]
         ]
     ],
     [   "money_with_compartment_x1",                            
        [
            [ BOX_SIZE_XYZ, [money_height, money_width, money_depth] ],
            [ BOX_LID,
                getLidAttributes(txt="Coins"),
            ],
            [ BOX_COMPONENT,
                [
                    [ CMP_NUM_COMPARTMENTS_XY, [2, 1] ],
                    [ CMP_COMPARTMENT_SIZE_XYZ, [ (money_height-gw3)/2, ((money_width-gw3)*2)/5, money_depth] ],
                    [POSITION_XY, [0,0]]
                ]
            ],
            [ BOX_COMPONENT,
                [
                    [ CMP_NUM_COMPARTMENTS_XY, [2, 1] ],
                    [ CMP_COMPARTMENT_SIZE_XYZ, [ (money_height-gw3)/2, ((money_width-gw3)*3)/5, money_depth] ],
                    [POSITION_XY, [0,((money_width-gw3)*2)/5+gw]]
                ]
            ],
         ]
     ], 
     [   "money_no_compartment_x1",                            
        [
            [ BOX_SIZE_XYZ, [money_height, money_width, money_depth] ],
            [ BOX_LID,
                getLidAttributes(txt="Coins"),
            ],
            [ BOX_COMPONENT,
                [
                    [ CMP_COMPARTMENT_SIZE_XYZ, [ money_height-gw2, money_width-gw2, money_depth] ],
                    [POSITION_XY, [0,0]]
                ]
            ],
         ]
     ], 
     ["cards_tech_x1", 
        [
            [BOX_SIZE_XYZ, [cards_height, cards_width, tech_cards_depth]],
            [ BOX_LID,
                getLidAttributes(txt="Technologies"),
            ],
            [ BOX_COMPONENT,
                [
                    [ CMP_COMPARTMENT_SIZE_XYZ, [ cards_height-gw2, cards_width-gw2, tech_cards_depth] ],
                    [CMP_CUTOUT_SIDES_4B, [f,f,f,t]]
                ]
            ],
        ]
     ],
     ["other_cards_top_x1", 
        [
            [BOX_SIZE_XYZ, [cards_height, cards_width, other_cards_depth]],
            [ BOX_LID,
                getLidAttributes(txt="Cards"),
            ],
            [ BOX_COMPONENT,
                [
                    [ CMP_COMPARTMENT_SIZE_XYZ, [ cards_height-gw2, cards_width-gw2, tech_cards_depth] ],
                    [CMP_CUTOUT_SIDES_4B, [f,f,f,t]]
                ]
            ],
        ]
     ],
     ["other_cards_bottom_x2", 
        [
            [BOX_SIZE_XYZ, [cards_height, cards_width, other_cards_depth]],
            [ BOX_NO_LID_B, true],
            [ BOX_STACKABLE_B, true],  
            [ BOX_COMPONENT,
                [
                    [ CMP_COMPARTMENT_SIZE_XYZ, [ cards_height-gw2, cards_width-gw2, tech_cards_depth] ],
                    [CMP_CUTOUT_SIDES_4B, [f,f,f,t]]
                ]
            ],
        ]
     ],
     ["leader_cards_first_player_x1", 
        [
            [BOX_SIZE_XYZ, [leader_cards_height, leader_cards_width, leader_cards_depth]],
            [ BOX_LID,
                getLidAttributes(txt="Leaders"),
            ],
            [ BOX_COMPONENT,
                [
                    [ CMP_COMPARTMENT_SIZE_XYZ, [ leader_cards_height-gw2, leader_cards_width-gw2, tech_cards_depth] ],
                ]
            ],
        ]
     ],
      ["good_tiles_x1", 
        [
            [BOX_SIZE_XYZ, [goods_height, goods_width, goods_depth]],
            [ BOX_NO_LID_B, true],
            [ BOX_STACKABLE_B, true],
            [ BOX_COMPONENT,
                [
                    [ CMP_COMPARTMENT_SIZE_XYZ, [ goods_height-gw2, goods_width-gw2, goods_depth] ],
                ]
            ],
        ]
     ],
     ["card_tiles_x1", 
        [
            [BOX_SIZE_XYZ, [tile_cards_height, tile_cards_width, tile_cards_depth]],
            [ BOX_LID,
                getLidAttributes(txt="Tiles"),
            ],
            [ BOX_COMPONENT,
                [
                    [ CMP_COMPARTMENT_SIZE_XYZ, [ tiles_width+gw4+gw2, tile_cards_width-gw2, tile_cards_depth] ],
                    [POSITION_XY, [0,0]]
                ]
            ],
            [ BOX_COMPONENT,
                [
                    [ CMP_COMPARTMENT_SIZE_XYZ, [ tiles_height+gw4+gw, tiles_width+gw3, tile_cards_depth] ],
                    [POSITION_XY, [ tiles_width+gw4+gw2+gw,0]]
                ]
            ],
            [ BOX_COMPONENT,
                [
                    [ CMP_COMPARTMENT_SIZE_XYZ, [ tiles_height+gw4+gw, tiles_width+gw2, tile_cards_depth] ],
                    [POSITION_XY, [ tiles_width+gw4+gw2+gw,tiles_width+gw4]]
                ]
            ],
            [ BOX_COMPONENT,
                [
                    [ CMP_COMPARTMENT_SIZE_XYZ, [ 30, 50, tile_cards_depth] ],
                    [POSITION_XY, [ CENTER, CENTER]]
                ]
            ],
        ]
     ],  
];


MakeAll();