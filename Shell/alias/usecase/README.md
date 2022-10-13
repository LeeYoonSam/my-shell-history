# 활용 사례

## Android ADB

### 맥과 연결된 Device 화면 녹화
```shell
alias video="adb shell screenrecord --size 1280x720 /sdcard/demo.mp4"
```

### 화면 녹화 후 파일 가져오고 폴더 열기
```shell
alias video-get="adb pull /sdcard/demo.mp4 ~/Downloads/demo.mp4 && open ~/Downloads"
```