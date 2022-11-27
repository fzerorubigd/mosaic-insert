include <bit/boardgame_insert_toolkit_lib.2.scad>;

// determines whether lids are output.
g_b_print_lid = true;

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

g_lid_solid = f;
g_lid_label = t;

function getLidAttributes(txt, rotation = 0, size = 10, solid=g_lid_solid) = (g_lid_label) ? [
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
box_height = 310;
box_depth = 62;

hex_r = 39;
hex_w = 34;
pedestal_h = 5;

city_d = 28+gw;
military_w = 28;
board_width = 195;
player_height = (hex_w+gw)*4+gw+(military_w+gw);
player_width = board_width / 3;
round_r = 24;
round_small_h = 2*((player_height-military_w-gw2)/3)-gw2;
round_big_h = player_height - military_w - gw4 - round_small_h;

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
                    [ CMP_COMPARTMENT_SIZE_XYZ, [ round_big_h, round_r, city_d] ],  
                    [POSITION_XY, [0,hex_r-gw/2]],
                ]
            ],
            [ BOX_COMPONENT,                             
                [
                    [ CMP_COMPARTMENT_SIZE_XYZ, [ round_small_h, round_r, city_d] ],  
                    [POSITION_XY, [round_big_h+gw,hex_r-gw/2]],
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
                    [ CMP_COMPARTMENT_SIZE_XYZ, [ round_big_h, round_r, city_d] ],  
                    [POSITION_XY, [0,hex_r-gw/2]],
                ]
            ],
            [ BOX_COMPONENT,                             
                [
                    [ CMP_COMPARTMENT_SIZE_XYZ, [ round_small_h, round_r, city_d] ],  
                    [POSITION_XY, [round_big_h+gw,hex_r-gw/2]],
                ]
            ]
        ]
    ]
    
    
];


MakeAll();