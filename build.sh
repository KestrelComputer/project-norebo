#!/bin/bash
set -e
make

export NOREBO_PATH="$PWD/Custom:$PWD/Oberon:$PWD/Bootstrap"

mkdir -p build
cd build

../norebo ORP.Compile \
        Norebo.Mod/s \
        Kernel.Mod/s \
	FileDir.Mod/s \
	Files.Mod/s \
	Modules.Mod/s \
	Fonts.Mod/s \
	Texts.Mod/s \
	RS232.Mod/s \
	Oberon.Mod/s \
	CoreLinker.Mod/s \
	ORS.Mod/s \
	ORB.Mod/s \
	ORG.Mod/s \
	ORP.Mod/s \
	ORTool.Mod/s

for i in *.rsc; do
  mv $i ${i%.rsc}.rsx
done

../norebo CoreLinker.LinkSerial Modules InnerCore

for i in *.rsx; do
  mv $i ${i%.rsx}.rsc
done

../norebo ORP.Compile MagicSquares.Mod

../norebo MagicSquares.Generate 4
