apk_path="build/app/outputs/apk/release/app-release.apk"

echo "Start upload apk"

curl "http://devtools.qiniu.com/linux/amd64/qrsctl?ref=developer.qiniu.com" -o qrsctl
chmod +x qrsctl

./qrsctl login $QINIU_User $QINIU_Passwd

echo "Start put file"
DATE=`date '+%Y_%m_%d_%H:%M:%S'`
./qrsctl put -c myapk "apk/Flutter4GitLab_${DATE}.apk" $apk_path
