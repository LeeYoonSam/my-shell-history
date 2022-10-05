# Git 명령어

## Log

### commit log 보기
```shell
git log
```

### 변경된 파일 정보를 포함한 commit log 보기
```shell
git log -stat
```

### 변경 내용까지 포함한 commit log 보기
```shell
git log -p
```

---

## Repository

### 원격 저장소 리스트
```shell
git remote -v
```

### 원격 저장소 추가
```shell
git remote add origin http-or-ssh
```
- `origin` 이름으로 `http-or-ssh` 주소의 레파지토리 추가

### 원격 저장소 삭제
```shell
git remote remove origin
```
- `origin` 추가되어있는 이름으로 변경

--- 

## Branch

### Branch 이름 변경
```shell
git branch -M main
```
- 변경할 브랜치로 checkout 후 진행
- `main` 으로 브랜치명 변경

---

## Commit

### 이미 commit 된 커밋 메시지 수정
```shell
git commit --amend
```
- vi 나오면 메시지 수정 후 저장

### 이미 commit 된 작성자 정보 수정
```shell
git commit --amend --author="Name<email@gmail.com>"
```
- vi 나오면 메시지 수정 후 저장