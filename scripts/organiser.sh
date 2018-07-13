if ! [ "${1: -1}" = "/" ] ; then
	main_dir="${1}/"
else
	main_dir="${1}"
fi

if ! [ "${2: -1}" = "/" ] ; then
	copy_dir="${2}/"
else
	copy_dir="${2}"
fi

all_file_extensions="$(find ${main_dir} -type f | sed 's|.*\.||' | sort -u)"
echo "Copying..."
echo "------------------------------------"
for extension in $all_file_extensions
do
	number_of_files=$(find "${1}" -name "*.${extension}" | wc -l)
	echo "${extension} - ${number_of_files} files"
	extension_copy_dir="${copy_dir}${extension}/"
	mkdir -p "${extension_copy_dir}"

	cp "${main_dir}"**/*".${extension}" "${extension_copy_dir}"

	copied_files=$(find "${extension_copy_dir}" -type f | wc -l)

	if [ "${number_of_files}"="${copied_files}" ] ; then
		echo "All ${number_of_files} ${extension} files were organised sucessfuly in ${extension_copy_dir}"
	else
		echo "Error! ${copied_files} ${extension} copied but expected ${number_of_files} in ${extension_copy_dir}"
	fi
	echo "------------------------------------"
done



