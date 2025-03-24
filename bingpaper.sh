#!/bin/sh

WP_FILE=$HOME/.config/awesome/themes/powerarrow-dark/wallpaper.jpg

bing="www.bing.com"

# $xmlURL is needed to get the xml data from which
# the relative URL for the Bing pic of the day is extracted
#
# The mkt parameter determines which Bing market you would like to
# obtain your images from.
# Valid values are: en-US, zh-CN, ja-JP, en-AU, en-UK, de-DE, en-NZ, en-CA or opted out.
#
# The idx parameter determines where to start from. 0 is the current day,
# 1 the previous day, etc.
# xmlURL="http://www.bing.com/HPImageArchive.aspx?format=xml&idx=0&n=1&mkt=en-US"
# https://cn.bing.com/th?id=OHR.NebraskaStorm_EN-US1163295363_UHD.jpg&rf=LaDigue_UHD.jpg&pid=hp&w=3840&h=2160&rs=1&c=4
xmlURL="https://cn.bing.com/HPImageArchive.aspx?format=xml&idx=0&n=1&uhd=1&uhdwidth=3840&uhdheight=2160"
# The desired Bing picture resolution to download
# Valid options: "_1024x768" "_1280x720" "_1366x768" "_1920x1200" "_UHD"
desiredPicRes="_UHD"

# The file extension for the Bing pic
picExt=".jpg"

# Extract the relative URL of the Bing pic of the day from
# the XML data retrieved from xmlURL, form the fully qualified
# URL for the pic of the day, and store it in $picURL
# <urlBase>/th?id=OHR.NebraskaStorm_EN-US1163295363</urlBase>

# Form the URL for the desired pic resolution
desiredPicURL=$bing$(curl -s $xmlURL | grep -oP "(?<=<urlBase>)(.*?)(?=</urlBase>)")$desiredPicRes$picExt

# Form the URL for the default pic resolution
defaultPicURL=$bing$(curl -s $xmlURL | grep -oP "(?<=<url>)(.*?)(?=</url>)")

# $picName contains the filename of the Bing pic of the day

# Attempt to download the desired image resolution. If it doesn't
# exist then download the default image resolution
if wget --quiet --spider "$desiredPicURL"
then

    # Download the Bing pic of the day at desired resolution
    curl -s -o "$WP_FILE" "$desiredPicURL"
else
    # Download the Bing pic of the day at default resolution
    curl -s -o "$WP_FILE" "$defaultPicURL"
fi
