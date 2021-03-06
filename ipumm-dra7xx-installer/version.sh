#!/bin/bash -e

package_name="ipumm-dra7xx-installer"
debian_pkg_name="${package_name}"
package_version="3.00.07.02"
package_source=""
src_dir=""

git_repo=""
git_sha=""
reprepro_dir="i/${package_name}"
dl_path="pool/main/${reprepro_dir}/"

debian_version="${package_version}-1"
debian_untar=""
debian_patch=""

wheezy_version="~bpo70+20150320+1"
jessie_version="~bpo80+20150320+1"
trusty_version="~bpo1404+20150320+1"
utopic_version="~bpo1410+20150320+1"
vivid_version="~bpo1504+20150320+1"
