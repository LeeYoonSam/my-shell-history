# adb 동영상 촬영
alias adb-record="adb shell screenrecord --size 1280x720 /sdcard/demo.mp4"

# adb 동영상 촬영 파일 가져오기
alias adb-record-get="adb pull /sdcard/demo.mp4 ~/Downloads/demo.mp4 && open ~/Downloads"

# adb 스킴 입력받아서 실행
# ex) adb-scheme scheme://host
alias adb-scheme='function _runScheme(){ adb shell am start -a android.intent.action.VIEW -d "$1"};_runScheme'

# 동적으로 파라미터를 받아서 사용 ex) adb-scheme-param value
alias adb-scheme-param='function _runScheme(){ adb shell am start -a android.intent.action.VIEW -d "scheme://host/path?param=$1"};_runScheme'
# adb 스크린 캡쳐 후 다운로드하고 해당 폴더 열기
alias adb-c="adb shell screencap /sdcard/screen.png && adb pull /sdcard/screen.png ~/Downloads/screen.png && open ~/Downloads"
# adb 입력한 이름으로 스크린 캡쳐 후 다운로드하고 해당 폴더 열기
# adb-cn test1 -> test1.png 이름으로 캡쳐하고 Downloads 폴더에 다운로드
alias adb-cn='function _runCapture(){ adb shell screencap /sdcard/$1.png && adb pull /sdcard/$1.png ~/Downloads/$1.png && open ~/Downloads };_runCapture'