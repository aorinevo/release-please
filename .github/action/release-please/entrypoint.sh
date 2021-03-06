#!/bin/sh
# Copyright 2019 Google LLC. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -e

export COMMAND=${RELEASE_PLEASE_COMMAND:-release-pr}
export ACTION=$(cat "$GITHUB_EVENT_PATH" | json action)
export MERGED=$(cat "$GITHUB_EVENT_PATH" | json pull_request.merged)

echo "action = $ACTION, merged = $MERGED"
if [[ "$ACTION" = "closed" ]] && [[ "$MERGED" = "true" ]]; then
  release-please $COMMAND --token=$GITHUB_TOKEN \
    --repo-url="git@github.com:$GITHUB_REPOSITORY.git" \
    --package-name=$PACKAGE_NAME
fi
