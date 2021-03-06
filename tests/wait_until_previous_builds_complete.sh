#!/bin/bash
# Copyright 2016 VMware, Inc. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

unit_test_array=($TEST_URL_ARRAY)
numServers=${#unit_test_array[@]}
DRONE_BUILD_NUMBER=${DRONE_BUILD_NUMBER:=0}
prevBuildNumber=$(( $DRONE_BUILD_NUMBER-$numServers ))
prevBuildStatus=`drone build info --format='{{.Status}}' vmware/vic-product $prevBuildNumber`
echo prevBuildStatus $prevBuildStatus

while [[ $prevBuildStatus == *"running"* ]]; do
    echo "Waiting 5 minutes for build $prevBuildNumber to complete";
    sleep 300;
    prevBuildStatus=`drone build info --format='{{.Status}}' vmware/vic-product $prevBuildNumber`
    echo prevBuildStatus $prevBuildStatus
done
exit 0
