VERSION=0.3.0

MINOR=$(echo ${VERSION} | cut -d . -f 2)
NEXT_MINOR=$(echo $((MINOR+1)))
NEXT_VERSION="0.$NEXT_MINOR.0-SNAPSHOT"
sed -i "s/$VERSION/$NEXT_VERSION/g" ami-monitoring.json