#!/bin/bash
echo "Wellcome to Jarvis!"

# project type
echo "what kind of project do you want to create?"
select PROJECT_TYPE in 'main(apk/aab)' 'module(aar)' 'flavors(aar)'
do
# package name
echo "Insert your package name for project:"
read PACKAGE
# project name
echo "Insert your name for project:"
read APPNAME
# jacoco
echo "Do you like add JaCoCo at project?"
select JACOCO_SELECTED in yes no
do
# sonarqube
echo "Do you like add Sonar at project?"
select SONAR_SELECTED in yes no
do
# github actions
echo "Do you like add GitthubActions at project?"
select GIHUB_ACTIONS_SELECTED in yes no
do
echo "Well Done! ;)  - It's was your selected options:"
echo "Projet type: $PROJECT_TYPE"
echo "Package name: $PACKAGE"
echo "Project name: $APPNAME"
echo "Jacoco selected: $JACOCO_SELECTED"
echo "Sonarqube selected: $SONAR_SELECTED"
echo "Github actions selected: $GIHUB_ACTIONS_SELECTED"
echo "Done!"
echo "=================================================="
break;
done
break;
done
break;
done
break;
done

#download project from github repository
echo "Download project from github repository"
declare REPOSITORY="https://github.com/Hacybeyker/android-template.git"
declare BRANCH=""
declare PATH_DOWNLOAD=""

if [ $PROJECT_TYPE == "main(apk/aab)" ]
then
	BRANCH="feature-actions-lint"
fi
if [ $PROJECT_TYPE == "module(aar)" ]
then
	BRANCH="module"
fi
if [ $PROJECT_TYPE == "flavors(aar)" ]
then
	BRANCH="flavors"
fi
PATH_DOWNLOAD="git clone $REPOSITORY --branch $BRANCH"
$PATH_DOWNLOAD
echo "Done!"
echo "=================================================="

# Change folder main
echo "Changing folder main project"
mkdir -p $APPNAME
mv ./android-template/* $APPNAME
rm -rf ./android-template
echo "Done!"
echo "=================================================="

# Move folders
echo "Moving folders to new path"
SUBDIR=${PACKAGE//.//} # Replaces . with /
echo "app name: $APPNAME"
echo "$APPNAME/buildSrc/*"
for n in $(find ./$APPNAME -not -path "*/buildSrc/*" -type d \( -path '*/src/androidTest' -or -path '*/src/main' -or -path '*/src/test' \) )
do
  echo "Creating $n/java/$SUBDIR"
  mkdir -p $n/java/$SUBDIR
  echo "Moving files to $n/java/$SUBDIR"
  mv $n/java/com/hacybeyker/template/* $n/java/$SUBDIR
  echo "Removing old $n/java/com/hacybeyker/template"
  rm -rf mv $n/java/com/hacybeyker/template
  echo "--------------------------------------------------"
done
echo "Done!"
echo "=================================================="

# Rename package and imports
echo "Renaming packages to $PACKAGE"
find $APPNAME/ -type f -name "*.kt" -exec sed -i.bak "s/package com.hacybeyker.template/package $PACKAGE/g" {} \;
find $APPNAME/ -type f -name "*.kt" -exec sed -i.bak "s/import com.hacybeyker.template/import $PACKAGE/g" {} \;
echo "Done!"
echo "=================================================="

# Gradle files
echo "Renaming *.kts files"
find $APPNAME/ -type f -name "*.kts" -exec sed -i.bak "s/com.hacybeyker.template/$PACKAGE/g" {} \;
echo "Done!"
echo "=================================================="

# Rename app
if [[ $APPNAME ]]
then
	echo "Renaming app to $APPNAME"
	declare APPLICATION="${APPNAME}Application"
	find $APPNAME/ -type f \( -name "MyApplication.kt" -or -name "AndroidManifest.xml" \) -exec sed -i.bak "s/MyApplication/$APPLICATION/g" {} \;
    find $APPNAME/ -type f \( -name "settings.gradle.kts" -or -name "*.xml" \) -exec sed -i.bak "s/AndroidTemplate/$APPNAME/g" {} \;
	find $APPNAME/ -type f \( -name "ConfigureApp.kt" \) -exec sed -i.bak "s/com.hacybeyker.template/$PACKAGE/g" {} \;
    find $APPNAME/ -name "MyApplication.kt" | sed "p;s/MyApplication/$APPLICATION/" | tr '\n' '\0' | xargs -0 -n 2 mv
fi
echo "Done!"
echo "=================================================="

# JaCoCo
echo "Configuring JaCoCo"
if [[ $JACOCO_SELECTED == "" || $JACOCO_SELECTED == "no" ]]
then
	sed --in-place '/from("jacoco.gradle")/d' $APPNAME/app/build.gradle.kts
	rm -rf $APPNAME/app/jacoco.gradle
	rm -rf $APPNAME/app/filter.gradle
fi
echo "Done!"
echo "=================================================="

# SonarQube
echo "Configuring SonarQube"
if [[ $SONAR_SELECTED == "" || $SONAR_SELECTED == "no" ]]
then
	sed --in-place '/alias(libs.plugins.sonar)/d' $APPNAME/app/build.gradle.kts
	sed --in-place '/from("sonarqube.gradle")/d' $APPNAME/app/build.gradle.kts
	rm -rf $APPNAME/app/sonarqube.gradle
fi
echo "Done!"
echo "=================================================="

# Github Actions
echo "Configuring Github Actions"
if [[ $GIHUB_ACTIONS_SELECTED == "" || $GIHUB_ACTIONS_SELECTED == "no" ]]
then
	rm -rf $APPNAME/.github
elif
	echo "yes selected"
	echo "update package"
	sed --in-place '/TODO change for your packageName/d' $APPNAME/.github/workflows/actions/android_publish.yml
	find $APPNAME/.github/workflows/actions/android_publish.yml -exec sed -i.bak "s/com.your.package/$PACKAGE/g" {} \;
fi
echo "Done!"
echo "=================================================="

# Clean file .back
echo "Cleaning up"
find $APPNAME/ -name "*.bak" -type f -delete
echo "Done!"
echo "=================================================="

# Remove additional files
echo "Removing additional files"
rm -rf $APPNAME/.git/
rm -rf $APPNAME/jarvis.sh jarvis.sh
rm -rf $APPNAME/README.md
rm -rf $APPNAME/CHANGELOG.md

echo "Done!"