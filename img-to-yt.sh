#!/bin/bash

[ ! -d video ] && mkdir -p video

while read line
do
	echo "keywords ====> $line"
666   
	echo "googleimagesdownload --keywords \"${line// /-}\" --limit 95"  | bash -
   
	output_file="${line// /-}.mp4"
   
	echo "ls 'downloads/${line// /-}' > /tmp/deleteimage.txt" | bash -
   
	# ubah ukuran gambar HD 1280:720
	
	while read f; do
		echo "ffmpeg -y -i 'downloads/${line// /-}/$f' -vf scale=\"'if(gt(a,16/9),1280,-1)':'if(gt(a,16/9),-1,720)'\" 'delete_$f.jpg'" | bash -
	done < /tmp/deleteimage.txt
	
	# ubah nama file jpg
	a=1
	for i in *.jpg; do
		new=$(printf "%04d.jpg" "$a")
		mv -- "$i" "delete_$new"
		let a=a+1
	done
	
	# tambah background hitam, jika ingin warna lain ubah color=c=black, ukuran 1280x720 juga bisa diubah disesuaikan ukuran gambar
	for f in *.jpg; do
		ffmpeg -f lavfi -y -i "color=c=black:s=1280x720" -i "$f" -filter_complex "overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2" delete_$f
	done
	
	# buat video slide durasi per gambar 30 detik, jika ingin durasi lain ubah 1/30
	ffmpeg -framerate 1/10 -i delete_delete_%04d.jpg -c:v libx264 -r 30 -pix_fmt yuv420p delete.mp4
	
	# tambah musik + watermark, text bisa diganti, jika musik diganti, ubah alan.mp3
	text1=$(echo "Super Momod CHANNEL")
	text2=$(echo "JANGAN LUPA LIKE DAN SUBSCRIBE")
	text3=$(echo "$fo" | sed -e 's|_| |g' | tr a-z  A-Z)
	echo "ffmpeg -y -i delete.mp4 -i bin/alan.mp3 -filter_complex \"[0:v]drawtext=text='$text1':fontfile='bin/hard.ttf':x=(w-tw)/2:y=(h-th)/2:enable=lt(mod(t\,1.2)\,1):fontcolor=YELLOW@1.0:fontsize=45:shadowx=2:shadowy=2,drawtext=text='$text2':fontfile='bin/arialbd.ttf':y=h-line_h-10:x=w-mod(max(t-0\,0)*(w+tw)/10\,(w+tw)):fontcolor=RED@1.0:fontsize=45:shadowx=2:shadowy=2:enable=gt(mod(t\,60)\,50),drawtext=text='$text3':fontfile='bin/arialbd.ttf':y=10:x=w-mod(max(t-0\,0)*(w+tw)/10\,(w+tw)):fontcolor=white@1.0:fontsize=45:shadowx=2:shadowy=2:enable=gt(mod(t\,60)\,50)[vout]\" -map \"[vout]\" -map 1 -shortest 'video/${output_file}'" | bash -
	
	# Upload ke youtube
	
	youtube-upload --title="Modifikasi $line Keren Terbaru" --description="$line" --client-secrets=client_secret_1046948736062.json video/${line// /-}.mp4

	# hapus file yg tidak dibutuhkan
	rm -f delete*
	rm -f /tmp/delete*
	rm -rf downloads/*
	rm -rf video/*
	
   	sleep 1000
done < keywords.txt
