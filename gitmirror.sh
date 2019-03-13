#!/bin/sh
if [ $# -eq 0 ]
then
	echo "Usage: $0 -p project -u guliuzhong"
	exit 1
fi
while getopts  :p:u: OPTION; do

    case $OPTION in
        p)
            PROJECT=$(echo "$OPTARG" | sed 's/\.git$//');
        ;;
        u)
            U=$(echo "$OPTARG");
        ;;
        ?)
            echo "illegal option $OPTION $OPTARG"
            exit 1;;

    esac;
done


PROJECTFIXED="${PROJECT}.git"
ROOT_PATH=$(env|grep HOME|awk -F '='   '{print $2}')"/IdeaProjects/mirror"
echo -e "根目录路径为\033[31;5m ${ROOT_PATH} \033[0m"

if [[ ! -d "$ROOT_PATH/${U}/${PROJECTFIXED}" ]] ; then
	mkdir -p "$ROOT_PATH/${U}/${PROJECTFIXED}"
	cd "$ROOT_PATH/${U}/${PROJECTFIXED}"
	echo "版本库地址 ssh://git@git.qintingfm.com:822/${U}/${PROJECTFIXED}"
	git clone "ssh://git@git.qintingfm.com:822/${U}/${PROJECTFIXED}" ./ --mirror
fi
if [[ ! -d "$ROOT_PATH/${U}/${PROJECTFIXED}/.git" ]] ;then
    echo "项目不存在,删除check文件"
    rm -frv "$ROOT_PATH/${U}/${PROJECTFIXED}"
    exit;
fi
cd "$ROOT_PATH/${U}/${PROJECTFIXED}"
git remote add github "git@github.com:${U}/${PROJECTFIXED}"
echo "更新最新代码"
git fetch origin --prune -v 
echo "推送github"
git push github --prune --mirror -v
echo "完成更新"
rm -frv "$ROOT_PATH/${U}/${PROJECTFIXED}"