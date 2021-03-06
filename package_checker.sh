#!/bin/bash

check_http () {
	echo "Checking: ${package_name}"
	if [ -f /tmp/index.html ] ; then
		rm -f /tmp/index.html
	fi
	wget --no-verbose --directory-prefix=/tmp/ ${site}/${package_name}/ &> /dev/null
	cat /tmp/index.html | grep "<a href=" > /tmp/temp.html
	sed -i -e "s/<a href/\\n<a href/g" /tmp/temp.html
	sed -i -e 's/\"/\"><\/a>\n/2' /tmp/temp.html
	cat /tmp/temp.html | grep href | grep dsc > /tmp/index.html
	sed -i -e 's/<a href="//g' /tmp/index.html
	sed -i -e 's/"><\/a>//g' /tmp/index.html

	version=$(cat /tmp/index.html | grep -v bpo | grep dsc | tail -n 1 | awk -F ".dsc" '{print $1}')
	if [ ! "x${version}" = "x" ] ; then
		if [ ! "x${package_version}" = "x${version}" ] ; then
			echo "Change: ${package_name}: upstream:${version} local:${package_version}"
			echo ""
		fi
	else
		echo ${output}
	fi
}

check () {
	echo "Checking: ${package_name}"
	output=$(rmadison -s ${suite} ${package_name} | grep ${package_name})
	version=$(echo ${output} | awk '{print $3}')
	if [ ! "x${version}" = "x" ] ; then
		if [ ! "x${package_version}" = "x${version}" ] ; then
			echo "Change: ${package_name}: ${suite}:${version} local:${package_version}"
			echo ""
		fi
	else
		echo ${output}
	fi
}

mesa () {
	echo "llvm/mesa:"

	site="http://ftp.de.debian.org/debian/pool/main/l"
	package_name="llvm-toolchain-3.6" ; package_version="${package_name}_3.6.1-1" ; check_http

	site="http://ftp.de.debian.org/debian/pool/main/libd"
	package_name="libdrm" ; package_version="${package_name}_2.4.60-3" ; check_http

	site="http://ftp.de.debian.org/debian/pool/main/m"
	package_name="mesa" ; package_version="${package_name}_10.5.5-1" ; check_http
}

qt5 () {
	echo "qt5:"

	site="http://ftp.de.debian.org/debian/pool/main/p"
	package_name="pkg-kde-tools" ; package_version="${package_name}_0.15.17" ; check_http

	site="http://ftp.de.debian.org/debian/pool/main/e"
	package_name="extra-cmake-modules" ; package_version="${package_name}_5.9.0-1" ; check_http

#	site="http://ftp.de.debian.org/debian/pool/main/q"
#	package_name="qtbase-opensource-src" ; package_version="${package_name}_5.4.1+dfsg-2" ; check_http
#	package_name="qtchooser" ; package_version="${package_name}_52-gae5eeef-1" ; check_http
#	package_name="qtxmlpatterns-opensource-src" ; package_version="${package_name}_5.4.1-1" ; check_http
#	package_name="qtdeclarative-opensource-src" ; package_version="${package_name}_5.4.1-1" ; check_http
#	package_name="qtscript-opensource-src" ; package_version="${package_name}_5.4.1+dfsg-3" ; check_http

	#qtwebkit takes about a half day build...
#	package_name="qtwebkit-opensource-src" ; package_version="${package_name}_5.4.1+dfsg-3" ; check_http
#	package_name="qttools-opensource-src" ; package_version="${package_name}_5.4.1-1" ; check_http

#	package_name="qtconnectivity-opensource-src" ; package_version="${package_name}_5.4.1-2" ; check_http
#	package_name="qtenginio-opensource-src" ; package_version="${package_name}_5.4.1-1" ; check_http
#	package_name="qtgraphicaleffects-opensource-src" ; package_version="${package_name}_5.4.1-1" ; check_http
#	package_name="qtimageformats-opensource-src" ; package_version="${package_name}_5.4.1-1" ; check_http
#	package_name="qtlocation-opensource-src" ; package_version="${package_name}_5.4.1-1" ; check_http
#	package_name="qtmultimedia-opensource-src" ; package_version="${package_name}_5.4.1-1" ; check_http
#	package_name="qtquick1-opensource-src" ; package_version="${package_name}_5.4.1-1" ; check_http
#	package_name="qtquickcontrols-opensource-src" ; package_version="${package_name}_5.4.1-1" ; check_http
#	package_name="qtsensors-opensource-src" ; package_version="${package_name}_5.4.1+dfsg-1" ; check_http
#	package_name="qtserialport-opensource-src" ; package_version="${package_name}_5.4.1-1" ; check_http
#	package_name="qtsvg-opensource-src" ; package_version="${package_name}_5.4.1-1" ; check_http
#	package_name="qttranslations-opensource-src" ; package_version="${package_name}_5.4.1-1" ; check_http
#	package_name="qtwayland-opensource-src" ; package_version="${package_name}_5.4.1-1" ; check_http
#	package_name="qtwebkit-examples-opensource-src" ; package_version="${package_name}_5.4.1+dfsg-1" ; check_http
#	package_name="qtwebsockets-opensource-src" ; package_version="${package_name}_5.4.1-1" ; check_http
#	package_name="qtx11extras-opensource-src" ; package_version="${package_name}_5.4.1-1" ; check_http
#	package_name="qtdoc-opensource-src" ; package_version="${package_name}_5.4.1-1" ; check_http

#	package_name="qbs" ; package_version="${package_name}_1.4~7fd456-1" ; check_http
#	package_name="qtcreator" ; package_version="${package_name}_3.3.1+dfsg-1" ; check_http
}

qt5_kde () {
	echo "qt5: kde:"

	site="http://ftp.de.debian.org/debian/pool/main/s"
	package_name="solid" ; package_version="${package_name}_5.9.0-1" ; check_http

	site="http://ftp.de.debian.org/debian/pool/main/k"
	package_name="kcoreaddons" ; package_version="${package_name}_5.9.0-1" ; check_http
	package_name="kguiaddons" ; package_version="${package_name}_5.9.0-1" ; check_http
	package_name="kwindowsystem" ; package_version="${package_name}_5.9.0-1" ; check_http
}

qt5_apps () {
	echo "connman/cmst:"

	site="http://packages.siduction.org/extra/pool/main/c"
	package_name="connman" ; package_version="connman_1.29-0%2bexp1" ; check_http
	package_name="cmst" ; package_version="cmst_2015.04.22-1%2bexp2" ; check_http

	echo "qterminal:"

	site="http://packages.siduction.org/lxqt/pool/main/q"
	package_name="qtermwidget" ; package_version="qtermwidget_0.6.0-9" ; check_http
	package_name="qterminal" ; package_version="qterminal_0.6.0-8" ; check_http
}

qt5_lxqt () {
	echo "lxqt:"

	site="http://packages.siduction.org/extra/pool/main/libd"
	package_name="libdbusmenu-qt5" ; package_version="${package_name}_0.9.3-1siduction3" ; check_http

	site="http://packages.siduction.org/lxqt/pool/main/p"
	package_name="polkit-qt-1" ; package_version="${package_name}_0.112.0-2" ; check_http

	site="http://packages.siduction.org/lxqt/pool/main/libq"
	package_name="libqtxdg" ; package_version="${package_name}_1.2.0-3%2bexp2" ; check_http

	site="http://packages.siduction.org/lxqt/pool/main/libl"
	package_name="liblxqt" ; package_version="${package_name}_0.9.0-9%2bexp1" ; check_http

	site="http://packages.siduction.org/lxqt/pool/main/l"
	package_name="lxqt-globalkeys" ; package_version="${package_name}_0.9.0-5" ; check_http
	package_name="lxqt-notificationd" ; package_version="${package_name}_0.9.0-7%2bexp1" ; check_http

	site="http://packages.siduction.org/lxqt/pool/main/libs"
	package_name="libsysstat" ; package_version="${package_name}_0.3.0-2" ; check_http

	site="http://packages.siduction.org/lxqt/pool/main/l"
	package_name="lxqt-panel" ; package_version="${package_name}_0.9.0-9a" ; check_http

	site="http://packages.siduction.org/lxqt/pool/main/p"
	package_name="pcmanfm-qt" ; package_version="${package_name}_0.9.0-8%2bexp2" ; check_http

	site="http://packages.siduction.org/lxqt/pool/main/l"
	package_name="lxqt-session" ; package_version="${package_name}_0.9.0-9%2bexp1" ; check_http
	package_name="lxqt-runner" ; package_version="${package_name}_0.9.0-3" ; check_http
	package_name="lxqt-policykit" ; package_version="${package_name}_0.9.0-3" ; check_http
	package_name="lxqt-powermanagement" ; package_version="${package_name}_0.9.0-8%2bexp1" ; check_http
	package_name="lxqt-qtplugin" ; package_version="${package_name}_0.9.0-2%2bexp1" ; check_http
	package_name="lximage-qt" ; package_version="${package_name}_0.4.0-1" ; check_http
	package_name="lxqt-config" ; package_version="${package_name}_0.9.0-11%2bexp2" ; check_http

	site="http://packages.siduction.org/lxqt/pool/main/o"
	package_name="obconf-qt" ; package_version="${package_name}_0.1.2-2" ; check_http

	site="http://packages.siduction.org/lxqt/pool/main/c"
	package_name="compton-conf" ; package_version="${package_name}_0.1.2-5%2bexp1" ; check_http

	site="http://packages.siduction.org/lxqt/pool/main/l"
	package_name="lxqt-about" ; package_version="${package_name}_0.9.0-2" ; check_http
	package_name="lxqt-admin" ; package_version="${package_name}_0.9.0-4" ; check_http
	package_name="lxqt-common" ; package_version="${package_name}_0.9.1-8%2bexp1" ; check_http
}

machinekit () {
	echo "machinekit:"

	site="http://deb.dovetail-automata.com/deb-testing/pool/main/c"
	package_name="czmq" ; package_version="${package_name}_2.2.0-0.5%7e1jessie%7e1da" ; check_http

	site="http://deb.dovetail-automata.com/deb-testing/pool/main/libw"
	package_name="libwebsockets" ; package_version="${package_name}_1.3-1%7egit95a8abb%7e1431844465git95a8abb%7e1jessie%7e1da" ; check_http

	site="http://deb.dovetail-automata.com/deb-testing/pool/main/x"
	package_name="xenomai" ; package_version="${package_name}_2.6.4-1%7e1jessie%7e1da" ; check_http
}

nodejs () {
	echo "nodejs:"
	site="http://ftp.de.debian.org/debian/pool/main/g"
	package_name="gyp" ; package_version="${package_name}_0.1~svn1729-3" ; check_http

	site="http://ftp.de.debian.org/debian/pool/main/libv"
	package_name="libv8-3.14"; package_version="${package_name}_3.14.5.8-8.1"; check_http

	site="http://ftp.de.debian.org/debian/pool/main/n"
	package_name="nodejs"; package_version="${package_name}_0.10.38~dfsg-1"; check_http
}

mesa
qt5
qt5_kde
qt5_apps
qt5_lxqt
machinekit
nodejs

echo "others"

site="http://ports.ubuntu.com/pool/universe/c"
package_name="chromium-browser" ; package_version="${package_name}_42.0.2311.135-1ubuntu1.1160" ; check_http

#really slow...
#exit

suite="experimental"
package_name="policykit-1" ; package_version="0.112-4" ; check

suite="sid"
package_name="openjdk-8-jdk" ; package_version="8u40~b09-1" ; check
package_name="openjfx" ; package_version="8u20-b26-3" ; check
package_name="waffle" ; package_version="1.5.1-1" ; check
package_name="xinput-calibrator" ; package_version="0.7.5+git20140213-1" ; check
package_name="xserver-xorg-video-omap" ; package_version="0.4.3-git20130328-1" ; check
package_name="xserver-xorg-video-modesetting" ; package_version="0.9.0-1" ; check

suite="jessie"
package_name="cython" ; package_version="0.19.1+git34-gac3e3a2-1" ; check
package_name="jansson"; package_version="2.7-1"; check
package_name="libsodium"; package_version="1.0.0-1"; check
package_name="node-abbrev"; package_version="1.0.5-2"; check
package_name="node-ansi"; package_version="0.3.0-2"; check
package_name="node-ansi-color-table"; package_version="1.0.0-1"; check
package_name="node-archy"; package_version="0.0.2-1"; check
package_name="node-async"; package_version="0.8.0-1"; check
package_name="node-block-stream"; package_version="0.0.7-1"; check
package_name="node-combined-stream"; package_version="0.0.5-1"; check
package_name="node-cookie-jar"; package_version="0.3.1-1"; check
package_name="node-delayed-stream"; package_version="0.0.5-1"; check
package_name="node-forever-agent"; package_version="0.5.1-1"; check
package_name="node-form-data"; package_version="0.1.0-1"; check
package_name="node-fstream"; package_version="0.1.24-1"; check
package_name="node-fstream-ignore"; package_version="0.0.6-2"; check
package_name="node-github-url-from-git"; package_version="1.1.1-1"; check
package_name="node-glob"; package_version="4.0.5-1"; check
package_name="node-graceful-fs"; package_version="3.0.2-1"; check
package_name="node-gyp"; package_version="0.12.2+ds-1"; check
package_name="node-inherits"; package_version="2.0.1-1"; check
package_name="node-ini"; package_version="1.1.0-1"; check
package_name="node-json-stringify-safe"; package_version="5.0.0-1"; check
package_name="node-lockfile"; package_version="0.4.1-1"; check
package_name="node-lru-cache"; package_version="2.3.1-1"; check
package_name="node-marked"; package_version="0.3.2+dfsg-1"; check
package_name="node-mime"; package_version="1.2.11-1"; check
package_name="node-minimatch"; package_version="1.0.0-1"; check
package_name="node-mkdirp"; package_version="0.5.0-1"; check
package_name="node-mute-stream"; package_version="0.0.4-1"; check
package_name="node-nopt"; package_version="3.0.1-1"; check
package_name="node-normalize-package-data"; package_version="0.2.2-1"; check
package_name="node-npmlog"; package_version="0.0.4-1"; check
package_name="node-once"; package_version="1.1.1-1"; check
package_name="node-optimist"; package_version="0.3.5-1"; check
package_name="node-osenv"; package_version="0.1.0-1"; check
package_name="node-qs"; package_version="2.2.4-1"; check
package_name="node-read"; package_version="1.0.5-1"; check
package_name="node-read-package-json"; package_version="1.2.4-1"; check
package_name="node-request"; package_version="2.26.1-1"; check
package_name="node-retry"; package_version="0.6.0-1"; check
package_name="node-rimraf"; package_version="2.2.8-1" ; check
package_name="node-semver"; package_version="2.1.0-2" ; check
package_name="node-sha"; package_version="1.2.3-1"; check
package_name="node-sigmund"; package_version="1.0.0-1"; check
package_name="node-slide"; package_version="1.1.4-1"; check
package_name="node-tar"; package_version="0.1.18-1" ; check
package_name="node-tunnel-agent"; package_version="0.3.1-1"; check
package_name="node-uglify" ; package_version="2.4.15-1" ; check
package_name="node-underscore" ; package_version="1.7.0~dfsg-1" ; check
package_name="node-uuid"; package_version="1.4.0-1" ; check
package_name="node-which"; package_version="1.0.5-2"; check
package_name="node-wordwrap"; package_version="0.0.2-2"; check
package_name="npm"; package_version="1.4.21+ds-2"; check
package_name="python-sendfile" ; package_version="2.0.0-6" ; check
package_name="python-pyftpdlib" ; package_version="1.2.0-1" ; check
package_name="tmux" ; package_version="1.9-6" ; check

echo "Done:"
#
