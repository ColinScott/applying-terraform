#!/usr/bin/env bash

pushd () {
    command pushd "$@" > /dev/null
}

popd () {
    command popd "$@" > /dev/null
}

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

account=$1
version=$2

if [[ -z "$account" ]]; then
    echo >&2 "You need to specify which account these will be created under."
	exit 1
fi

if [[ -z "$version" ]]; then
    echo >&2 "You need to specify which version these will be created under."
	exit 1
fi

for project in ${DIR}/${version}/environments/*/*/
do
	:
	project=${project%*/}
	basePath="$(dirname "$project")"
	dc_name="${basePath##*/}"
    echo "CONFIGURING ENVIRONMENT: ${dc_name} ${project##*/}"

	pushd ${project}

	read -d $'\x04' target_account < ".account"
	echo "Environment uses account: $target_account"

	if [[ ${target_account} == *"$account"* ]]; then
		echo "Executing terraform against environment: ${dc_name} ${project##*/}"
		terraform init -upgrade
		terraform get -update=true
	else
		echo "Skipping environment, does not match target account."
	fi

	popd
done