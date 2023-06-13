# adb 동영상 촬영
alias adb-record="adb shell screenrecord --size 1280x720 /sdcard/demo.mp4"

# adb 동영상 촬영 파일 가져오기
alias adb-record-get="adb pull /sdcard/demo.mp4 ~/Downloads/demo.mp4 && open ~/Downloads"

# adb 스킴 입력받아서 실행
# ex) adb-scheme scheme://host
alias adb-scheme='function _runScheme(){ adb shell am start -a android.intent.action.VIEW -d "$1"};_runScheme'

# 동적으로 파라미터를 받아서 사용 ex) adb-scheme-param value
alias adb-scheme-param='function _runScheme(){ adb shell am start -a android.intent.action.VIEW -d "scheme://host/path?param=$1"};_runScheme'

# adb 입력한 이름으로 스크린 캡쳐 후 다운로드하고 해당 폴더 열기
# 아무것도 입력하지 않으면 demo.png 로 기본 설정
# ex1) adb-c test1 -> test1.png 이름으로 캡쳐하고 Downloads 폴더에 다운로드
# ex2) adb-c -> demo.png 이름으로 캡쳐하고 Downloads 폴더에 다운로드
alias adb-c=run_capture

function run_capture() {
  if [[ $# -gt 0 ]]; then
    file_name="$1.png"
  else
    file_name="demo.png"
  fi

  adb shell screencap /sdcard/"$file_name" && adb pull /sdcard/"$file_name" ~/Downloads/"$file_name" && open ~/Downloads
}