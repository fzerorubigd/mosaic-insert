SPLIT = $(subst -, ,$@)
COMPONENT = $(word 2, $(SPLIT))
FILE = insert.scad
TARGET = game-insert.zip

all: player_top_x3 player_bottom_x3
	@echo Done!

zip: clean all
	zip $(TARGET) dist/*.stl

player_top_x3: box-player_top_x3 lid-player_top_x3
player_bottom_x3: box-player_bottom_x3

dist: 
	mkdir -p dist

lid-%: dist
	openscad -D "g_isolated_print_box=\"$(COMPONENT)\"" -D "g_b_print_lid=true" -D "g_b_print_box=false" -D "g_lid_solid=true" -o dist/$(COMPONENT)-lid-solid.stl $(FILE)
	openscad -D "g_isolated_print_box=\"$(COMPONENT)\"" -D "g_b_print_lid=true" -D "g_b_print_box=false" -D "g_lid_solid=false" -D "g_lid_label=false" -o dist/$(COMPONENT)-lid.stl $(FILE)
	openscad -D "g_isolated_print_box=\"$(COMPONENT)\"" -D "g_b_print_lid=true" -D "g_b_print_box=false" -D "g_lid_solid=false" -D "g_lid_label=true" -o dist/$(COMPONENT)-lid-label.stl $(FILE)

box-%: dist
	openscad -D "g_isolated_print_box=\"$(COMPONENT)\"" -D "g_b_print_lid=false" -D "g_b_print_box=true" -o dist/$(COMPONENT)-box.stl $(FILE)

clean:
	rm -f dist/*.stl $(TARGET)