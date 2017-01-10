#!/bin/bash
. /home/paso/.bashrc

#define variables
CUR_DIR="`pwd`"
NEW_BUILD="/home/paso/android/system/out/target/product/gemini/lineage-14.1-`date +%Y%m%d`-UNOFFICIAL-gemini.zip"
NEW_META="/home/paso/android/system/out/target/product/gemini/meta.txt"

#cleanup
rm $NEW_BUILD*
rm /home/paso/android/system/out/target/product/gemini/lineage-14.1-*-UNOFFICIAL-gemini.zip
rm /home/paso/android/system/out/target/product/gemini/*ota*.zip


#sync and build
cd /home/paso/android/system
repo sync -j8
. build/envsetup.sh
brunch gemini

#create metadata for updater
$CUR_DIR/generatemeta.sh > /home/paso/android/system/out/target/product/gemini/meta.txt

#if main file was successfully created we can upload everything to server
if [ -f $NEW_BUILD ];
then
	scp $NEW_BUILD* pi@192.168.100.2:"/media/USB/www/out/files"
	scp $NEW_META pi@192.168.100.2:"/media/USB/www/out/api/index.php"
	echo "Files uploaded to server."
else
	echo "Something failed, files not present, please check log."
fi



