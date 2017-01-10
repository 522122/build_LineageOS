#!/bin/bash

TAR_DATE=`date +%Y%m%d`
TIMESTAMP=`date -r /home/paso/android/system/out/target/product/gemini/lineage-14.1-$TAR_DATE-UNOFFICIAL-gemini.zip.md5sum +%s`
INCREMENTAL=`awk -F: '{print $2}' /home/paso/android/system/out/target/product/gemini/build_fingerprint.txt | awk -F\/ '{print $3}'`
MD5SUM=`awk '{print $1}' /home/paso/android/system/out/target/product/gemini/lineage-14.1-$TAR_DATE-UNOFFICIAL-gemini.zip.md5sum`

echo "{ 
	id: null,
	result: [{ 
		incremental: '$INCREMENTAL', 
		api_level: '25', 
		url: 'http://vpn.paskalev.sk/files/lineage-14.1-$TAR_DATE-UNOFFICIAL-gemini.zip',
		timestamp: $TIMESTAMP, 
		md5sum: '$MD5SUM', 
		channel: 'nightly', 
		filename: 'lineage-14.1-$TAR_DATE-UNOFFICIAL-gemini.zip',
		changes: '' 
	}],
	error: null 
}"
