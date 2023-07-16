#!/bin/sh
PROJECT=electronic_safe
TOP_LEVEL_FILE=electronic_safe.v
FAMILY="Cyclone II"
PART=EP2C35F672C6N
PACKING_OPTION=minimize_area
quartus_map $PROJECT --source=$TOP_LEVEL_FILE --family="$FAMILY"
quartus_fit $PROJECT --part=$PART --pack_register=$PACKING_OPTION
quartus_asm $PROJECT
quartus_sta $PROJECT
