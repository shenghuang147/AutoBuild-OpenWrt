# 解决自添加源同名包无法覆盖官方源中的包

M_PKG_LIST=$(find ./openwrt/feeds/myPackages -type f -name "Makefile" -printf "%h\n" | sort -u)

for pkg_path in $M_PKG_LIST; do
	pkg_name=$(echo $pkg_path |awk -F / '{print $NF}')
	# 官方同名包路径
	wrt_pkg_path=$(find ./openwrt/feeds -type d ! -path '*/myPackages/*' -name $pkg_name \
		-exec test -f "{}/Makefile" \; -print)
	[ -n "$wrt_pkg_path" ] || continue

	rm -rf $wrt_pkg_path
	echo "rm -rf $wrt_pkg_path"

	cp -r $pkg_path $wrt_pkg_path
	echo "cp -r $pkg_path $wrt_pkg_path"
	
done
