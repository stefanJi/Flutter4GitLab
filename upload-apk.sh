apk_path="build/app/outputs/apk/release/app-release.apk"

echo "Start upload apk"

curl "http://devtools.qiniu.com/linux/amd64/qrsctl?ref=developer.qiniu.com" -o qrsctl
chmod +x qrsctl

./qrsctl login $QINIU_User $QINIU_Passwd
DATE=`date '+%Y%m%d_%H%M%S'`
name="apk/Flutter4GitLab_${DATE}.apk"
echo "Start put file ${name}"
./qrsctl put -c myapk name $apk_path
