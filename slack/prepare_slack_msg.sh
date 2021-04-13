LIB_PROP_FILE="lib.properties"
VERSION_NAME=`cat $LIB_PROP_FILE | grep VERSION_NAME | cut -d = -f 2`
SITE_URL=`cat $LIB_PROP_FILE | grep SITE_URL | cut -d = -f 2`
LIB_NAME=`echo $SITE_URL | cut -d / -f 5`
GIT_CHANGELOG=`git log $(git describe --tags --abbrev=0 --always $(git rev-list --tags --skip=1 --max-count=1))..HEAD --oneline --no-decorate | cut -d ' ' -f 2- | tail -n +2`
export SLACK_MSG_TITLE="$LIB_NAME $VERSION_NAME released :tada:"
export SLACK_MSG="Changes:
$GIT_CHANGELOG

See more at $SITE_URL."
SLACK_MSG="${SLACK_MSG//'%'/'%25'}"
SLACK_MSG="${SLACK_MSG//$'\n'/'%0A'}"
SLACK_MSG="${SLACK_MSG//$'\r'/'%0D'}"
echo "::set-output name=SLACK_MSG::$(echo "$SLACK_MSG")"
echo "::set-output name=SLACK_MSG_TITLE::$(echo "$SLACK_MSG_TITLE")"
