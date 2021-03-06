#!/bin/bash -e

mirror="http://ftp.de.debian.org/debian"

package_name="qtwebsockets-opensource-src"
debian_pkg_name="${package_name}"
package_version="5.4.1"
package_source="${debian_pkg_name}_${package_version}.orig.tar.xz"
src_dir="${package_name}-${package_version}"

git_repo=""
git_sha=""
reprepro_dir="q/${debian_pkg_name}"
dl_path="pool/main/${reprepro_dir}/"

debian_version="${package_version}-1"
debian_untar="${debian_pkg_name}_${debian_version}.debian.tar.xz"
debian_patch=""

jessie_version="~bpo80+20150331+1"
